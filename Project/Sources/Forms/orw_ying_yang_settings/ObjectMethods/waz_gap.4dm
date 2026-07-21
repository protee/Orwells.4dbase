
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="Gap"
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=50
		$vJ_widget.l_unit:=10
		$vJ_widget.l_step:=1
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._chge($vJ_widget)
		
		
End case 

