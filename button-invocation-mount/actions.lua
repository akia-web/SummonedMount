local _,core = ...

function core.Functions.getActionControlKeyDown()
            Dismount()
            C_Timer.After(0.2, function ()
                if core.mount2Id then
                    C_MountJournal.SummonByID(core.mount2Id)
                    core.mountIdInvoqueLast = core.mount2Id
                end 
        end )
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
    Dismount()
    C_Timer.After(0.2, function ()
        if core.mount1Id then
            C_MountJournal.SummonByID(core.mount1Id)
            core.mountIdInvoqueLast = core.mount1Id
            core.mountIdInvoqueLast = core.mount1Id
        end 
    end )

end

local function summonMount(param)
    local listmounts  = core.Functions.getListMountByOption(core.selectedOptionMount)
    local list;
    local idMountNumber= ''
    local playerLevel = UnitLevel('player')

    if playerLevel < 10 then
        list = listmounts
    else 
        list = core.Functions.sortListByParam(listmounts, param)
    end

    if #list == 0 then
        local errorMessage = ''
        if core.selectedOptionMount == 'favorites' then
            errorMessage  = core.L['NotMountFound']..' '..param..core.L['InList']
        else
            errorMessage = core.L['NotMountFound']..' '..param
        end

        UIErrorsFrame:AddMessage(errorMessage, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000" .. errorMessage)
    end
 
    if #list == 1 then
        idMountNumber = list[1]['mountID']
    elseif #list == 0 then
    else
        repeat
            idMountNumber = core.Functions.getRandomMount(list)
        until idMountNumber ~= core.mountIdInvoqueLast
    end

    if IsMounted() and idMountNumber ~= core.mountIdInvoqueLast then
        Dismount()
    end

    if idMountNumber ~= ''then
        C_MountJournal.SummonByID(idMountNumber)
        core.mountIdInvoqueLast = idMountNumber 
    end

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