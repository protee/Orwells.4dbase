
Class constructor($c4E_speeches : 4D:C1709.Entity)
	var $vL_typeFenetrePop; $vL_windowRef : Integer
	var $vJ_form; $vJ_pref_file; $vJ_prefs : Object
	var $vT_form : Text
	var $isOk : Boolean
	
	$vT_form:="SPEECH_DSPLY"
	$vJ_pref_file:=zen__prefs_get_c4Fo.file($vT_form+".json")
	$vJ_prefs:=New object:C1471
	$isOk:=wox_prefs_load($vJ_pref_file; ->$vJ_prefs; 1)  // Version, increase to reset
	If (Not:C34($isOk))
		$vJ_prefs.is_size:=True:C214
	End if 
	
	$vJ_form:=New object:C1471
	$vJ_form.j_prefs:=$vJ_prefs
	$vJ_form.c4E_SPEECHES:=$c4E_speeches
	$vJ_form.fc:=This:C1470
	$vL_typeFenetrePop:=Plain dialog box:K34:4
	$vL_windowRef:=Open form window:C675($vT_form; $vL_typeFenetrePop; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE:C213("Speech \""+$c4E_speeches.label+"\""; $vL_windowRef)
	DIALOG:C40($vT_form; $vJ_form)
	CLOSE WINDOW:C154($vL_windowRef)
	wox_prefs_save($vJ_pref_file; $vJ_prefs)
	
	
	
	// *****
	// *
Function form_events($vL_event_code : Integer)
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Load:K2:1)
			wox_prefs_windows_load()
			This:C1470._lb_init()
			This:C1470._load()
			
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					//: ($vT_objectName="btn_first")
					//This._first()
					//: ($vT_objectName="btn_previous")
					//This._previous()
					//: ($vT_objectName="btn_next")
					//This._next()
					//: ($vT_objectName="btn_last")
					//This._last()
				: ($vT_objectName="LB")
					This:C1470._lb_click()
					
				: ($vT_objectName="bt_esc")
					CANCEL:C270
					
			End case 
			
		: ($vL_event_code=On Resize:K2:27)
			This:C1470._resize()
	End case 
	// *
	// *****
	
	
Function _lb_init()
	//$vT_LB:="LB"
	//LISTBOX SET AUTO ROW HEIGHT(*; $vT_LB; lk row min height; 20; lk pixels)  // 60 pixels for min value
	//LISTBOX SET AUTO ROW HEIGHT(*; $vT_LB; lk row max height; 250; lk pixels)  //and 100 pixels for max value
	//$vT_column:="LB_yin"
	//LISTBOX SET PROPERTY(*; $vT_column; lk auto row height; lk yes)
	//LISTBOX SET PROPERTY(*; $vT_column; lk allow wordwrap; lk yes)
	//$vT_column:="LB_yang"
	//LISTBOX SET PROPERTY(*; $vT_column; lk auto row height; lk yes)
	//LISTBOX SET PROPERTY(*; $vT_column; lk allow wordwrap; lk yes)
	
	
Function _load()
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_playOrder; $vL_cards_count : Integer
	$cES_FRAGMENTS:=ds:C1482.FRAGMENTS.query("UIDspeech = :1"; Form:C1466.c4E_SPEECHES.UID)
	$vL_playOrder:=Form:C1466.l_playOrder
	Case of 
		: ($vL_playOrder=0)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order")
			
		: ($vL_playOrder=1)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order DESC")
			
		: ($vL_playOrder=2)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderByFormula(Formula:C1597(Random:C100))
	End case 
	
	
	$vL_cards_count:=$cES_FRAGMENTS.length
	OBJECT SET VALUE:C1742("vL_count"; $vL_cards_count)
	Form:C1466.lb_selection:=$cES_FRAGMENTS
	This:C1470._lb_click()
	
	
