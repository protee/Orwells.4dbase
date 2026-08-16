
var $vL_evt : Integer
var $vJ_widget : Object

$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_menu:=orw__storage_menuBtns().m_yinYangPlay
		
		Form:C1466.l_yinYang:=Form:C1466.c4E_SPEECHES.yinYang
		$vJ_widget.j_value:=Form:C1466
		$vJ_widget.t_property:="l_yinYang"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc._update()
		
End case 
