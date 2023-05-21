
SummonedMount = LibStub("AceAddon-3.0"):NewAddon("SummonedMount", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

defaults = {
	profile = {
		selectOption = "favorites",
		buttonPosition= {point= "CENTER", relativePoint="CENTER",  x = 0, y = 0},
		iconeSize = 35
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
			name = "Liste de montures",
			desc = "Select an option",
			values = {
				["all"] = "Toutes mes montures",
				["favorites"] = "Mes montures favorites",
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
			name = "taille de l'icone",
			desc = "Change la taille de l'icone",
			get = "GetTailleIcone",
			set = "SetTailleIcone",
			pattern = "%d",
		},
		setskinheader = {
			order=4,
			type = "header",
			name = "Liste des commandes",
		},

		ghostDescription2 = {
			order=5,
			type = "description",
			name = "   ",
			cmdHidden = true
		},

		confLeftClick = {
			order=6,
			fontSize = "medium",
			type = "description",
			name = GREEN_FONT_COLOR_CODE.."Clic gauche"..": ".."|cFFFFFF00 Invoque une monture en fonction de l'environnement",
			cmdHidden = true
		},

		ghostDescription3 = {
			order=7,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confRightClic = {
			order=8,
			fontSize = "medium",
			type = "description",
			name = GREEN_FONT_COLOR_CODE.."Clic droit"..": ".."|cFFFFFF00 Invoque une monture sans tenir compte de l'environnement.",
			cmdHidden = true
		},
		confRightClic2 = {
			order=9,
			fontSize = "medium",
			type = "description",
			name = "|cFFFFFF00 Elle dépendra de si vous pouvez voler ou non.",
			cmdHidden = true
		},
		confRightClic3 = {
			order=10,
			fontSize = "medium",
			type = "description",
			name = "|cffff8000 À dragonflight si vous êtes dans l'eau elle invoque votre dragon.",
			cmdHidden = true
		},
		ghostDescription4 = {
			order=11,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confMiddleClick = {
			order=12,
			fontSize = "medium",
			type = "description",
			name = GREEN_FONT_COLOR_CODE.. "Clic milieu : |cFFFFFF00 Invoque votre monture vendeur.",
			cmdHidden = true
		},
		ghostDescription5 = {
			order=13,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confCtrlClick = {
			order=14,
			fontSize = "medium",
			type = "description",
			name = GREEN_FONT_COLOR_CODE.. "Clic + CTRL : |cFFFFFF00 Déplace le bouton.",
			cmdHidden = true
		},

		ghostDescription6 = {
			order=15,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		confMajClick = {
			order=16,
			fontSize = "medium",
			type = "description",
			name = GREEN_FONT_COLOR_CODE.. "Clic + MAJ : |cFFFFFF00 Change la liste de monture (favoris ou toutes).",
			cmdHidden = true
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
function SummonedMount:GetTailleIcone(info)
	return self.db.profile.iconeSize
end

function SummonedMount:SetTailleIcone(info,value)

	if tonumber(value) then
		self.db.profile.iconeSize = value
		MountButton:SetSize(value,value)
	else
		-- La valeur saisie n'est pas un chiffre, vous pouvez afficher un message d'erreur ou prendre une autre action
		print("Veuillez saisir un chiffre valide.")
	end

end

