
var $vJ_widget : Object
var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("ACTIONS"; "speeches"; "UIDspeech"; "dateTime")
		$vJ_widget.update()
		
		
	: ($vL_evt=On Data Change:K2:15)
		$vJ_widget:=Self:C308->
		//var $vT_action : Text
		//$vT_action:=$vJ_widget.t_action
		//Form.fc.wib_record_events($vT_action)
		//$vJ_widget.t_action:=""
		
End case 

