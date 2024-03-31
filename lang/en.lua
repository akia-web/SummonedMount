local _,core = ...;
if GetLocale() ~= "frFR" then
    local L = {}
 
    L["LeftClick"] = "Left Click: "
    L["RightClick"] = "Right Click: "
    L["MiddleClick"] = "Middle Click: "
    L["CtrlClick"] = "CTRL + Click: "
    L["ShiftClick"] = "SHIFT + Click: "
    L["CtrlClick"] = "CTRL + Click: "
    L["CTRLMiddleClick"] = "CTRL +Middle Click: "
    L["AltLeftClick"] = "ALT + left Click: "
    L["CommandList"]="Command list"
    L["SizeIcon"]="Icon size"
    
    L["InfoLeftClick"]="Summon a mount depending on the environment"
    L["MoreInfoLeftClick"]="earthly if you  are unable to fly, aquatic if you are in water, dragon-riding if you can dragon-ride or flying in other cases"
    L["InfoRightClick"]="Summon a flying mount"
    L["InfoMiddleClick"]="Summon a mount of your choice"
    L["InfoCTRLMiddleClick"]="Summon an other mount of your choice"
    L["InfoCtrlClick"]="Moves summon button"
    L["InfoShiftClick"]="Switch between all mount and favorites list"
    L["InfoAltLeftClick"]="Choose an icon for your all mounts list"

    L["Monture"]="Mount"
    L["NotSelectedMount"]="you havn't chosen a mount"
    L['ChooseMount']="Choose mount"
    L['SearchByName']="Search by name..."
    L['NotMountFound']="Not mounts found for type"
    L['InList']=" in favorites mounts list \n you can change list with SHIFT + left click on summon button or in addon options"
    L['All']="All mounts"
    L['MountList']="Mounts list"
    L['FavoriteMounts']="My favorites mounts"
    core.L = L
 end