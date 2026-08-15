
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	//OBJECT SET ENTERABLE(*; "LB_rtc"; Form.is_editing)
	//This.lb_rtc_load()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.colors=0); True:C214; "Fill in colors!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=$c4E_record.touched()
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
	//Function record_save($c4E_entity : 4D.Entity)
	//Super.record_save($c4E_entity)
	
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
				: ($vT_objectName="btn_exchange")
					This:C1470._btn_exchange()
					
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
	
	
Function _btn_exchange()
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $txt; $vT_ISO2 : Text
	$cE_ORWELLS:=Form:C1466.c4E
	$txt:=$cE_ORWELLS.yinTongue
	$vT_ISO2:=$cE_ORWELLS.yinISO2
	$cE_ORWELLS.yinTongue:=$cE_ORWELLS.yangTongue
	$cE_ORWELLS.yinISO2:=$cE_ORWELLS.yangISO2
	$cE_ORWELLS.yangTongue:=$txt
	$cE_ORWELLS.yangISO2:=$vT_ISO2
	OBJECT Get value:C1743("wox_yangISO2").redraw()
	OBJECT Get value:C1743("wox_yinISO2").redraw()
	
	
Function _btn_yin()
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $vT_source; $vT_ISO2_source; $vT_ISO2_target; $vT_answer : Text
	$cE_ORWELLS:=Form:C1466.c4E
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
	$cE_ORWELLS:=Form:C1466.c4E
	$vT_source:=$cE_ORWELLS.yinTongue
	$vT_ISO2_source:=$cE_ORWELLS.yinISO2
	$vT_ISO2_target:=$cE_ORWELLS.yangISO2
	$vT_answer:=This:C1470.translate($vT_source; $vT_ISO2_source; $vT_ISO2_target)
	If ($vT_answer#"")
		$cE_ORWELLS.yangTongue:=$vT_answer
	End if 
	
	
Function translate($vT_source : Text; $vT_ISO2_source : Text; $vT_ISO2_target : Text)->$vT_answer : Text
	var $vT_sourceISO2; $vT_targetISO2 : Text
	If ($vT_ISO2_source#"") && ($vT_ISO2_target#"") && ($vT_ISO2_source#$vT_ISO2_target)
		If ($vT_sourceISO2=$vT_targetISO2)
			$vT_answer:=$vT_source
		Else 
			$vT_answer:=wox_ISO2_translate($vT_source; $vT_ISO2_source; $vT_ISO2_target; True:C214)
		End if 
	Else 
		cs:C1710.wox.SOUNDS.me.play_glop_no()
	End if 
	
	