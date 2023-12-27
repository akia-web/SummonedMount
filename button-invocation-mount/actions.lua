local _,core = ...

function core.Functions.getActionControlKeyDown(button)
    if button == "MiddleButton" then
        C_Timer.After(0.1, function ()
                C_MountJournal.SummonByID(460)
            end )
            core.mountIdInvoqueLast = 460
            return
    end
end

function core.Functions.changeListMount()
    local newOption  = core.selectedOptionMount == "all" and "favorites" or "all"
    core.SaveOptions.ListMount(newOption)
    if newOption == "all" then
    core.MountButton:SetNormalTexture(core.choiceIcone)
    end
end

function core.Functions.playerIsADruid()

    local playerClass = select(2, UnitClass("player"))

    if playerClass == "DRUID" then
        core.MountButton:RegisterForClicks("LeftButtonDown","RightButtonDown", "MiddleButtonDown")
    local macroIndex = GetMacroIndexByName('akiachangeform')

    if macroIndex == 0 then
        CreateMacro('akiachangeform', 1394966, '/cancelform')
        macroIndex = GetMacroIndexByName('akiachangeform')
    end

    local formeID = GetShapeshiftFormID()

    if formeID == nil or (formeID >= 31 and formeID <= 35) then
        core.MountButton:SetAttribute("type","click")  
        core.MountButton:SetAttribute("macro",nil)
        else
            core.MountButton:SetAttribute("type", "macro")
            core.MountButton:SetAttribute("macro",macroIndex)
        end
    
    end
end

function core.Functions.getActionSimpleMiddleButton()
    -------- pour le balais halloween-----------
    -- local time = 0.1

    -- -- ne remount pas sur le balais si yack
    -- if core.mountIdInvoqueLast == 460 then
    --     time = 0.5
    -- end
    -- C_Timer.After(time, function ()
    --     C_MountJournal.SummonByID(1799)
    -- end )
    Dismount()
    C_Timer.After(0.1, function ()
        C_MountJournal.SummonByID(460)
    end )
    core.mountIdInvoqueLast = 460
end

local function summonMount(param)
    local listmounts  = core.Functions.getListMountByOption(core.selectedOptionMount)
    local list = core.Functions.sortListByParam(listmounts, param)
    local idMountNumber= ''

    if #list == 0 then
        local errorMessage = ''
        if core.selectedOptionMount == 'favorites' then
            errorMessage  = "Pas de monture de type "..param.." trouvé dans la liste des montures favorites \n Merci de changer de liste en faisant SHIFT + click Gauche ou directement dans les options de l'addon"
        else
            errorMessage = "Pas de montures trouvé de type "..param
        end
      
        UIErrorsFrame:AddMessage(errorMessage, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. errorMessage)
    end

    if #list == 1 then
        idMountNumber = list[1]['mountID']
    else
        repeat
            idMountNumber = core.Functions.getRandomMount(list)
        until idMountNumber ~= core.mountIdInvoqueLast
    end

    if IsMounted() and idMountNumber ~= core.mountIdInvoqueLast then
        Dismount()
    end

    C_MountJournal.SummonByID(idMountNumber)
    core.mountIdInvoqueLast = idMountNumber
end

function core.Functions.getActionSimpleLeftButton()
    if core.selectedOptionMount and (core.selectedOptionMount == "favorites" or core.selectedOptionMount == "all") then
        local param = core.Functions.getLeftButtonParams()
        summonMount(param)       
    end
end

function core.Functions.getActionSimpleRightButton()
    if core.selectedOptionMount and (core.selectedOptionMount == "favorites" or core.selectedOptionMount == "all") then
        local param = core.Functions.getRightButtonParams()
        summonMount(param)       
    end
end