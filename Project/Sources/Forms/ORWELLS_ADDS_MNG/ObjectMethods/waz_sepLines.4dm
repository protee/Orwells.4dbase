
var $vL_evt : Integer
var $vJ_widget : Object

$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="For lines"
		$vJ_widget.j_menu:=app__storage_menuBtns().m_separators
		Form:C1466.l_sepLines:=0
		$vJ_widget.bind_to("l_sepLines")
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc._yinYang_change()
		
End case 
