
var $vL_evt : Integer
var $vJ_widget : Object
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="Coef dots"
		$vJ_widget.l_min:=0
		$vJ_widget.l_max:=100
		$vJ_widget.l_unit:=25
		$vJ_widget.l_step:=1
		
	: ($vL_evt=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._chge($vJ_widget)
		
		
End case 

