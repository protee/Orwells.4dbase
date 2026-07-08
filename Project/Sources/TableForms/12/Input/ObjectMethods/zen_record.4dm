
var $vL_evt : Integer
var $vJ_widget : Object
var $vT_action : Text
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_form:=Form:C1466  // Do not trigger bounce
		
		
	: ($vL_evt=k_OnDataChange)
		$vJ_widget:=Self:C308->
		$vT_action:=$vJ_widget.t_action
		Form:C1466.fc.zen_record_events($vT_action)
		$vJ_widget.t_action:=""
		
End case 

