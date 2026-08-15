
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470._lb_speeches_event()
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
					
				: ($vT_objectName="bt_display")
					This:C1470._speech_display()
					
				: ($vT_objectName="bt_play")
					This:C1470._speech_play()
					
			End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
Function _lb_speeches_event($vJ_zen_speeches : Object; $vL_event : Integer)
	var $is_selected : Boolean
	var $cE_speeches : cs:C1710.SPEECHESEntity
	$is_selected:=$vJ_zen_speeches#Null:C1517
	If ($is_selected)
		$cE_speeches:=This:C1470._lb_speeches_c4E($vJ_zen_speeches)
		$is_selected:=$cE_speeches#Null:C1517
	End if 
	OBJECT SET ENABLED:C1123(*; "bt_display"; $is_selected)
	OBJECT SET ENABLED:C1123(*; "bt_play"; $is_selected)
	
	
Function _lb_speeches_c4E($vJ_zen_speeches : Object)->$cE_speeches : cs:C1710.SPEECHESEntity
	var $vT_zen_speeches : Text
	If ($vJ_zen_speeches=Null:C1517)
		$vT_zen_speeches:="zen_speeches"
		$vJ_zen_speeches:=OBJECT Get value:C1743($vT_zen_speeches)
	End if 
	$cE_speeches:=$vJ_zen_speeches.lb_current
	
	
Function _speech_display()
	var $cs_SPEECH_DSPLY : cs:C1710.SPEECH_DSPLY
	var $cE_speeches : cs:C1710.SPEECHESEntity
	$cE_speeches:=This:C1470._lb_speeches_c4E()
	If ($cE_speeches#Null:C1517)
		$cs_SPEECH_DSPLY:=cs:C1710.SPEECH_DSPLY.new($cE_speeches)
	Else 
		cs:C1710.wox.SOUNDS.me.play_beep()
	End if 
	
Function _speech_play()
	var $cs_SPEECH_PLAY : cs:C1710.SPEECH_PLAY
	var $cE_speeches : cs:C1710.SPEECHESEntity
	$cE_speeches:=This:C1470._lb_speeches_c4E()
	If ($cE_speeches#Null:C1517)
		$cs_SPEECH_PLAY:=cs:C1710.SPEECH_PLAY.new($cE_speeches)
	Else 
		cs:C1710.wox.SOUNDS.me.play_beep()
	End if 
	
	
	
	// *****
	// *
Function _btn_logo()
	var $c4Fi_avatar : 4D:C1709.File
	var $cE_sessions : cs:C1710.SESSIONSEntity
	var $vO_logo : Picture
	$c4Fi_avatar:=waz_avatars_choose()
	If ($c4Fi_avatar#Null:C1517)
		READ PICTURE FILE:C678($c4Fi_avatar.platformPath; $vO_logo)
		$cE_sessions:=Form:C1466.c4E
		$cE_sessions.logo:=$vO_logo
	End if 
	// *
	// *****
	
	
	//Function print()
	//var $cE_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSEntity
	//var $cES_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSSelection
	//$cES_ZEN_DOCUMENTS:=zen__ds.ZEN_DOCUMENTS.query("name = :1"; "MY FIRST DOC")
	//If ($cES_ZEN_DOCUMENTS.length>0)
	//$cE_ZEN_DOCUMENTS:=$cES_ZEN_DOCUMENTS.first()
	//zen_record_doc_print(Form.c4E; $cE_ZEN_DOCUMENTS; True)
	//End if 
	
	