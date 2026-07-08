//%attributes = {}
// *****
// *
// Method: zenh__initialize_btnMenus
// Olivier Grimbert — Protée sarl — 05/04/2025 16:52:12
//
// Description: Initialization of all btnMenus used in host -> Wrapped in ZEN
//
// Date       | Who | Comment
// 05/04/2025 | OG  | Updated
// *
// *****

#DECLARE($vJ_prefs : Object)

var $vJ_menuBtns; $vJ_menu : Object
var $vC_at_lbl; $vC_al_lbl; $vC_yinYang_msk; $vC_at_separators : Collection
var $c4Fu_icon : 4D:C1709.Function
var $vT_path : Text
$vJ_menuBtns:=New shared object:C1526
Use ($vJ_prefs)
	$vJ_prefs.j_menuBtns:=$vJ_menuBtns
End use 

$vT_path:="metier/"
$c4Fu_icon:=Formula:C1597(zenh_SET_MENU_ITEM_ICON)

Use ($vJ_menuBtns)
	
	// ***** m_playOrder btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_playOrder:=$vJ_menu
	$vJ_menu.t_label:="Play order…"
	$vJ_menu.l_btn_w:=40
	$vJ_menu.t_key:="playOrder"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Ascending"; "Descending"; "Random")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0xFF8F; 0xFFBC; 0xFF43)
	
	
	// ***** m_yinYangPlay btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_yinYangPlay:=$vJ_menu
	$vJ_menu.t_label:="YinYang play option"
	$vJ_menu.l_btn_w:=-40
	$vJ_menu.t_key:="yinYangPlay"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Yin"; "Yang"; "YinYang"; "QAs")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0xFF4A; 0xFFBA; 0xFF90; 0xFFE3)
	
	// ***** yinYang_msk
	$vC_yinYang_msk:=New shared collection:C1527()
	$vJ_menu.al_yinYang_msk:=$vC_yinYang_msk
	$vC_yinYang_msk.push(0x0001; 0x0002; 0x0003; 0x0007)
	
	
	// ***** m_yinYang btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_yinYang:=$vJ_menu
	$vJ_menu.t_label:="Yin Yang mode"
	$vJ_menu.l_btn_w:=40
	$vJ_menu.t_key:="yinYang"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Yin"; "Yang"; "YinYang")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0xFF4A; 0xFFBA; 0xFF90)
	
	// ***** m_separator btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_separators:=$vJ_menu
	$vJ_menu.t_label:="Séparators…"
	$vJ_menu.t_key:="separator"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("␍"; "␉"; ","; ";"; "–"; "—"; "|"; "•"; "◆"; "■"; "○"; "◇"; "□"; "→")
	
	// ***** at_separators
	$vC_at_separators:=New shared collection:C1527()
	$vJ_menu.at_separators:=$vC_at_separators  // Stringify
	$vC_at_separators.push(Char:C90(Carriage return:K15:38); Char:C90(Tab:K15:37))
	$vC_at_separators.push(","; ";"; "–"; "—"; "|"; "●"; "◆"; "■"; "○"; "◇"; "□"; "→")
	
End use 

