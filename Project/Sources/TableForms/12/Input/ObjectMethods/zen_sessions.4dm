

var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.c4E_set("SESSIONS"; "UIDsession")
		//$vJ_widget.t_table:="SESSIONS"
		//$vJ_widget.bind_to_c4E("UIDsession")
		//$vJ_widget.t_tip:="SESSIONS record"
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_evt=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 


