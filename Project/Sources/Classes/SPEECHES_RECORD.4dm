
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470._lb_fragments_event()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	//$vT_widget:="zen_speeches"
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$is_touched:=$vJ_widget.is_touched
	//If (Not($is_touched))
	$is_touched:=$c4E_record.touched()
	//End if
	
	
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
				: ($vT_objectName="bt_display")
					This:C1470._speech_display()
					
				: ($vT_objectName="bt_play")
					This:C1470._speech_play()
					
				: ($vT_objectName="btn_adds")
					This:C1470._do_adds()
					
				: ($vT_objectName="btn_orwells")
					This:C1470._do_add_orwells()
					
				: ($vT_objectName="bt_copy")
					This:C1470._do_copy()
					
				: ($vT_objectName="bt_language")
					This:C1470._do_language()
					
				: ($vT_objectName="bt_translate")
					This:C1470._do_translate()
					
				: ($vT_objectName="bt_excel")
					This:C1470._do_excel()
					
			End case 
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
	
	// *****
	// *
Function _speech_display()
	var $cs_SPEECH_DSPLY : cs:C1710.SPEECH_DSPLY
	$cs_SPEECH_DSPLY:=cs:C1710.SPEECH_DSPLY.new(Form:C1466.c4E)
	
Function _speech_play()
	var $cs_SPEECH_PLAY : cs:C1710.SPEECH_PLAY
	$cs_SPEECH_PLAY:=cs:C1710.SPEECH_PLAY.new(Form:C1466.c4E)
	
	
