
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	$is_new:=Form:C1466.is_new
	If ($is_new)
		Form:C1466.c4E.order:=Form:C1466.l_order  // Update order for new record
	End if 
	$cE_ORWELLS:=Form:C1466.c4E.FRAGMENTS_ORWELLS
	Form:C1466.c4E_ORWELLS:=$cE_ORWELLS
	This:C1470.ORWELLS_bind($cE_ORWELLS)
	//Form.is_ORWELLS_RW:=False
	
	
Function record_checkout()->$isOk : Boolean
	//var $c4E_entity : 4D.Entity
	//$c4E_entity:=Form.c4E
	//var $vJ_okValidate : Object
	//$vJ_okValidate:=zen_okValidate_init
	//zen_okValidate_check($vJ_okValidate; ($c4E_entity.colors=0); True; "Fill in colors!")
	//$isOk:=zen_okValidate_checkout($vJ_okValidate)
	$isOk:=True:C214
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$cE_ORWELLS:=Form:C1466.c4E_ORWELLS
	$is_touched:=$cE_ORWELLS ? $cE_ORWELLS.touched() : False:C215
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
Function record_save($c4E_entity : 4D:C1709.Entity)
	$cE_ORWELLS:=Form:C1466.c4E_ORWELLS
	$is_touched:=$cE_ORWELLS ? $cE_ORWELLS.touched() : False:C215
	If ($is_touched)
		zen_entity_save($cE_ORWELLS)
	End if 
	Super:C1706.record_save($c4E_entity)
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					//: ($vT_objectName="btn_exchange")
					//This._btn_exchange()
					
				: ($vT_objectName="btn_yin")
					This:C1470._btn_yin()
					
				: ($vT_objectName="btn_yang")
					This:C1470._btn_yang()
					
					//: ($vT_objectName="bt_partner")
					//This.partner_choose()
					
					//: ($vT_objectName="bt_print")
					//This.print()
					
			End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
Function ORWELLS_bind($cE_ORWELLS)
	$vC_at_keys:=New collection:C1472()
	$vC_at_keys.push("yin"; "yang")
	For each ($vT_key; $vC_at_keys)
		$vJ_widget:=OBJECT Get value:C1743("wox_"+$vT_key+"ISO2")
		$vJ_widget.j_value:=$cE_ORWELLS
		$vJ_widget.t_property:=$vT_key+"ISO2"
		$vJ_widget.redraw()
	End for each 
	
	
Function ORWELLS_update()
	$vC_at_keys:=New collection:C1472()
	$vC_at_keys.push("yin"; "yang")
	For each ($vT_key; $vC_at_keys)
		$vJ_widget:=OBJECT Get value:C1743("wox_"+$vT_key+"ISO2")
		$vJ_widget.redraw()
	End for each 
	
	
Function _btn_exchange()
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $txt; $vT_ISO2 : Text
	$cE_ORWELLS:=Form:C1466.c4E_ORWELLS
	$txt:=$cE_ORWELLS.yinTongue
	$vT_ISO2:=$cE_ORWELLS.yinISO2
	$cE_ORWELLS.yinTongue:=$cE_ORWELLS.yangTongue
	$cE_ORWELLS.yinISO2:=$cE_ORWELLS.yangISO2
	$cE_ORWELLS.yangTongue:=$txt
	$cE_ORWELLS.yangISO2:=$vT_ISO2
	This:C1470.ORWELLS_update()
	
	
Function _btn_yin()
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $vT_source; $vT_ISO2_source; $vT_ISO2_target; $vT_answer : Text
	$cE_ORWELLS:=Form:C1466.c4E_ORWELLS
	$vT_source:=$cE_ORWELLS.yangTongue
	$vT_ISO2_source:=$cE_ORWELLS.yangISO2
	$vT_ISO2_target:=$cE_ORWELLS.yinISO2
	$vT_answer:=This:C1470.translate($vT_source; $vT_ISO2_source; $vT_ISO2_target)
	If ($vT_answer#"")
		$cE_ORWELLS.yinTongue:=$vT_answer
	End if 
	
	
Function _btn_yang()
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $vT_source; $vT_ISO2_source; $vT_ISO2_target; $vT_answer : Text
	$cE_ORWELLS:=Form:C1466.c4E_ORWELLS
	$vT_source:=$cE_ORWELLS.yinTongue
	$vT_ISO2_source:=$cE_ORWELLS.yinISO2
	$vT_ISO2_target:=$cE_ORWELLS.yangISO2
	$vT_answer:=This:C1470.translate($vT_source; $vT_ISO2_source; $vT_ISO2_target)
	If ($vT_answer#"")
		$cE_ORWELLS.yangTongue:=$vT_answer
	End if 
	
	
Function translate($vT_source : Text; $vT_ISO2_source : Text; $vT_ISO2_target : Text)->$vT_answer : Text
	If ($vT_ISO2_source#"") && ($vT_ISO2_target#"") && ($vT_ISO2_source#$vT_ISO2_target)
		If ($vT_sourceISO2=$vT_targetISO2)
			$vT_answer:=$vT_source
		Else 
			$vT_answer:=wox_ISO2_translate($vT_source; $vT_ISO2_source; $vT_ISO2_target; True:C214)
		End if 
	Else 
		wox_sounds_play_glop_no()
	End if 
	
	