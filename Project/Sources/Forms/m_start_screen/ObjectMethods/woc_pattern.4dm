
var $vL_event_code : Integer
var $vJ_widget; $vJ_pattern : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=False:C215
		$vJ_value:=New object:C1471()
		$vJ_widget.j_value:=$vJ_value
		$vJ_value.l_pattern:=14
		//$vJ_value.l_colors:=0x3597  // [md:53] – [md:151]
		$vJ_value.l_colors:=0xAA03E03B  // [swo:62] – [swo:59]  
		$vJ_value.l_rxy:=10
		$vJ_value.l_stroke:=0
		$vJ_value.l_opacity:=100
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
End case 

