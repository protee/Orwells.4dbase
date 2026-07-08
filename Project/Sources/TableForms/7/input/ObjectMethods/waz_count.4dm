
C_LONGINT:C283($vL_evt)
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=200
		$vJ_widget.l_unit:=25
		$vJ_widget.l_step:=1
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.j_value:=Form:C1466.c4E.fields
		$vJ_widget.t_property:="l_count"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_evt=k_OnDataChange)
		Form:C1466.fc.redraw()
		
		
End case 


