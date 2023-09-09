

function createButtonFrame() 
    local MountButton = CreateFrame("Button", "MyDraggableButton", UIParent, "SecureActionButtonTemplate")
    -- local MountButton = CreateFrame("Button", "MyDraggableButton", UIParent, "UIPanelButtonTemplate")
    
    MountButton:SetMovable(true)
    MountButton:EnableMouse(true)
    MountButton:RegisterForDrag("LeftButton")
    MountButton:SetPoint(buttonPosition.point, UIParent,buttonPosition.relativePoint, buttonPosition.x , buttonPosition.y)
    MountButton:SetSize(iconeSize, iconeSize)



    if selectedOptionMount == "all" then
    MountButton:SetNormalTexture(choiceIcone)
    else
        MountButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
    end


    MountButton:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(
          GREEN_FONT_COLOR_CODE.."Clic gauche : |cFFFFFF00 dépends de l'environnement.\n"
        ..GREEN_FONT_COLOR_CODE.."Clic droit : |cFFFFFF00 Ne dépends pas de l'environnement. \n"
        ..GREEN_FONT_COLOR_CODE.."Clic milieu : |cFFFFFF00 Vendeur. \n"
        ..GREEN_FONT_COLOR_CODE.."Clic + CTRL : |cFFFFFF00 Déplace le bouton. \n"
        ..GREEN_FONT_COLOR_CODE.."Clic + MAJ : |cFFFFFF00 Change la liste de monture (favoris ou toutes).\n"
        ..GREEN_FONT_COLOR_CODE.."Clic Gauche + ALT : |cFFFFFF00 Choisir une icone pour toutes les montures. \n"
      )
      GameTooltip:Show()
  end)
  
  MountButton:SetScript("OnLeave", function(self)
      GameTooltip:Hide()
  end)

  return MountButton
end

function createFrameContainerIcone()
  local frame = CreateFrame("Frame", "IconSelectorFrame", UIParent, "UIPanelDialogTemplate")
frame:SetSize(425, 400)
frame:SetPoint("CENTER")
frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetScript("OnHide", frame.StopMovingOrSizing)

frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("TOPLEFT", 16, -10)
frame.title:SetText("Sélection d'icône")
frame:SetFrameStrata("HIGH")

local iconSize = 50
local numColumns = 7

local scrollFrame = CreateFrame("ScrollFrame", "IconSelectorScrollFrame", frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 16, -40)
scrollFrame:SetPoint("BOTTOMRIGHT", -32, 30)

local scrollChild = CreateFrame("Frame", "IconSelectorScrollChild", scrollFrame)
scrollChild:SetSize(numColumns * (iconSize + 4), 0) -- La largeur doit correspondre à la largeur du ScrollFrame, la hauteur sera ajustée dynamiquement
scrollFrame:SetScrollChild(scrollChild)

local function CreateIconTexture(parent, iconName)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(iconSize, iconSize)

    button.texture = button:CreateTexture(nil, "ARTWORK")
    button.texture:SetAllPoints()

    local iconTexture = "Interface\\Icons\\"..iconName
    if iconTexture then
        button.texture:SetTexture(iconTexture)
    end

    button:SetScript("OnClick", function()
        frame:Hide()
        SummonedMount:SetIcone(iconName)
        choiceIcone = SummonedMount.db.profile.icone
    end)

    return button
end

local function PopulateIconSelector()
    local rowIndex, colIndex = 0, 0
    for _, item in ipairs(iconNames) do
        local button = CreateIconTexture(scrollChild, item)
        button:SetPoint("TOPLEFT", colIndex * (iconSize + 4), -rowIndex * (iconSize + 4))

        colIndex = colIndex + 1
        if colIndex >= numColumns then
            colIndex = 0
            rowIndex = rowIndex + 1
        end
    end

    -- Ajuster la hauteur du ScrollChild en fonction du nombre de lignes d'icônes
    local numRows = math.ceil(#iconNames / numColumns)
    local scrollChildHeight = numRows * (iconSize + 4)
    scrollChild:SetHeight(scrollChildHeight)
end

PopulateIconSelector()


end