Function _lb_meta_info($cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity)->$vJ_meta : Object
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $vL_colors : Integer
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$cE_FRAGMENTS.colors
	If ($vL_colors=0)
		$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
		$vL_colors:=$cE_ORWELLS.colors
	End if 
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta.stroke:=$vT_color_stroke
	$vJ_meta.fill:=$vT_color_fill
	
	
Function _lb_yinTongue($cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity)->$vT_answer : Text
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
	$vT_answer:=$cE_ORWELLS.yinTongue
	
	
Function _lb_yangTongue($cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity)->$vT_answer : Text
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
	$vT_answer:=$cE_ORWELLS.yangTongue
	
	
Function _lb_click()
	var $cE_CATEGORIES : cs:C1710.CATEGORIESEntity
	var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $vL_order; $vL_colors; $vL_stroke; $vL_fill : Integer
	var $vT_label; $vT_cat_label : Text
	var $is_visible : Boolean
	$vT_cat_label:="vT_cat_lbl"
	$cE_FRAGMENTS:=Form:C1466.lb_current
	$is_visible:=$cE_FRAGMENTS#Null:C1517
	If ($is_visible)
		$vL_order:=$cE_FRAGMENTS.order
		OBJECT SET VALUE:C1742("vL_order"; $vL_order)
		$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
		$cE_CATEGORIES:=$cE_ORWELLS.ORWELLS_CATEGORIES
		$is_visible:=$cE_CATEGORIES#Null:C1517
		If ($is_visible)
			$vT_label:=$cE_CATEGORIES.label
			OBJECT SET VALUE:C1742($vT_cat_label; $vT_label)
			$vL_colors:=$cE_CATEGORIES.colors
			woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
			OBJECT SET RGB COLORS:C628(*; $vT_cat_label; $vL_stroke; $vL_fill)
			OBJECT SET VISIBLE:C603(*; $vT_cat_label; $vT_label#"")
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*; $vT_cat_label; $is_visible)
	
	
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
	
	
Function _yinYang_msk($vL_yinYang : Integer)->$vL_yinYang_msk : Integer
	var $vC_yinYang_msk : Collection
	var $vJ_menu : Object
	$vJ_menu:=app__storage_menuBtns().m_yinYangPlay
	$vC_yinYang_msk:=$vJ_menu.al_yinYang_msk
	$vL_yinYang_msk:=$vC_yinYang_msk[$vL_yinYang]
	
	
Function _resize()
	var $is_yin; $is_yang : Boolean
	var $vL_yinYang; $vL_yinYang_msk; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_widthD2; $vL_width_yin; $vL_width_yang : Integer
	var $vT_yin; $vT_yang : Text
	$vL_yinYang:=Form:C1466.l_yinYang
	$vL_yinYang_msk:=This:C1470._yinYang_msk($vL_yinYang)
	
	OBJECT GET COORDINATES:C663(*; "LB"; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left-16
	$vL_widthD2:=$vL_width/2
	
	Case of 
		: ($vL_yinYang_msk=1)
			$vL_width_yin:=$vL_width
			$vL_width_yang:=0
			
		: ($vL_yinYang_msk=2)
			$vL_width_yin:=0
			$vL_width_yang:=$vL_width
			
		Else 
			$vL_width_yin:=$vL_widthD2
			$vL_width_yang:=$vL_widthD2
	End case 
	$is_yin:=$vL_width_yin#0
	$is_yang:=$vL_width_yang#0
	$vT_yin:="lb_yin"
	$vT_yang:="lb_yang"
	OBJECT SET VISIBLE:C603(*; $vT_yin; $is_yin)
	If ($is_yin)
		LISTBOX SET COLUMN WIDTH:C833(*; $vT_yin; $vL_width_yin)
	End if 
	OBJECT SET VISIBLE:C603(*; $vT_yang; $is_yang)
	If ($is_yang)
		LISTBOX SET COLUMN WIDTH:C833(*; $vT_yang; $vL_width_yang)
	End if 
	
	