
var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		wox_vJ_overload(app__storage_stuff.j_color_square; $vJ_widget)
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.j_value:=Form:C1466.c4E.fields
		$vJ_widget.t_property:="l_bkg"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc.redraw()
		
		
End case 



