
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
	var $vJ_widget : Object
	var $vT_widget : Text
	$vT_widget:="zen_speeches"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$is_touched:=$vJ_widget.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
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
				: ($vT_objectName="field_logo")
					If (Right click:C712) && (Form:C1466.is_editing)
						This:C1470._btn_logo()
					End if 
					
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
	
	
	// *****
	// *
Function _btn_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $cE_actions : cs:C1710.ACTIONSEntity
	var $vO_logo : Picture
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$cE_actions:=Form:C1466.c4E
		$cE_actions.logo:=$vO_logo
	End if 
	// *
	// *****
	
	
	//Function partner_choose()
	//var $c4E_entity : 4D.Entity
	//$c4E_entity:=Form.c4E
	//var $vT_foreign_key; $vT_orderBy; $vT_table : Text
	//$vT_table:="PARTENAIRES"
	//$vT_foreign_key:="IdPartner"
	//$vT_orderBy:="NomPartenaire"
	////$vV_UIDrelated:=$c4E_entity[$vT_foreign_key]
	////$is_related:=($vV_UIDrelated#("0"*32))
	//var $is_editing : Boolean
	//var $vT_view : Text
	//$is_editing:=Form.is_editing
	//If ($is_editing)
	//$vT_view:="picker_partner"
	//var $vV_foreign_UID : Variant
	//var $c4ES_selection : 4D.EntitySelection
	//$c4ES_selection:=zen__ds[$vT_table].all().orderBy($vT_orderBy)
	//$vV_foreign_UID:=$c4E_entity[$vT_foreign_key]
	
	//var $c4E_select; $c4E_selected : 4D.Entity
	//$c4E_selected:=zen_table_picker_one($vT_table; $vT_view; $c4ES_selection; $c4E_select)
	//If ($c4E_selected#Null)
	//$c4E_entity[$vT_foreign_key]:=$c4E_selected.UID
	//End if 
	
	//Else 
	//cs.wox.SOUNDS.me.play_edit()
	////cs.wox.SOUNDS.me.play__key().edit()
	//End if 
	
	
	//Function print()
	//var $cE_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSEntity
	//var $cES_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSSelection
	//$cES_ZEN_DOCUMENTS:=zen__ds.ZEN_DOCUMENTS.query("name = :1"; "MY FIRST DOC")
	//If ($cES_ZEN_DOCUMENTS.length>0)
	//$cE_ZEN_DOCUMENTS:=$cES_ZEN_DOCUMENTS.first()
	//zen_record_doc_print(Form.c4E; $cE_ZEN_DOCUMENTS; True)
	//End if 
	
	