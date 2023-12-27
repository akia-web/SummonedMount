local _,core = ...;
local SUMMONEDMOUNT_MM = LibStub("AceAddon-3.0"):NewAddon("SUMMONEDMOUNT_MM ", "AceConsole-3.0")
local SUMMONEDMOUNT_LDB = LibStub("LibDataBroker-1.1"):NewDataObject("SUMMONEDMOUNT!", {
	type = "data source",
	text = "SUMMONEDMOUNT",
    
	icon = "Interface\\Icons\\Achievement_guildperk_mountup",
	OnClick = function(_, button) 
        
    if button == "LeftButton" then
        InterfaceOptionsFrame_OpenToCategory(core.getOptionFrame());
    end       
	end,
    OnTooltipShow = function (tooltip)
        tooltip:AddLine ("Summoned Mount", 1, 1, 1)
    end,
})
local icon = LibStub("LibDBIcon-1.0")
function SUMMONEDMOUNT_MM:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SUMMONEDMOUNTMMDB", { profile = { minimap = { hide = false, }, }, }) icon:Register("SUMMONEDMOUNT!", SUMMONEDMOUNT_LDB, self.db.profile.minimap)
end