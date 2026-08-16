
var $vL_colors : Integer
var $vJ_widget : Object

C_LONGINT:C283($vL_event)
$vL_event:=Form event code:C388
Case of 
	: ($vL_event=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.l_border:=Border Sunken:K42:31
		wox_vJ_overload(orw__storage_stuff.$vJ_colors_square; $vJ_widget)
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vL_colors:=$vJ_widget.l_colors
		Form:C1466.fc._do_colors($vL_colors)
		
		
End case 

