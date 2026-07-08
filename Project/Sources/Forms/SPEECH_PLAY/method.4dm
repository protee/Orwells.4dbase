
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
//Case of 
//: ($vL_event_code=On Load)
//Form.fc:=cs.SPEECH_PLAY.new()
//Else 
//Form.fc.form_events()
//End case 

Form:C1466.fc.form_events($vL_event_code)
