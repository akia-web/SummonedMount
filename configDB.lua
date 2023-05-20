
SummonedMount = LibStub("AceAddon-3.0"):NewAddon("SummonedMount", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

defaults = {
	profile = {
		selectOption = "favorites",
		buttonPosition= {x = 0, y = 0}
	},
}

local options = {
	name = "Summoned Mount",
	handler = SummonedMount,
	type = "group",
	args = {
		selectOption = {
			type = "select",
			name = "Liste de montures",
			desc = "Select an option",
			values = {
				["all"] = "Toutes mes montures",
				["favorites"] = "Mes montures favorites",
			},
			get = "GetSelectOption",
			set = "SetSelectOption",
		},
	},
}



function SummonedMount:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SummonedMountDB", defaults, true)
	AC:RegisterOptionsTable("SummonedMount_options", options)
	self.optionsFrame = ACD:AddToBlizOptions("SummonedMount_options", "Summoned Mount")
end


function SummonedMount:GetSelectOption(info)
	return self.db.profile.selectOption
end

function SummonedMount:SetSelectOption(info, value)
	selectedOptionMount = value
	self.db.profile.selectOption = value
	if value == "all" then
		MountButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_Swiftness")
		else
			MountButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
		end
end

