
var $vL_evt : Integer
var $vJ_widget : Object

$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="In line"
		$vJ_widget.j_menu:=orw__storage_menuBtns().m_separators
		Form:C1466.l_sepLine:=2
		$vJ_widget.bind_to("l_sepLine")
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		//: ($vL_evt=k_OnDataChange)
		//Form.fc._yinYang_change()
		
End case 
