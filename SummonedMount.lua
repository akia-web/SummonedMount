local NamePlayer = UnitName("player")
local LevelPlayer = UnitLevel("player")
print("hello ".. NamePlayer.." niveau ".. LevelPlayer)
mountIdInvoqueLast = 0

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
                param = "Volante"
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

local function UpdateButtonState(button, event)
    if event == "PLAYER_REGEN_DISABLED" then
        button:GetNormalTexture():SetDesaturated(true)
        button:Disable()
    else
        button:Enable()
        button:GetNormalTexture():SetDesaturated(false)
    end
end

loginFrame:SetScript("OnEvent", function(self, event, ...)

    
    if event == "PLAYER_LOGIN" then
        selectedOptionMount = SummonedMount.db.profile.selectOption
        buttonPosition = SummonedMount.db.profile.buttonPosition
        iconeSize = SummonedMount.db.profile.iconeSize
        choiceIcone = SummonedMount.db.profile.icone

        MountButton = createButtonFrame()
        
        MountButton:SetScript("OnDragStart", function(self)
            if IsControlKeyDown() then
                self:StartMoving()
            end
        end)
        

        MountButton:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local point, _, relativePoint, x, y = self:GetPoint()
            local buttonPosition = SummonedMount.db.profile.buttonPosition
            buttonPosition.point = point
            buttonPosition.relativePoint = relativePoint
            buttonPosition.x = x
            buttonPosition.y = y
            SummonedMount.db.profile.buttonPosition = buttonPosition
        end)

        MountButton:SetScript("OnMouseDown", function(self, button)
            if IsControlKeyDown()then
            elseif IsShiftKeyDown() and button == "LeftButton" then
                local newOption  = selectedOptionMount == "all" and "favorites" or "all"
                SummonedMount:SetSelectOption(nil, newOption)
                
                if newOption == "all" then
                MountButton:SetNormalTexture(choiceIcone)
                end

            elseif IsAltKeyDown() and button == "LeftButton" then
                createFrameContainerIcone()
        else
                if button == "MiddleButton" then
                    C_MountJournal.SummonByID(460)
                    mountIdInvoqueLast = 460
                    return
                end
            
                getMount(button, selectedOptionMount)
            end
        end)

        local numberInstance = GetNumSavedInstances()
        print(numberInstance)
        for i = 1, numberInstance do
            local name, lockoutId, reset, difficultyId, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceId = GetSavedInstanceInfo(i)

            if locked  then
                local time;
                if reset < 86400 then
                    time = math.floor(reset/3600).."heures"
                else 
                    time = math.floor(reset/86400).."jours "
                end

                print("Instance déjà faite cette semaine :".. name.."reset : ".. time )
            end
        end

        print(C_QuestLog.IsQuestFlaggedCompleted(50599) )
        -- local info = C_MountJournal.GetMountInfoByID(69)
        -- print(info)

        local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isForDragonriding = C_MountJournal.GetMountInfoByID(69)
        print("Nom de la monture :", name)
        print("Est collectée :", isCollected)



        local numMounts = C_MountJournal.GetNumDisplayedMounts()
        for i = 1, numMounts do
            local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID, isForDragonriding = C_MountJournal.GetDisplayedMountInfo(i)
            
         local creatureDisplayInfoID, description, source, isSelfMount, mountTypeID,
         uiModelSceneID, animID, spellVisualKitID, disablePlayerMountPreview= C_MountJournal.GetMountInfoExtraByID(mountID)
            
            
            if not isCollected and sourceType ==1 then
                print("name : ".. name.."type: "..source.Butin )
            end
        end


       








    end
    if event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
        UpdateButtonState(MountButton, event)
    end

end)








