local _,core = ...;
core.mountIdInvoqueLast = 0

local loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Événement déclenché lorsque le joueur entre en combat
loginFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
loginFrame:RegisterEvent("PLAYER_STARTED_MOVING")
loginFrame:RegisterEvent("PLAYER_STOPPED_MOVING")

function UpdateButtonState(button, event)
    if event == "PLAYER_REGEN_DISABLED"  or event == "interieur" then 
        button:GetNormalTexture():SetDesaturated(true)
        button:Disable()
    else
        button:Enable()
        button:GetNormalTexture():SetDesaturated(false)
    end
end

local function UpdateMountAvailability()
    if not UnitAffectingCombat('player')then
        if IsIndoors() then
            UpdateButtonState(core.MountButton, "interieur")
        else
            UpdateButtonState(core.MountButton, "exterieur")
        end
    end
   
end

local ticker
loginFrame:SetScript("OnEvent", function(self, event, ...)
    
    if event == "PLAYER_LOGIN" then
        core.MountButton = core.Functions.createButtonFrame()
    end

    UpdateMountAvailability() -- Effectuer une verification a la connexion
    
    if event == "PLAYER_STARTED_MOVING" then
        -- Démarrer le ticker lorsque le joueur commence à se déplacer
        ticker= C_Timer.NewTicker(1, UpdateMountAvailability)
    end

    if event == "PLAYER_STOPPED_MOVING" then
        -- Arrêter le ticker lorsque le joueur s'arrête de bouger
        ticker:Cancel()
        UpdateMountAvailability() -- Effectuer une dernière vérification
    end

    if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
       UpdateButtonState(core.MountButton, event)
    end

end)








