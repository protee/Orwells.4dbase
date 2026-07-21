
var $vL_evt : Integer
var $vJ_widget : Object
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		wox_vJ_overload(app__storage_stuff.j_colors_text; $vJ_widget)
		$vJ_widget.bind_to_c4E("colors"; woc_sp_colors_random())
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_evt=k_OnDataChange)
		//Form.fc.redraw()
		
		
End case 
