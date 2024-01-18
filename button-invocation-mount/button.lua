local _,core = ...

local function scriptStartDrag(mountButton)
    mountButton:SetScript("OnDragStart", function(self)
        if IsControlKeyDown() then
            self:StartMoving()
        end
    end)
end

local function scriptStopDrag(mountButton)
    mountButton:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relativePoint, x, y = self:GetPoint()
        core.buttonPosition.point = point
        core.buttonPosition.relativePoint = relativePoint
        core.buttonPosition.x = x
        core.buttonPosition.y = y
        core.SaveOptions.ButtonPosition(core.buttonPosition)
    end)
end

local function scriptOnMouseDown(mountButton)
    mountButton:SetScript("OnMouseDown", function(self, button)

            if IsShiftKeyDown() and button == "LeftButton" then
                core.Functions.changeListMount()
                return
            end

            if IsAltKeyDown() and button == "LeftButton" then
                core.Functions.createFrameContainerIcone()
                return
            end

            core.Functions.playerIsADruid()

            if IsControlKeyDown() and button == "MiddleButton" then
                core.Functions.getActionControlKeyDown()
                return
            end

            if button == "MiddleButton" then
                core.Functions.getActionSimpleMiddleButton()
                return
                
            end
       

            if button == "LeftButton" and not core.Functions.hasSpecialKeys() then
                core.Functions.getActionSimpleLeftButton()
                return
            end

            if button == "RightButton" and not core.Functions.hasSpecialKeys() then
                core.Functions.getActionSimpleRightButton()
                return
            end

    end)
end


function core.Functions.createButtonFrame() 
  
    local summonButton = CreateFrame("Button", "MyDraggableButton", UIParent, "SecureActionButtonTemplate")   
    summonButton:SetMovable(true)
    summonButton:EnableMouse(true)
    summonButton:RegisterForDrag("LeftButton")
    summonButton:SetPoint(core.buttonPosition.point, UIParent,core.buttonPosition.relativePoint, core.buttonPosition.x , core.buttonPosition.y)
    summonButton:SetSize(core.iconeSize, core.iconeSize)

    if core.selectedOptionMount == "all" then
        summonButton:SetNormalTexture(core.choiceIcone)
    else
        summonButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
    end

    summonButton:SetScript("OnEnter", function(self)
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
  
  summonButton:SetScript("OnLeave", function(self)
      GameTooltip:Hide()
  end)
  scriptStartDrag(summonButton)
  scriptStopDrag(summonButton)
  scriptOnMouseDown(summonButton)
  return summonButton
end