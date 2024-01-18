local _,core = ...;

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
    L["CommandList"]="Liste des commandes"
    L["SizeIcon"]="Taille de l'icone"
    
    L["InfoLeftClick"]="Invoque une monture en fonction de l'environnement \n"
    L["MoreInfoLeftClick"]="Terrestre si vous ne savez pas voler, aquatique si vous étes dans l'eau, sinon une dragon-riding ou volante"
    L["InfoMiddleClick"]="Invoque une monture volante ou dragon-riding \n"
    L["InfoMiddleClick"]="Invoque une monture au choix"
    L["InfoCTRLMiddleClick"]="Invoque une autre monture au choix"
    L["InfoCtrlClick"]="Déplace le bouton d'invocation de monture"
    L["InfoShiftClick"]="Change de liste de montures entre toutes vos montures ou vos favorites"
    L["InfoAltLeftClick"]="Choisir une icone pour la liste de toutes vos montures"

    L["Monture"]="Monture"
    L["NotSelectedMount"]="Vous n'avez pas choisi de monture"
    L['ChooseMount']="Selectionner monture"
    L['SearchByName']="Rechercher par nom..."
    core.L = L
 end