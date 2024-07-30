local _, core = ...

local function CreateIconTexture(parent, iconName, iconSize, frameAllIcons)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(iconSize, iconSize)

    button.texture = button:CreateTexture(nil, "ARTWORK")
    button.texture:SetAllPoints()

    local iconTexture = "Interface\\Icons\\" .. iconName
    if iconTexture then
        button.texture:SetTexture(iconTexture)
    end

    button:SetScript("OnClick", function()
        frameAllIcons:Hide()
        core.SaveOptions.SetIcone(iconName)
    end)
    return button
end

function core.Functions.PopulateIconSelector(scrollChild, iconSize, numColumns, frameAllIcons)
    local rowIndex, colIndex = 0, 0
    for _, item in ipairs(core.iconNames) do
        local button = CreateIconTexture(scrollChild, item, iconSize, frameAllIcons)
        button:SetPoint("TOPLEFT", colIndex * (iconSize + 4), -rowIndex * (iconSize + 4))

        colIndex = colIndex + 1
        if colIndex >= numColumns then
            colIndex = 0
            rowIndex = rowIndex + 1
        end
    end

    -- Ajuster la hauteur du ScrollChild en fonction du nombre de lignes d'icônes
    local numRows = math.ceil(#core.iconNames / numColumns)
    local scrollChildHeight = numRows * (iconSize + 4)
    scrollChild:SetHeight(scrollChildHeight)
end

