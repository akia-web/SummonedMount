local _,core = ...
core.SaveOptions = {}
core.Functions = {}

local SummonedMount = LibStub("AceAddon-3.0"):NewAddon("SummonedMount", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
SummonedMount.Events = CreateFromMixins(EventRegistry)
SummonedMount.Events:OnLoad()
SummonedMount.Events:SetUndefinedEventsAllowed(true)

local defaults = {
	profile = {
		selectOption = "all",
		buttonPosition= {point= "CENTER", relativePoint="CENTER",  x = 0, y = 0},
		iconeSize = 35,
		icone =  "Interface\\Icons\\spell_Nature_Swiftness",
		rafraichirOptions = { ... },
		icone4="spell_Nature_Swiftness",
		mount1Name=nil,
		mount1Id=nil,
		mount2Name=nil,
		mount2Id=nil
	},
}



local options = {
	name = "Summoned Mount",
	handler = SummonedMount,
	type = "group",
	args = {
		selectOption = {
			order=1,
			type = "select",
			name = core.L['MountList'],
			desc = "Select an option",
			values = {
				["all"] = core.L['All'],
				["favorites"] = core.L['FavoriteMounts'],
			},
			get = "GetSelectOption",
			set = "SetSelectOption",
		},
		ghostDescription = {
			order=2,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		tailleIcone = {
			order=3,
			type = "input",
			name = core.L['SizeIcon'],
			desc = "",
			get = "GetTailleIcone",
			set = "SetTailleIcone",
			pattern = "%d",
		},
		ghostDescription2 = {
			order=4,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		mount1 = {
			order=5,
			fontSize = "medium",
			type = "description",
			name = function ()return core.ConfigDB:getMount1()end,
			cmdHidden = true
		},
		searchMount1 = {
            order = 6,
			type = "execute",
			name= core.L['ChooseMount']..' 1',
			func = function() core.ConfigDB:openPopupListMount(core.L['Monture']..' 1') end,
        },
		ghostDescription3 = {
			order=7,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		mount2 = {
			order=8,
			fontSize = "medium",
			type = "description",
			name = function ()return core.ConfigDB:getMount2()end,
			cmdHidden = true
		},
		searchMount2 = {
            order = 9,
			type = "execute",
			name= core.L['ChooseMount']..' 2',
			func = function() core.ConfigDB:openPopupListMount(core.L['Monture']..' 2') end,
        },

		setskinheader = {
			order=10,
			type = "header",
			name = core.L['CommandList'],
		},

		ghostDescription4 = {
			order=11,
			type = "description",
			name = "   ",
			cmdHidden = true
		},

		confLeftClick = {
			order=12,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['LeftClick']) .. core.yellowText(core.L['InfoLeftClick']) .. core.orangeText(core.L['MoreInfoLeftClick']),
			cmdHidden = true
		},

		ghostDescription5 = {
			order=13,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confRightClic = {
			order=14,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['RightClick'])..core.yellowText(core.L['InfoRightClick']),
			cmdHidden = true
		},
		ghostDescription6 = {
			order=15,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confMiddleClick = {
			order=16,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['MiddleClick'])..core.yellowText(core.L['InfoMiddleClick']),
			cmdHidden = true
		},
		confCtrlMiddleClick = {
			order=17,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['CTRLMiddleClick'])..core.yellowText(core.L['InfoCTRLMiddleClick']),
			cmdHidden = true
		},
		ghostDescription7 = {
			order=18,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confCtrlClick = {
			order=19,
			fontSize = "medium",
			type = "description",
			name =  core.greenText(core.L['CtrlClick'])..core.yellowText(core.L['InfoCtrlClick']),
			cmdHidden = true
		},

		ghostDescription8 = {
			order=20,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confMajClick = {
			order=21,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['ShiftClick'])..core.yellowText(core.L['InfoShiftClick']),
			cmdHidden = true
		},
		ghostDescription9 = {
			order=22,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confAltClick = {
			order=23,
			fontSize = "medium",
			type = "description",
			name = core.greenText(core.L['AltLeftClick'])..core.yellowText(core.L['InfoAltLeftClick']),
			cmdHidden = true
		},

	},
}

function SummonedMount:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SummonedMountDB", defaults, true)
	AC:RegisterOptionsTable("SummonedMount_options", options)
	self.optionsFrame = ACD:AddToBlizOptions("SummonedMount_options", "SummonedMount")
	core.selectedOptionMount = SummonedMount.db.profile.selectOption
	core.buttonPosition = SummonedMount.db.profile.buttonPosition
	core.iconeSize = SummonedMount.db.profile.iconeSize
	core.choiceIcone = SummonedMount.db.profile.icone
	core.selectedOptionMount = SummonedMount.db.profile.selectOption
	core.mount1Name = SummonedMount.db.profile.mount1Name
	core.mount1Id = SummonedMount.db.profile.mount1Id
	core.mount2Name = SummonedMount.db.profile.mount2Name
	core.mount2Id = SummonedMount.db.profile.mount2Id
end


-------------Select Option --------------------
function SummonedMount:GetSelectOption(info)
	return self.db.profile.selectOption
end

function SummonedMount:SetSelectOption(info,value)
	core.selectedOptionMount = value
	self.db.profile.selectOption = value
	if value == "all" then
		core.MountButton:SetNormalTexture("Interface\\Icons\\Spell_Nature_Swiftness")
		else
			core.MountButton:SetNormalTexture("Interface\\Icons\\Achievement_guildperk_mountup")
		end
end

function core.SaveOptions.ListMount(value)
	SummonedMount:SetSelectOption(nil,value)
end
-------------Taille Icon --------------------
function SummonedMount:GetTailleIcone(info)
	return self.db.profile.iconeSize
end

function SummonedMount:SetTailleIcone(info,value)

	if tonumber(value) then
		self.db.profile.iconeSize = value
		core.MountButton:SetSize(value,value)
	else
		-- La valeur saisie n'est pas un chiffre, vous pouvez afficher un message d'erreur ou prendre une autre action
		print("Veuillez saisir un chiffre valide.")
	end

end

-------------Icon--------------------
function SummonedMount:GetIcone()
	local iconName = self.db.profile.icone.image
	return tostring(iconName)
end

function SummonedMount:SetIcone(value)
	self.db.profile.icone = "Interface\\Icons\\" .. value
	core.choiceIcone = self.db.profile.icone
	if core.selectedOptionMount == "all" then
		core.MountButton:SetNormalTexture(core.choiceIcone)
	end
end

function core.SaveOptions.SetIcone( value)
	SummonedMount:SetIcone(value)
end

---------Save selected Mount -----------
function core.SaveMount1(value)
	SummonedMount:SetMount1(value)
end

function core.SaveMount2(value)
	SummonedMount:SetMount2(value)
end

function SummonedMount:SetMount1(value)
	self.db.profile.mount1Name = value['mountName']
	self.db.profile.mount1Id = value['mountId']
	core.mount1Name = self.db.profile.mount1Name
	core.mount1Id = self.db.profile.mount1Id
end

function SummonedMount:SetMount2(value)
	self.db.profile.mount2Name = value['mountName']
	self.db.profile.mount2Id = value['mountId']
	core.mount2Name = self.db.profile.mount2Name
	core.mount2Id = self.db.profile.mount2Id

end

-------------Position Button --------------------
function SummonedMount:SetButtonPosition(value)
	self.db.profile.buttonPosition = value
end

function core.SaveOptions.ButtonPosition(value)
	SummonedMount:SetButtonPosition(value)
end

function SummonedMount:GetOptionFrame()
	return self.optionsFrame
end

function core.getOptionFrame()
	return SummonedMount:GetOptionFrame()
end

function SummonedMount:GetSelectMonture1Option(value)
end
function SummonedMount:SetSelectMonture1Option(info,value)
end
