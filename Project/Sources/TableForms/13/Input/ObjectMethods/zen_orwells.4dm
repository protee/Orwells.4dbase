

var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.c4E_set("ORWELLS"; "UIDorwell")
		//$vJ_widget.t_table:="ORWELLS"
		//$vJ_widget.bind_to_c4E("UIDorwell")
		//$vJ_widget.t_tip:="ORWELLS record"
		$vJ_widget.t_label:="yinTongue, yangTongue"
		$c4Fu_orwells:=Formula:C1597(This:C1470.yinTongue+" • "+This:C1470.yangTongue)
		$vJ_widget.fu_value:=$c4Fu_orwells
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_evt=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 


