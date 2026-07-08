
Class extends ZENH_EXTRAS

Class constructor($vL_winRef : Integer)
	Super:C1705($vL_winRef)
	This:C1470.t_path:="tables_extras/orwells/"
	This:C1470.l_label:=-1
	
	// For search class - and keep values in it
	This:C1470.cs_search:=Null:C1517
	This:C1470.cs_search1:=Null:C1517
	
	
Function get_aj_extra_btns($vC_aj_extra_btns : Collection)
	var $i : Integer
	
	// ***** Simple button — as without aj_menus
	// *
	This:C1470.extra_btn_new($vC_aj_extra_btns; "ORWELLS input manager"; -1; "adds")
	
	// ***** Simple button — as without aj_menus
	// *
	This:C1470.extra_btn_new($vC_aj_extra_btns; "ORWELLS copy to PP"; -1; "copy")
	
	For ($i; 1; 4)  // ***** Simple button — as without aj_menus
		This:C1470.extra_btn_new($vC_aj_extra_btns; "ORWELLS bidon "+String:C10($i); -1; "face")
	End for 
	// *
	// *****
	
	
Function extras_mng($vT_table : Text; $vT_menu : Text; $c4ES_selection_in : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection; $is_local : Boolean)->$c4ES_selection : 4D:C1709.EntitySelection
	var $isOk : Boolean
	var $vL_form; $vL_refWindow; $vL_orwells; $idx; $vL_count : Integer
	var $vJ_form : Object
	var $vT_form; $vT_title; $vT_truth; $vT_wood : Text
	var $vC_at_truthTongue; $vC_at_woodTongue : Collection
	var $cE_orwells : cs:C1710.ORWELLSEntity
	var $c4DC_orwells : 4D:C1709.DataClass
	var $cES_orwells : cs:C1710.ORWELLSSelection
	var $vV_UIDcategory : Variant
	
	Case of 
		: ($vT_menu="adds")
			$vJ_form:=New object:C1471()
			
			$vT_form:="ORWELLS_ADDS_MNG"
			$vL_form:=Sheet form window:K39:12
			$vL_refWindow:=Open form window:C675($vT_form; $vL_form)
			SET WINDOW TITLE:C213($vT_title; $vL_refWindow)
			DIALOG:C40($vT_form; $vJ_form)
			CLOSE WINDOW:C154($vL_refWindow)
			$isOk:=(OK=1)
			If ($isOk)
				$c4DC_orwells:=ds:C1482.ORWELLS
				$c4ES_selection:=$c4DC_orwells.newSelection()
				$vC_at_truthTongue:=$vJ_form.at_truthTongue
				$vC_at_woodTongue:=$vJ_form.at_woodTongue
				$vL_orwells:=$vJ_form.l_orwells
				$vV_UIDcategory:=$vJ_form.UIDcategory
				$vL_count:=0
				$idx:=0
				For each ($vT_truth; $vC_at_truthTongue)
					$vT_wood:=$vC_at_woodTongue[$idx]
					$cES_orwells:=$c4DC_orwells.query("truthTongue = :1 and woodTongue = :2"; $vT_truth; $vT_wood)
					If ($cES_orwells.length=0)
						$cE_orwells:=zen_entity_new($c4DC_orwells)
						$cE_orwells.yangTongue:=$vT_wood
						$cE_orwells.yinTongue:=$vT_truth
						$cE_orwells.colors:=$vL_orwells
						$cE_orwells.isActive:=True:C214
						$cE_orwells.UIDcategory:=$vV_UIDcategory
						zen_entity_save($cE_orwells)
						$c4ES_selection.add($cE_orwells)
						$vL_count+=1
					End if 
				End for each 
				waz_io_alert_popup("Imported : "+String:C10($vL_count)+"!")
			End if 
			
			
		: ($vT_menu="copy")
			waz_io_alert_popup("Not implemented!"; "alert")
			
		Else 
			wox_sounds_play_glop_no()
			$c4ES_selection:=$c4ES_selection_in
	End case 
	// *
	// *****
	
	