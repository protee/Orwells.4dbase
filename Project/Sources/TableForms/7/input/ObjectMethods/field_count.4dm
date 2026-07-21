
Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		var $vL_count : Integer
		var $vJ_prefs; $vJ_widget : Object
		$vL_count:=$vJ_prefs.l_count
		$vJ_widget:=OBJECT Get value:C1743("waz_count")
		$vJ_widget.redraw()
		Form:C1466.fc.redraw()
		
End case 
