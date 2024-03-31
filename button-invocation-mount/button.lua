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
      GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT")
      GameTooltip:SetText(
          core.greenText(core.L['LeftClick'])..core.yellowText(core.L['InfoLeftClick'])..'\n'
          ..core.greenText(core.L['RightClick'])..core.yellowText(core.L['InfoRightClick'])..'\n'
          ..core.greenText(core.L['MiddleClick']).. core.yellowText(core.L['InfoMiddleClick'])..'\n'
          ..core.greenText(core.L['CTRLMiddleClick']).. core.yellowText(core.L['InfoCTRLMiddleClick'])..'\n'
          ..core.greenText(core.L['CtrlClick']).. core.yellowText(core.L['InfoCtrlClick'])..'\n'
         ..core.greenText(core.L['ShiftClick']).. core.yellowText(core.L['InfoShiftClick'])..'\n'
         ..core.greenText(core.L['AltLeftClick']).. core.yellowText(core.L['InfoAltLeftClick'])..'\n'
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