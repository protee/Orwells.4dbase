
Class extends ZEN__DELETE


Class constructor($is_msg : Boolean)
	If (Count parameters:C259<1)
		$is_msg:=True:C214
	End if 
	Super:C1705($is_msg)  // Default $vL_delete:=0  // 0 All / 1 one record / 2 cancel record
	
	
	// ***** External call for delete
	// *
Function records_delete($vT_table : Text; $c4ES_selection : 4D:C1709.EntitySelection)->$isOk : Boolean
	var $vC_aj_delete : Collection
	var $vL_count_records : Integer
	$vL_count_records:=$c4ES_selection.length
	$isOk:=($vL_count_records>0)
	If ($isOk)
		$vC_aj_delete:=This:C1470._aj_delete_fill($vT_table; $c4ES_selection)
		$isOk:=Super:C1706._records_delete($vC_aj_delete; $vT_table)
	Else 
		Super:C1706._nothingToDelete()
	End if 
	
Function record_delete($vT_table : Text; $c4E_entity : 4D:C1709.Entity; $is_cancel : Boolean)->$isOk : Boolean
	var $c4ES_selection : 4D:C1709.EntitySelection
	var $vC_aj_delete : Collection
	$c4ES_selection:=zen__ds[$vT_table].newSelection()
	$c4ES_selection:=$c4ES_selection.add($c4E_entity)
	$vC_aj_delete:=This:C1470._aj_delete_fill($vT_table; $c4ES_selection)
	$isOk:=Super:C1706._records_delete($vC_aj_delete; $vT_table; True:C214; $is_cancel)
	// *
	// *****
	
	
	// ***** All tables specific dispatcher
	// *
Function _aj_delete_fill($vT_table : Text; $c4ES_selection : 4D:C1709.EntitySelection)->$vC_aj_delete : Collection
	$vC_aj_delete:=This:C1470._get_aj_delete()
	This:C1470._main_table($vC_aj_delete; $c4ES_selection)
	
	// True to allow related delete, False to prevent deletion
	Case of 
		: ($vT_table=("MULTIPLAY"))
			
		: ($vT_table=("TESSERAC"))
			
		: ($vT_table=("YIN_YANG"))
			
		: ($vT_table=("CIRCLES"))
			
			
		: ($vT_table=("SESSIONS"))
			$c4ES_related:=This:C1470._related_table($c4ES_selection; "SPEECHES")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related; True:C214)
			$c4ES_related1:=This:C1470._related_table($c4ES_related; "FRAGMENTS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			$c4ES_related2:=This:C1470._related_table($c4ES_related; "ACTIONS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2; True:C214)
			
		: ($vT_table=("SPEECHES"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "FRAGMENTS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			$c4ES_related2:=This:C1470._related_table($c4ES_selection; "ACTIONS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2; True:C214)
			
		: ($vT_table=("FRAGMENTS"))
			
		: ($vT_table=("ACTIONS"))
			
		: ($vT_table=("ORWELLS"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "FRAGMENTS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			
		: ($vT_table=("CATEGORIES"))
			$c4ES_related1:=This:C1470._related_table($c4ES_selection; "ORWELLS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related1; True:C214)
			$c4ES_related2:=This:C1470._related_table($c4ES_related1; "FRAGMENTS")
			This:C1470._aj_delete_push($vC_aj_delete; $c4ES_related2; False:C215)
			
			
		Else   // Impossible to delete non planned tables
			This:C1470._do_set_deletable()  // Make the first (main table) not deletable
			
	End case 
	// *
	// *****
	
	
	
	