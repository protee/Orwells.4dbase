
var $vJ_widget : Object
var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.sublist_set("FRAGMENTS"; "speeches"; "UIDspeech"; "order"; True:C214)
		$vJ_widget.update()
		
		
	: ($vL_event=-On Selection Change:K2:29)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._lb_fragments_event($vJ_widget; $vL_event)
		
End case 

