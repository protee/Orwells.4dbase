//%attributes = {}

var $c4Fi_table : 4D:C1709.File
var $c4Fo_export : 4D:C1709.Folder
var $isStopProgress; $is_drop : Boolean
var $vC_aj_TablesClass; $vC_aj_tables : Collection
var $vL_table_count; $idx_table : Integer
var $vJ_prefs; $vJ_table; $vJ_TablesClass_orwell : Object
var $vP_table : Pointer
var $vT_progress_uid; $vT_table; $vT_json : Text
var $c4ES_toDelete; $c4ES_notDeleted : 4D:C1709.EntitySelection

READ ONLY:C145(*)
$is_drop:=True:C214

$c4Fo_export:=Folder:C1567(fk data folder:K87:12).folder("Exports_json")
If ($c4Fo_export.exists)
	If (waz_io_confirm_popup("ARE YOU SURE?"))
		$vJ_prefs:=zen__storage_prefs()
		$vC_aj_TablesClass:=$vJ_prefs.aj_TablesClass
		$vJ_TablesClass_orwell:=$vC_aj_TablesClass.query("t_label = :1"; "Orwell").first()
		$vC_aj_tables:=$vJ_TablesClass_orwell.aj_tables
		
		$vT_progress_uid:=waz_progress_new("Import jsons...")
		waz_progress_setButton($vT_progress_uid; "stop")
		$isStopProgress:=False:C215
		
		$vL_table_count:=$vC_aj_tables.length
		$idx_table:=0
		For each ($vJ_table; $vC_aj_tables)
			$vP_table:=Table:C252($vJ_table.l_table)
			$idx_table+=1
			$vT_table:=Table name:C256($vP_table)
			waz_progress_setCounts($vT_progress_uid; $idx_table; $vL_table_count)
			
			If ($is_drop)
				waz_progress_subtitle($vT_progress_uid; $vT_table+" drop...")
				$c4ES_toDelete:=ds:C1482[$vT_table].all()
				$c4ES_notDeleted:=$c4ES_toDelete.drop(dk stop dropping on first error:K85:26)
			End if 
			
			waz_progress_subtitle($vT_progress_uid; $vT_table)
			$c4Fi_table:=$c4Fo_export.file($vT_table+".json")
			$vT_json:=$c4Fi_table.getText("UTF-8")
			JSON TO SELECTION:C1235($vP_table->; $vT_json)
			
			$isStopProgress:=waz_progress_isStopped($vT_progress_uid)
			If ($isStopProgress)
				break
			End if 
		End for each 
		
		waz_progress_quit($vT_progress_uid)
	End if 
	
Else 
	waz_io_alert("No folder!")
End if 
