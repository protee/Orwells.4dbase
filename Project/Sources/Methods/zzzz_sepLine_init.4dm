//%attributes = {}

var $cE_SPEECHES : cs:C1710.SPEECHESEntity
var $cES_SPEECHES : cs:C1710.SPEECHESSelection


If (waz_io_confirm_popup("ARE YOU SURE?"))
	$cES_SPEECHES:=ds:C1482.SPEECHES.all()
	
	For each ($cE_SPEECHES; $cES_SPEECHES)
		$cE_SPEECHES.sepLine:=11
		$cE_SPEECHES.save()
	End for each 
End if 
