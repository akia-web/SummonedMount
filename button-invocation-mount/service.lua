local _,core= ...;
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

-- Fonction pour récupérer les montures du joueur
function core.Functions.getListMountByOption(param)
    local numMounts = C_MountJournal.GetNumDisplayedMounts()
    local mountResult = {}

    for i = 1, numMounts do
        local name, spellID, _, _, isUsable, _, isFavorite, _, _, _, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)
        if isUsable then
            if param== "favorites" and isFavorite then
                local typeMount = GetTypeMounts(mountID);
                table.insert(mountResult, {mountID = mountID, typeMount = typeMount, name = name, spellID = spellID})
            end

            if param == "all" and isCollected then
                local typeMount = GetTypeMounts(mountID);
                table.insert(mountResult, {mountID = mountID, typeMount = typeMount, name = name, spellID = spellID})
            end
        end
    end

    return mountResult
end

function core.Functions.sortListByParam(tableau, type)
    local mountResult = {}
    for _, mount in ipairs(tableau) do
        if mount['typeMount'] == type then
            table.insert(mountResult, mount)
        end
    end

    return mountResult
end

function core.Functions.getRandomMount(tableau)

        local random = math.random(1, #tableau)
        local mountRandom = tableau[random]['mountID']
        return mountRandom
end

function core.Functions.getLeftButtonParams()
    if IsSwimming() then
        return "aquatique"
    elseif  IsAdvancedFlyableArea() then
      return "dragonriding"
    elseif IsFlyableArea() then
        local expertCavalier =  IsPlayerSpell(34090)
        local maitreCavalier = IsPlayerSpell(90265)
        if expertCavalier  or maitreCavalier then
           return "Volante"
        else
            return "terrestre"
        end
    else
       return "terrestre"
    end
end

function core.Functions.getRightButtonParams()
    if IsFlyableArea() then
        return "Volante"
    elseif IsAdvancedFlyableArea() and IsSwimming()  then
        return "dragonriding"
    else
        return "terrestre"
    end
end

function core.Functions.hasSpecialKeys()
    if IsControlKeyDown() or IsShiftKeyDown() or IsAltKeyDown() then
        return true
    else
        return false
    end
end