//%attributes = {}

var $cE_ORWELLS : cs:C1710.ORWELLSEntity
var $cES_ORWELLS : cs:C1710.ORWELLSSelection
$cES_ORWELLS:=ds:C1482.ORWELLS.all()

If (waz_io_confirm_popup("ARE YOU SURE?"))
	For each ($cE_ORWELLS; $cES_ORWELLS)
		$cE_ORWELLS.infos:=""
		$cE_ORWELLS.save()
	End for each 
End if 