Function _do_adds()
	var $c4ES_selection : 4D:C1709.EntitySelection
	var $vJ_fragments : Object
	var $cE_SPEECHES : cs:C1710.SPEECHESEntity
	$cE_SPEECHES:=Form:C1466.c4E
	$c4ES_selection:=orw_orwells_add($cE_SPEECHES; $cE_SPEECHES.yinYang)
	If ($c4ES_selection#Null:C1517)
		$vJ_fragments:=OBJECT Get value:C1743("zen_fragments")
		$vJ_fragments.redraw()
	End if 
	
	
Function _do_add_orwells()
	var $c4Fu_orwells : 4D:C1709.Function
	var $c4DC_fragments : 4D:C1709.DataClass
	var $c4ES_selection; $c4ES_selected : 4D:C1709.EntitySelection
	var $isOk : Boolean
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	var $cES_fragments : cs:C1710.FRAGMENTSSelection
	var $cE_orwells : cs:C1710.ORWELLSEntity
	var $cES_orwells : cs:C1710.ORWELLSSelection
	var $vL_order; $vL_colors : Integer
	var $vJ_fragments; $vJ_params : Object
	var $vT_UID : Text
	
	$vJ_fragments:=OBJECT Get value:C1743("zen_fragments")
	$vJ_params:=New object:C1471()
	$vJ_params.t_table:="ORWELLS"
	$vJ_params.is_multiple:=True:C214
	$vJ_params.t_label:="yinTongue"
	$c4Fu_orwells:=Formula:C1597(This:C1470.yinTongue+" • "+This:C1470.yangTongue)
	$vJ_params.fu_value:=$c4Fu_orwells
	
	$cES_fragments:=$vJ_fragments.lb_selection
	$cES_orwells:=$cES_fragments.FRAGMENTS_ORWELLS
	$c4ES_selection:=ds:C1482.ORWELLS.all().minus($cES_orwells)
	$vJ_params.c4ES_selection:=$c4ES_selection
	$isOk:=zen_c4ES_form($vJ_params)
	If ($isOk)
		// Add records
		$c4DC_fragments:=ds:C1482.FRAGMENTS
		$vT_UID:=Form:C1466.c4E.UID
		$vL_order:=$cES_fragments.length
		$vL_colors:=0
		$c4ES_selected:=$vJ_params.c4ES
		For each ($cE_orwells; $c4ES_selected)
			$cE_fragments:=zen_entity_new($c4DC_fragments)
			$cE_fragments.UIDorwell:=$cE_orwells.UID
			$cE_fragments.UIDspeech:=$vT_UID
			$cE_fragments.order:=$vL_order  // Add at the end
			$cE_fragments.colors:=$vL_colors
			$cE_fragments.isActive:=True:C214
			zen_entity_save($cE_fragments)
			$vL_order+=1
		End for each 
		// Reorder
		//$vJ_fragments.do_reorder()
		$vJ_fragments.redraw()
	End if 
	
	
	
Function _do_copy()
	var $c4E : 4D:C1709.Entity
	var $cES_fragments : cs:C1710.FRAGMENTSSelection
	var $vL_yinYang_msk : Integer
	var $vT_label : Text
	$cES_fragments:=This:C1470._lb_fragments_c4ES(True:C214)
	$c4E:=Form:C1466.c4E
	$vT_label:=$c4E.label
	$vL_yinYang_msk:=This:C1470._yinYang_msk($c4E.yinYang)
	This:C1470._fragments_to_pasteboard($cES_fragments; $vL_yinYang_msk; $vT_label)  //; $vT_separator)
	
	
Function _do_excel()
	//$vL_err:=u_excel_exportLB("Export "+Table name($vP_table); $vP_LB; True)
	cs:C1710.wox.SOUNDS.me.play_glop_no()
	
	
Function _do_colors($vL_colors : Integer)
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	var $cES_fragments : cs:C1710.FRAGMENTSSelection
	var $tt : Integer
	var $vJ_zen_fragments : Object
	var $vT_zen_fragments : Text
	$cES_fragments:=This:C1470._lb_fragments_c4ES(True:C214)
	$tt:=$cES_fragments.length
	If ($tt#0)
		If (waz_io_confirm_popup("Change colors for records: "+String:C10($tt)+"?"))
			For each ($cE_fragments; $cES_fragments)
				$cE_fragments.colors:=$vL_colors
				zen_entity_save($cE_fragments)
			End for each 
			$vT_zen_fragments:="zen_fragments"
			$vJ_zen_fragments:=OBJECT Get value:C1743($vT_zen_fragments)
			$vJ_zen_fragments.redraw()
		End if 
		cs:C1710.wox.SOUNDS.me.play_glop()
		
	Else 
		cs:C1710.wox.SOUNDS.me.play_glop_no()
	End if 
	// *
	// *****
	
	
Function _get_separator()->$vC_at_separators : Collection
	$vC_at_separators:=orw__storage_menuBtns().m_separators.at_separators
	
	
Function _get_separator_char($is_lines : Boolean; $is_stringify : Boolean)->$vT_separator : Text
	var $vC_at_separators : Collection
	var $vL_separator : Integer
	$vC_at_separators:=This:C1470._get_separator()
	$vL_separator:=Form:C1466.c4E[$is_lines ? "sepLines" : "sepLine"]
	$vT_separator:=$vC_at_separators[$vL_separator]
	If ($is_stringify)
		$vT_separator:=$vT_separator<" " ? $vT_separator : ($vT_separator="," ? $vT_separator+" " : " "+$vT_separator+" ")
	End if 
	
	
Function _fragments_to_pasteboard($cES_fragments : cs:C1710.FRAGMENTSSelection; $vL_yinYang_msk : Integer; $vT_label : Text; $vT_separator : Text)
	var $vC_answer : Collection
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	var $vT_line; $vT_title; $vT_answer; $vT_sepLines1 : Text
	var $vT_yinYang; $vT_answer_plain; $vT_answer_rtf; $vT_sepLine; $vT_sepLines; $vT_text : Text
	var $vX_blob : Blob
	var $cE_orwells : cs:C1710.ORWELLSEntity
	var $is_yinTonge; $is_yangTonge; $is_bothTongue : Boolean
	
	$vT_sepLine:=This:C1470._get_separator_char(False:C215; True:C214)
	$vT_sepLines:=This:C1470._get_separator_char(True:C214; True:C214)
	
	
	$is_yinTonge:=$vL_yinYang_msk ?? 0
	$is_yangTonge:=$vL_yinYang_msk ?? 1
	$is_bothTongue:=$vL_yinYang_msk=3
	$vT_sepLine:=$is_bothTongue ? $vT_sepLine : ""
	
	// label
	$vT_yinYang:=""
	If ($is_yinTonge)
		$vT_yinYang+="Yin"
	End if 
	$vT_yinYang+=$vT_sepLine
	If ($is_yangTonge)
		$vT_yinYang+="Yang"
	End if 
	
	// Lines
	$vC_answer:=New collection:C1472()
	For each ($cE_fragments; $cES_fragments)
		$cE_orwells:=$cE_fragments.FRAGMENTS_ORWELLS
		$vT_line:=""
		If ($is_yinTonge)
			$vT_text:=$cE_orwells.yinTongue
			$vT_text:=This:C1470._clean_text($vT_text; $vT_sepLine; $vT_sepLines)
			$vT_line+=$vT_text
		End if 
		$vT_line+=$vT_sepLine
		If ($is_yangTonge)
			$vT_text:=$cE_orwells.yangTongue
			$vT_text:=This:C1470._clean_text($vT_text; $vT_sepLine; $vT_sepLines)
			$vT_line+=$vT_text
		End if 
		$vC_answer.push($vT_line)
	End for each 
	
	$vT_title:="Copy to Pasteboard?"
	$vT_sepLines:=$vT_sepLines=Char:C90(Carriage return:K15:38) ? $vT_sepLines+Char:C90(Line feed:K15:40) : $vT_sepLines
	$vT_sepLines1:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	$vT_answer:=$vT_sepLines+$vC_answer.join($vT_sepLines)
	$vT_answer_plain:=$vT_label+$vT_sepLines1+$vT_yinYang+$vT_sepLines1+$vT_answer
	
	ST SET ATTRIBUTES:C1093($vT_label; 1; 0; Attribute text size:K65:6; 24; Attribute bold style:K65:1; 1)
	ST SET ATTRIBUTES:C1093($vT_yinYang; 1; 0; Attribute text size:K65:6; 16; Attribute bold style:K65:1; 1)
	$vT_answer_rtf:=$vT_label+Char:C90(Carriage return:K15:38)+$vT_yinYang+Char:C90(Carriage return:K15:38)+$vT_answer
	If (waz_io_confirm($vT_title; $vT_answer_rtf; "copy"; "Copy"))
		SET TEXT TO PASTEBOARD:C523($vT_answer_plain)
		$vT_answer_rtf:=This:C1470._tiny_prepare($vT_answer_rtf)
		TEXT TO BLOB:C554($vT_answer_rtf; $vX_blob; UTF8 text without length:K22:17)
		APPEND DATA TO PASTEBOARD:C403("text/html"; $vX_blob)
	End if 
	
	
Function _clean_text($vT_text : Text; $vT_sepLine : Text; $vT_sepLines : Text)->$vT_answer : Text
	var $tt; $i : Integer
	var $vT_char : Text
	$tt:=Length:C16($vT_text)
	For ($i; 1; $tt)
		$vT_char:=$vT_text[[$i]]
		If ($vT_char#$vT_sepLine) && ($vT_char#$vT_sepLines)
			$vT_answer+=$vT_char
		End if 
	End for 
	
	
Function _tiny_prepare($vT_text : Text)->$vT_answer : Text
	$vT_answer:=Replace string:C233($vT_text; Char:C90(Carriage return:K15:38); "<br/>")
	
	
Function _yinYang_msk($vL_yinYang : Integer)->$vL_yinYang_msk : Integer
	var $vC_yinYang_msk : Collection
	var $vJ_menu : Object
	$vJ_menu:=orw__storage_menuBtns().m_yinYangPlay
	$vC_yinYang_msk:=$vJ_menu.al_yinYang_msk
	$vL_yinYang_msk:=$vC_yinYang_msk[$vL_yinYang]
	// *
	// *****
	
	
	// *****
	// *
Function _lb_fragments_event($vJ_zen_fragments : Object; $vL_event : Integer)
	var $is_selected : Boolean
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	$is_selected:=$vJ_zen_fragments#Null:C1517
	If ($is_selected)
		$cE_fragments:=This:C1470._lb_fragments_c4E()
		$is_selected:=$cE_fragments#Null:C1517
	End if 
	//OBJECT SET ENABLED(*; "bt_play"; $is_selected)
	
Function _lb_fragments_c4E()->$cE_fragments : cs:C1710.FRAGMENTSEntity
	var $vT_zen_fragments : Text
	var $vJ_zen_fragments : Object
	$vT_zen_fragments:="zen_fragments"
	$vJ_zen_fragments:=OBJECT Get value:C1743($vT_zen_fragments)
	$cE_fragments:=$vJ_zen_fragments.lb_current
	
Function _lb_fragments_c4ES($is_all : Boolean)->$cES_fragments : cs:C1710.FRAGMENTSSelection
	var $vT_zen_fragments : Text
	var $vJ_zen_fragments : Object
	$vT_zen_fragments:="zen_fragments"
	$vJ_zen_fragments:=OBJECT Get value:C1743($vT_zen_fragments)
	$cES_fragments:=$vJ_zen_fragments.lb_selected
	If ($is_all && (($cES_fragments=Null:C1517) || ($cES_fragments.length=0)))
		$cES_fragments:=$vJ_zen_fragments.lb_selection
	End if 
	// *
	// *****
	
	
	
Function _do_language()
	var $is_idle; $isOk : Boolean
	var $vC_at_keys; $vC_answer : Collection
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	var $cES_fragments : cs:C1710.FRAGMENTSSelection
	var $cE_SPEECHES : cs:C1710.SPEECHESEntity
	var $tt : Integer
	var $vT_title; $vT_yinISO2; $vT_yangISO2; $vT_refMenu; $vT_prefix; $vT_ISO2; $vT_answerMenu; $vT_field : Text
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	$cES_fragments:=This:C1470._lb_fragments_c4ES(True:C214)
	$tt:=$cES_fragments.length
	$vT_title:="Set language of "+wox_str_pluralise($tt; "line")
	$cE_SPEECHES:=Form:C1466.c4E
	$vT_yinISO2:=$cE_SPEECHES.yinISO2
	$vT_yangISO2:=$cE_SPEECHES.yangISO2
	
	$is_idle:=True:C214
	$vT_refMenu:=Create menu:C408()
	x_header_menu($vT_refMenu; $vT_title)
	$vC_at_keys:=New collection:C1472()
	$vC_at_keys.push("yin"; "yang")
	For each ($vT_prefix; $vC_at_keys)
		$vT_ISO2:=$cE_SPEECHES[$vT_prefix+"ISO2"]
		wox_ISO2_menu($vT_prefix; $vT_prefix+" language"; $vT_ISO2; $is_idle; Null:C1517; $vT_refMenu)
	End for each 
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=$vT_answerMenu#""
	If ($isOk)
		$vC_answer:=Split string:C1554($vT_answerMenu; ".")
		$vT_prefix:=$vC_answer[0]
		$vT_ISO2:=$vC_answer[1]
		$vT_field:=$vT_prefix+"ISO2"
		For each ($cE_fragments; $cES_fragments)
			$cE_ORWELLS:=$cE_fragments.FRAGMENTS_ORWELLS
			$cE_ORWELLS[$vT_field]:=$vT_ISO2
			zen_entity_save($cE_ORWELLS)
		End for each 
		This:C1470.FRAGMENTS_upd()
	End if 
	
	
Function FRAGMENTS_upd()
	var $vJ_zen_fragments : Object
	var $vT_zen_fragments : Text
	$vT_zen_fragments:="zen_fragments"
	$vJ_zen_fragments:=OBJECT Get value:C1743($vT_zen_fragments)
	$vJ_zen_fragments.refresh()
	
	
Function _do_translate()
	var $is_idle; $isOk : Boolean
	var $vC_at_keys; $vC_at_answer : Collection
	var $cE_fragments : cs:C1710.FRAGMENTSEntity
	var $cES_fragments : cs:C1710.FRAGMENTSSelection
	var $tt; $k : Integer
	var $vT_title; $vT_refMenu; $vT_prefix; $vT_answerMenu : Text
	var $vT_path_menu; $vT_icon; $vT_label; $vT_source; $vT_target; $vT_sourceISO2_field; $vT_targetISO2_field; $vT_source_field; $vT_target_field; $vT_sourceISO2; $vT_targetISO2; $vT_answer : Text
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	$cES_fragments:=This:C1470._lb_fragments_c4ES(True:C214)
	$tt:=$cES_fragments.length
	$vT_title:="Translate "+wox_str_pluralise($tt; "line")
	
	$is_idle:=True:C214
	$vT_refMenu:=Create menu:C408()
	x_header_menu($vT_refMenu; $vT_title)
	$vC_at_keys:=New collection:C1472()
	$vC_at_keys.push("yang.yin"; "yin.yang")
	$vT_path_menu:="path:/RESOURCES/metier/icn_"
	For each ($vT_prefix; $vC_at_keys)
		//$vT_label:=Replace string($vT_prefix; "."; " → ")
		$k:=Position:C15("."; $vT_prefix)
		$vT_icon:=Substring:C12($vT_prefix; $k+1)
		$vT_label:="→ "+$vT_icon
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu; -1; $vT_prefix)
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+$vT_icon+k_png_ext)
	End for each 
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=$vT_answerMenu#""
	If ($isOk)
		If (waz_io_confirm_popup("Are you sure?"))
			$vC_at_answer:=Split string:C1554($vT_answerMenu; ".")
			$vT_source:=$vC_at_answer[0]
			$vT_target:=$vC_at_answer[1]
			$vT_sourceISO2_field:=$vT_source+"ISO2"
			$vT_targetISO2_field:=$vT_target+"ISO2"
			$vT_source_field:=$vT_source+"Tongue"
			$vT_target_field:=$vT_target+"Tongue"
			For each ($cE_fragments; $cES_fragments)
				$cE_ORWELLS:=$cE_fragments.FRAGMENTS_ORWELLS
				$vT_source:=$cE_ORWELLS[$vT_source_field]
				$vT_sourceISO2:=$cE_ORWELLS[$vT_sourceISO2_field]
				$vT_targetISO2:=$cE_ORWELLS[$vT_targetISO2_field]
				$vT_answer:=This:C1470.translate($vT_source; $vT_sourceISO2; $vT_targetISO2)
				If ($vT_answer#"")
					$cE_ORWELLS[$vT_target_field]:=$vT_answer
				End if 
				zen_entity_save($cE_ORWELLS)
			End for each 
			This:C1470.FRAGMENTS_upd()
		End if 
	End if 
	
	
Function translate($vT_source : Text; $vT_sourceISO2 : Text; $vT_targetISO2 : Text)->$vT_answer : Text
	If ($vT_sourceISO2#"") && ($vT_targetISO2#"")
		If ($vT_sourceISO2=$vT_targetISO2)
			$vT_answer:=$vT_source
		Else 
			$vT_answer:=wox_ISO2_translate($vT_source; $vT_sourceISO2; $vT_targetISO2; True:C214)
		End if 
	Else 
		cs:C1710.wox.SOUNDS.me.play_glop_no()
	End if 
	
	
	
	//Function print()
	//var $cE_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSEntity
	//var $cES_ZEN_DOCUMENTS : cs.ZEN_DOCUMENTSSelection
	//$cES_ZEN_DOCUMENTS:=zen__ds.ZEN_DOCUMENTS.query("name = :1"; "MY FIRST DOC")
	//If ($cES_ZEN_DOCUMENTS.length>0)
	//$cE_ZEN_DOCUMENTS:=$cES_ZEN_DOCUMENTS.first()
	//zen_record_doc_print(Form.c4E; $cE_ZEN_DOCUMENTS; True)
	//End if
	
	