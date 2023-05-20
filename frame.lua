loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")

function createButtonFrame() 
    local MountButton = CreateFrame("Button", "MyDraggableButton", UIParent, "UIPanelButtonTemplate")
    MountButton:SetMovable(true)
    MountButton:EnableMouse(true)
    MountButton:RegisterForDrag("LeftButton")
    MountButton:SetPoint("CENTER", buttonPosition.x , buttonPosition.y)
    MountButton:SetSize(35, 35)
    if selectedOptionMount == "all" then
    MountButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_Swiftness")
    else
        MountButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
    end
  return MountButton
end