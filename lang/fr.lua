local _, core = ...;

if GetLocale() == "frFR" then
    local L = {}

    L["LeftClick"] = "Clic gauche: "
    L["RightClick"] = "Clic droit: "
    L["MiddleClick"] = "Clic milieu: "
    L["CtrlClick"] = "CTRL + Clic:"
    L["CTRLMiddleClick"] = "CTRL + Clic milieu: "
    L["ShiftClick"] = "SHIFT + Clic: "
    L["CtrlClick"] = "CTRL + Clic: "
    L["AltLeftClick"] = "ALT + Clic: "
    L["CommandList"] = "Liste des commandes"
    L["SizeIcon"] = "Taille de l'icone"

    L["InfoLeftClick"] = "Invoque une monture volante "
    L["MoreInfoLeftClick"] = "ou terrestre si vous ne savez pas voler, aquatique si vous étes dans l'eau"
    L["InfoRightClick"] = "Invoque une monture terrestre"
    L["InfoMiddleClick"] = "Invoque une monture au choix"
    L["InfoCTRLMiddleClick"] = "Invoque une autre monture au choix"
    L["InfoCtrlClick"] = "Déplace le bouton d'invocation de monture"
    L["InfoShiftClick"] = "Change de liste de montures entre toutes vos montures ou vos favorites"
    L["InfoAltLeftClick"] = "Choisir une icone pour la liste de toutes vos montures"

    L["Monture"] = "Monture"
    L["NotSelectedMount"] = "Vous n'avez pas choisi de monture"
    L['ChooseMount'] = "Selectionner monture"
    L['SearchByName'] = "Rechercher par nom..."
    L['NotMountFound'] = "Pas de montures trouvées de type"
    L['InList'] = " trouvées dans la liste des montures favorites \n Changez la liste en faisant SHIFT + clic gauche sur le bouton ou directement dans les options de l'addon"
    L['All'] = "Toutes les montures"
    L['MountList'] = "Liste des montures"
    L['FavoriteMounts'] = "Mes montures favorites"
    core.L = L
end