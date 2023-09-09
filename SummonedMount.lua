local NamePlayer = UnitName("player")
local LevelPlayer = UnitLevel("player")
print("hello ".. NamePlayer.." niveau ".. LevelPlayer)
local playerClass = select(2, UnitClass("player"))
local _,core = ...;
local mountIdInvoqueLast = 0

local loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Événement déclenché lorsque le joueur entre en combat
loginFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
loginFrame:RegisterEvent("PLAYER_STARTED_MOVING")
loginFrame:RegisterEvent("PLAYER_STOPPED_MOVING")

-- Fonction pour récupérer les types de montures
local function GetTypeMounts(mountID)
    local _, _, _, _, mountTypeID,_, _, _, _ = C_MountJournal.GetMountInfoExtraByID(mountID);

        if mountTypeID == 247 or mountTypeID == 248 or mountTypeID == 398 then
            return "Volante";
        elseif mountTypeID == 231 or mountTypeID == 232 or mountTypeID == 254 or mountTypeID == 407 or mountTypeID == 412 then
            return "aquatique"
        elseif mountTypeID == 230 then
            return "terrestre"
        elseif mountTypeID == 402 then
            return "dragonriding"
        else
            return  "Inconnu"
        end
end
-- Fonction pour récupérer les montures favorites du joueur
local function getListMountByOption(param)
    local numMounts = C_MountJournal.GetNumDisplayedMounts()
    local favoriteMounts = {}

    for i = 1, numMounts do
        local name, spellID, _, _, isUsable, _, isFavorite, _, _, _, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
        if isUsable then
            if param== "favorites" and isFavorite then
                local typeMount= GetTypeMounts(mountID);

                table.insert(favoriteMounts, {mountID,typeMount, name, spellID})
            end

            if param == "all" and isCollected then
                local typeMount= GetTypeMounts(mountID);

                table.insert(favoriteMounts, {mountID,typeMount, name, spellID})
            end
        end
    end

    return favoriteMounts
end

local function sortListByParam(tableau, type)
    local mount = {}

    for _, monture in ipairs(tableau) do
        if monture[2] == type then
            table.insert(mount, monture)
        end
    end

    return mount
end

local function getRandomMount(tableau)
    local random = math.random(1, #tableau)
    local chiffre = tableau[random][1]
    return chiffre
end

local function getMount(paramButton, selectedOptionMount)
    if selectedOptionMount and (selectedOptionMount == "favorites" or selectedOptionMount == "all") then
        local Listmounts;
        Listmounts  = getListMountByOption(selectedOptionMount)
        local param = ""
        
        if paramButton == "LeftButton" then    
            if IsSwimming() then
                param = "aquatique"
            elseif  IsAdvancedFlyableArea() then
                param = "dragonriding"
            elseif IsFlyableArea() then
                local expertCavalier =  IsPlayerSpell(34090)
                local maitreCavalier = IsPlayerSpell(90265)
                if expertCavalier  or maitreCavalier then
                    param = "Volante"
                else
                    param  = "terrestre"
                end
                
            else
                param = "terrestre"
            end
        end

        if paramButton == "RightButton" then
            if IsFlyableArea() then
                param = "Volante"
            elseif IsAdvancedFlyableArea() and IsSwimming()  then
                param = "dragonriding"
            else
                param = "terrestre"
            end
        end

        local list = sortListByParam(Listmounts, param)
        local idMountNumber= getRandomMount(list)

        if #list == 1 then
            idMountNumber = list[1][1]
        else
            repeat
                idMountNumber = getRandomMount(list)
            until idMountNumber ~= mountIdInvoqueLast
        end
        if IsMounted() and idMountNumber ~= mountIdInvoqueLast then
            Dismount()
            C_MountJournal.SummonByID(idMountNumber)
            mountIdInvoqueLast = idMountNumber
        elseif not IsMounted() then
         
            C_MountJournal.SummonByID(idMountNumber)
            mountIdInvoqueLast = idMountNumber
        end

    end
end

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
        selectedOptionMount = SummonedMount.db.profile.selectOption
        buttonPosition = SummonedMount.db.profile.buttonPosition
        iconeSize = SummonedMount.db.profile.iconeSize
        choiceIcone = SummonedMount.db.profile.icone
        core.MountButton = createButtonFrame()
     

        core.MountButton:SetScript("OnDragStart", function(self)
            if IsControlKeyDown() then
                self:StartMoving()
            end
        end)
        

        core.MountButton:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local point, _, relativePoint, x, y = self:GetPoint()
            local buttonPosition = SummonedMount.db.profile.buttonPosition
            buttonPosition.point = point
            buttonPosition.relativePoint = relativePoint
            buttonPosition.x = x
            buttonPosition.y = y
            SummonedMount.db.profile.buttonPosition = buttonPosition
        end)

        core.MountButton:SetScript("OnMouseDown", function(self, button)
            if IsControlKeyDown()then
            elseif IsShiftKeyDown() and button == "LeftButton" then
                local newOption  = selectedOptionMount == "all" and "favorites" or "all"
                SummonedMount:SetSelectOption(nil, newOption)
                
                if newOption == "all" then
                    core.MountButton:SetNormalTexture(choiceIcone)
                end

            elseif IsAltKeyDown() and button == "LeftButton" then
                createFrameContainerIcone()
        else
            local playerClass = select(2, UnitClass("player"))

            if playerClass == "DRUID" then
                core.MountButton:RegisterForClicks("LeftButtonDown","RightButtonDown", "MiddleButtonDown")
               local macroIndex = GetMacroIndexByName('akiachangeform')

               if macroIndex == 0 then
                CreateMacro('akiachangeform', 1394966, '/cancelform')
                macroIndex = GetMacroIndexByName('akiachangeform')
               end

               local formeID = GetShapeshiftFormID()
               
               if formeID == nil or (formeID >= 31 and formeID <= 34) then
                core.MountButton:SetAttribute("type","click")  
                core.MountButton:SetAttribute("macro",nil)
                else
                    core.MountButton:SetAttribute("type", "macro")
                    core.MountButton:SetAttribute("macro",macroIndex)
                end
             
            end

                if button == "MiddleButton" then
                    C_Timer.After(0.1, function ()
                        C_MountJournal.SummonByID(460)
                    end )
                    mountIdInvoqueLast = 460
                    return
                end

                    C_Timer.After(0.1, function ()
                        getMount(button, selectedOptionMount)
                    end )

            end
        end)

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








