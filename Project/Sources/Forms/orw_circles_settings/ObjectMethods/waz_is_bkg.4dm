
var $vJ_widget : Object
var $vL_evt : Integer

$vL_evt:=Form event code:C388
Case of 
		//: ($vL_evt=On Load)
		
	: ($vL_evt=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._chge($vJ_widget)
		
End case 
