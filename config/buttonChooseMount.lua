local _,core = ...
core.ConfigDB = {}
core.SelectMount = {}

 function core.ConfigDB:getMount1()
	local mount1 = core.mount1Name
	if not mount1 then
		return core.yellowText(core.L['Monture']..'1: ')..core.L['NotSelectedMount']
	else
		return core.yellowText(core.L['Monture']..'1: ')..mount1
	end
end

function core.ConfigDB:getMount2()
	local mount2 = core.mount2Name
	if not mount2 then
		return core.yellowText(core.L['Monture']..'2: ')..core.L['NotSelectedMount']
	else
		return core.yellowText(core.L['Monture']..'2: ')..mount2
	end
end

local function filterMount(search, mount)
    if search ~= '' and string.find(mount, search) then
    return true
    else
    return false
    end
end

local function CreateIconTextureSelectMount(parent, iconName, idMount, iconSize, frameAllIcons, mountName, mount)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(iconSize, iconSize)

    button.texture = button:CreateTexture(nil, "ARTWORK")
    button.texture:SetAllPoints()
    

    button:SetNormalTexture(GetSpellTexture(iconName))

    button:SetScript("OnClick", function()
        
        local result = {mountName=mountName, mountId=idMount}
        if mount == core.L['Monture']..' 1' then
            core.SaveMount1(result)
            
        else
            core.SaveMount2(result)
        end
        core.getOptionFrame():Hide()
        core.SelectMount.ParentFrame:Hide()
        core.getOptionFrame():Show()
    end)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(core.greenText(mountName))
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    return button
end

local function PopulateSelectMonture(scrollChild, iconSize, numColumns, frameAllIcons, filtre, mount)
    local tableau = {}
    local numMounts = C_MountJournal.GetNumDisplayedMounts()
    for i = 1, numMounts do
        local name, spellID, _, _, isUsable, _, isFavorite, _, _, _, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(i)            
            if isCollected and filtre~=''then
                local mountIsInFilter = filterMount(string.lower(filtre), string.lower(name))
                    if mountIsInFilter then
                        table.insert(tableau, {mountID = mountID, spellID = spellID, mountName=name })
                    else
                    end
         
            elseif isCollected and filtre==''then
                table.insert(tableau, {mountID = mountID, spellID = spellID, mountName=name })
            end
    end

    local rowIndex, colIndex = 0, 0
    for _, item in ipairs(tableau) do
        local button = CreateIconTextureSelectMount(scrollChild, item['spellID'],item['mountID'], iconSize, frameAllIcons, item['mountName'], mount)
        button:SetPoint("TOPLEFT", colIndex * (iconSize + 4), -rowIndex * (iconSize + 4))

        colIndex = colIndex + 1
        if colIndex >= numColumns then
            colIndex = 0
            rowIndex = rowIndex + 1
        end
    end

    -- Ajuster la hauteur du ScrollChild en fonction du nombre de lignes d'icônes
    local numRows = math.ceil(#tableau / numColumns)
    local scrollChildHeight = numRows * (iconSize + 4)
    scrollChild:SetHeight(scrollChildHeight)
end

local function createScrollFrame(filter, mount)
	local scrollFrame = CreateFrame("ScrollFrame", "IconSelectorScrollFrame", core.SelectMount.ParentFrame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 16, -70)
	scrollFrame:SetPoint("BOTTOMRIGHT", -32, 30)
	
	local scrollChild = CreateFrame("Frame", "IconSelectorScrollChild", scrollFrame)
	scrollChild:SetSize(7 * (50 + 4), 0) -- La largeur doit correspondre à la largeur du ScrollFrame, la hauteur sera ajustée dynamiquement
	scrollFrame:SetScrollChild(scrollChild)
	PopulateSelectMonture(scrollChild, 50, 7, core.SelectMount.ParentFrame, filter, mount)
	return scrollFrame
end

local function OnKeyUpHandler(self, key, placeholderLabel, mount)
	if self:GetText() and self:GetText() ~= "" then
        placeholderLabel:Hide()
    else
        placeholderLabel:Show()
    end
	core.scrollFrame:Hide() 
	core.scrollFrame = createScrollFrame(self:GetText(), mount)
	core.scrollFrame:Show()
end

function core.ConfigDB:openPopupListMount(mount)
	
    core.SelectMount.ParentFrame = CreateFrame("Frame", "IconSelectorFrame", UIParent, "UIPanelDialogTemplate")
    core.SelectMount.ParentFrame:SetSize(425, 400)
    core.SelectMount.ParentFrame:SetPoint("CENTER")
    core.SelectMount.ParentFrame:SetClampedToScreen(true)
    core.SelectMount.ParentFrame:SetMovable(true)
    core.SelectMount.ParentFrame:EnableMouse(true)
    core.SelectMount.ParentFrame:RegisterForDrag("LeftButton")
    core.SelectMount.ParentFrame:SetScript("OnDragStart", core.SelectMount.ParentFrame.StartMoving)
    core.SelectMount.ParentFrame:SetScript("OnDragStop", core.SelectMount.ParentFrame.StopMovingOrSizing)
    core.SelectMount.ParentFrame:SetScript("OnHide", core.SelectMount.ParentFrame.StopMovingOrSizing)

    core.SelectMount.ParentFrame.title = core.SelectMount.ParentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    core.SelectMount.ParentFrame.title:SetPoint("TOPLEFT", 16, -10)
    core.SelectMount.ParentFrame.title:SetText(mount)
    core.SelectMount.ParentFrame:SetFrameStrata("HIGH")
    -- Créez un champ d'entrée (EditBox)
    local inputBox = CreateFrame("EditBox", "IconSelectorInputBox", core.SelectMount.ParentFrame, "InputBoxTemplate")
    inputBox:SetSize(200, 20)
    inputBox:SetPoint("TOPLEFT", core.SelectMount.ParentFrame.title, "BOTTOMLEFT", 0, -10)  -- Ajustez la position en fonction de vos besoins
    inputBox:SetAutoFocus(false)  -- Empêche l'autofocus à la création (pour que l'utilisateur doive cliquer pour éditer)
    
    local placeholderLabel = core.SelectMount.ParentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    placeholderLabel:SetPoint("TOPLEFT", inputBox, "TOPLEFT", 5, -5)
    placeholderLabel:SetText(core.L['SearchByName'])
    core.scrollFrame = createScrollFrame('', mount)
    inputBox:SetScript("OnKeyUp", function(self, key)
        OnKeyUpHandler(self, key, placeholderLabel, mount)end)
    core.SelectMount.ParentFrame:Show()
    return core.SelectMount.ParentFrame
end