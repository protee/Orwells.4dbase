
var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=100
		$vJ_widget.l_unit:=10
		$vJ_widget.l_step:=1
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.j_value:=Form:C1466.c4E.fields
		$vJ_widget.t_property:="r_factor"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc.redraw()
		
		
End case 



