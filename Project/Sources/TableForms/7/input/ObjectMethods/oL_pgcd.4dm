
Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		var $vR_factor : Real
		$vR_factor:=Form:C1466.c4E.fields.r_factor
		var $vP_count : Pointer
		$vP_count:=OBJECT Get pointer:C1124(Object named:K67:5; "ruler_factor")
		$vP_count->:=$vR_factor
		Form:C1466.fc.redraw()
		
End case 
