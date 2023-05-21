loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Événement déclenché lorsque le joueur entre en combat
loginFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

function createButtonFrame() 
    local MountButton = CreateFrame("Button", "MyDraggableButton", UIParent, "UIPanelButtonTemplate")
    MountButton:SetMovable(true)
    MountButton:EnableMouse(true)
    MountButton:RegisterForDrag("LeftButton")
    MountButton:SetPoint(buttonPosition.point, UIParent,buttonPosition.relativePoint, buttonPosition.x , buttonPosition.y)
    MountButton:SetSize(iconeSize, iconeSize)
    if selectedOptionMount == "all" then
    MountButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_Swiftness")
    else
        MountButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
    end
    -- local point, relativeTo, relativePoint, x, y = MountButton:GetPoint()
    -- print("point:"..point.. " ,relativeTo: "..relativeTo.." relativePoint: "..relativePoint.." x:"..x.." y: "..y )
    -- print(point)
    -- print(relativePoint)
    -- print(x)
    -- print(y)
  return MountButton
end