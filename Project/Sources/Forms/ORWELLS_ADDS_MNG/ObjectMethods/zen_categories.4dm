

var $vJ_widget : Object
var $vL_evt : Integer
$vL_evt:=Form event code:C388
Case of 
	: ($vL_evt=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="CATEGORIES record"
		$vJ_widget.t_table:="CATEGORIES"
		Form:C1466.UIDcategory:=""
		$vJ_widget.bind_to("UIDcategory")
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
End case 


