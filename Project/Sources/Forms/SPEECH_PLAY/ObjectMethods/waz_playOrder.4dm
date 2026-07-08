
var $vL_evt : Integer
var $vJ_widget; $vJ_menu : Object

$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_menu:=app__storage_menuBtns().m_playOrder
		
		Form:C1466.l_playOrder:=Form:C1466.c4E_SPEECHES.playOrder
		$vJ_widget.j_value:=Form:C1466
		$vJ_widget.t_property:="l_playOrder"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc._load()
		
End case 
