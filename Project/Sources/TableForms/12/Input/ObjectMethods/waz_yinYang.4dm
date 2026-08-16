
var $vL_evt : Integer
var $vJ_widget : Object

$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_menu:=orw__storage_menuBtns().m_yinYangPlay
		$vJ_widget.bind_to_c4E("yinYang")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
End case 
