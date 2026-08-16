
Class constructor($c4E_speeches : 4D:C1709.Entity)
	var $vL_typeFenetrePop; $vL_windowRef : Integer
	var $vJ_form; $vJ_pref_file; $vJ_prefs : Object
	var $vT_form : Text
	var $isOk : Boolean
	
	$vT_form:="SPEECH_PLAY"
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
			This:C1470._load()
			
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_first")
					This:C1470._first()
				: ($vT_objectName="btn_previous")
					This:C1470._previous()
				: ($vT_objectName="btn_next")
					This:C1470._next()
				: ($vT_objectName="btn_last")
					This:C1470._last()
				: ($vT_objectName="oL_ruler")
					This:C1470._ruler_click()
					
				: ($vT_objectName="bt_esc")
					CANCEL:C270
					
			End case 
			
		: ($vL_event_code=On Resize:K2:27)
			This:C1470._display()
	End case 
	// *
	// *****
	
	
Function _load()
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_playOrder; $vL_cards_count : Integer
	var $vT_format; $vT_oL_ruler : Text
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
	$vT_oL_ruler:="oL_ruler"
	$vT_format:=OBJECT Get format:C894(*; $vT_oL_ruler)
	$vT_format:="1;"+String:C10($vL_cards_count)+";1;1;18;### ##0"  // 1;25;1;1;18;### ##0
	OBJECT SET FORMAT:C236(*; $vT_oL_ruler; $vT_format)
	
	Form:C1466.c4ES:=$cES_FRAGMENTS
	Form:C1466.l_position:=0
	This:C1470._update()
	Form:C1466.is_QA:=False:C215
	
	
Function _update()
	var $cE_CATEGORIES : cs:C1710.CATEGORIESEntity
	var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_cards_count; $vL_cards_position; $vL_colors; $vL_stroke; $vL_fill : Integer
	var $vP_oT_order : Pointer
	var $vT_cat_label; $vT_label : Text
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=Form:C1466.l_position
	
	If ($cES_FRAGMENTS.length>0)
		$cE_FRAGMENTS:=$cES_FRAGMENTS[$vL_cards_position]
		Form:C1466.c4E:=$cE_FRAGMENTS
		
		$vT_cat_label:="vT_cat_lbl"
		$cE_CATEGORIES:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS.ORWELLS_CATEGORIES
		$vT_label:=$cE_CATEGORIES.label
		$vL_colors:=$cE_CATEGORIES.colors
		OBJECT SET VALUE:C1742($vT_cat_label; $vT_label)
		woc_sp_colors_to_rgb($vL_colors; ->$vL_stroke; ->$vL_fill)
		OBJECT SET RGB COLORS:C628(*; $vT_cat_label; $vL_stroke; $vL_fill)
		OBJECT SET VISIBLE:C603(*; $vT_cat_label; $vT_label#"")
		
		$vP_oT_order:=OBJECT Get pointer:C1124(Object named:K67:5; "oT_order")
		OBJECT SET VALUE:C1742("oT_order"; String:C10($vL_cards_position+1)+"/"+String:C10($vL_cards_count))
		OBJECT SET VALUE:C1742("vL_order"; $cE_FRAGMENTS.order)
		This:C1470._display()
	End if 
	This:C1470._btn_update()
	
	
Function _display()
	var $is_yinYang_QA : Boolean
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_cards_count; $vL_cards_position; $vL_yinYang_msk : Integer
	var $vJ_cards : Object
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=Form:C1466.l_position
	
	$vL_yinYang_msk:=This:C1470._yinYang_msk(Form:C1466.l_yinYang)
	$is_yinYang_QA:=$vL_yinYang_msk ?? 2  // Add a flip flop to True/wood
	If ($is_yinYang_QA)
		$vL_yinYang_msk:=Num:C11(Form:C1466.is_QA)+1
	End if 
	$vJ_cards:=New object:C1471
	$vJ_cards.l_cards:=$vL_cards_count
	$vJ_cards.l_card:=$vL_cards_position
	$vJ_cards.l_yinYang_msk:=$vL_yinYang_msk
	This:C1470._play_svg($vJ_cards; $cES_FRAGMENTS)
	
	
Function _btn_update()
	var $is_not_first; $is_not_last; $is_yinYang_QA : Boolean
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_cards_count; $vL_cards_position; $vL_yinYang_msk : Integer
	var $vT_oL_ruler : Text
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=Form:C1466.l_position
	$is_not_first:=($vL_cards_position>0)
	If (Not:C34($is_not_first))
		$vL_yinYang_msk:=This:C1470._yinYang_msk(Form:C1466.l_yinYang)
		$is_yinYang_QA:=$vL_yinYang_msk ?? 2  // Add a flip flop to True/wood
		$is_not_first:=$is_yinYang_QA ? Form:C1466.is_QA : False:C215
	End if 
	
	$is_not_last:=($vL_cards_position<($vL_cards_count-1))
	If (Not:C34($is_not_last))
		$vL_yinYang_msk:=This:C1470._yinYang_msk(Form:C1466.l_yinYang)
		$is_yinYang_QA:=$vL_yinYang_msk ?? 2  // Add a flip flop to True/wood
		$is_not_last:=$is_yinYang_QA ? Not:C34(Form:C1466.is_QA) : False:C215
	End if 
	OBJECT SET ENABLED:C1123(*; "btn_first"; $is_not_first)
	OBJECT SET ENABLED:C1123(*; "btn_previous"; $is_not_first)
	OBJECT SET ENABLED:C1123(*; "btn_next"; $is_not_last)
	OBJECT SET ENABLED:C1123(*; "btn_last"; $is_not_last)
	
	$vT_oL_ruler:="oL_ruler"
	OBJECT SET VALUE:C1742($vT_oL_ruler; $vL_cards_position+1)
	
	
Function _yinYang_msk($vL_yinYang : Integer)->$vL_yinYang_msk : Integer
	var $vC_yinYang_msk : Collection
	var $vJ_menu : Object
	$vJ_menu:=orw__storage_menuBtns().m_yinYangPlay
	$vC_yinYang_msk:=$vJ_menu.al_yinYang_msk
	$vL_yinYang_msk:=$vC_yinYang_msk[$vL_yinYang]
	
	
	
Function _first()
	var $vL_cards_position : Integer
	Form:C1466.is_QA:=False:C215
	$vL_cards_position:=Form:C1466.l_position
	If ($vL_cards_position>0)
		$vL_cards_position:=0
		Form:C1466.l_position:=$vL_cards_position
		This:C1470._update()
	Else 
		BEEP:C151
	End if 
	
Function _previous()
	var $vL_cards_position; $vL_yinYang_msk : Integer
	var $is_yinYang_QA; $isOk; $is_QA; $is_previous : Boolean
	$vL_yinYang_msk:=This:C1470._yinYang_msk(Form:C1466.l_yinYang)
	$is_yinYang_QA:=$vL_yinYang_msk ?? 2  // Add a flip flop to True/wood
	$isOk:=False:C215
	If ($is_yinYang_QA)
		$is_QA:=Form:C1466.is_QA
		If ($is_QA)
			$is_QA:=False:C215
			$is_previous:=False:C215
			$isOk:=True:C214
		Else 
			$is_QA:=True:C214
			$is_previous:=True:C214
		End if 
		Form:C1466.is_QA:=$is_QA
	Else 
		$is_previous:=True:C214
	End if 
	If ($is_previous)
		$vL_cards_position:=Form:C1466.l_position
		If ($vL_cards_position>0)
			$vL_cards_position+=-1
			Form:C1466.l_position:=$vL_cards_position
			$isOk:=True:C214
		End if 
	End if 
	If ($isOk)
		This:C1470._update()
	Else 
		BEEP:C151
	End if 
	
	
Function _next()
	var $is_yinYang_QA; $isOk; $is_QA; $is_next : Boolean
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_yinYang_msk; $vL_cards_count; $vL_cards_position : Integer
	$vL_yinYang_msk:=This:C1470._yinYang_msk(Form:C1466.l_yinYang)
	$is_yinYang_QA:=$vL_yinYang_msk ?? 2  // Add a flip flop to True/wood
	$isOk:=False:C215
	If ($is_yinYang_QA)
		$is_QA:=Form:C1466.is_QA
		If ($is_QA)
			$is_QA:=False:C215
			$is_next:=True:C214
		Else 
			$is_QA:=True:C214
			$is_next:=False:C215
			$isOk:=True:C214
		End if 
		Form:C1466.is_QA:=$is_QA
	Else 
		$is_next:=True:C214
	End if 
	If ($is_next)
		$cES_FRAGMENTS:=Form:C1466.c4ES
		$vL_cards_count:=$cES_FRAGMENTS.length
		$vL_cards_position:=Form:C1466.l_position
		If ($vL_cards_position<($vL_cards_count-1))
			$vL_cards_position+=1
			Form:C1466.l_position:=$vL_cards_position
			$isOk:=True:C214
		End if 
	End if 
	If ($isOk)
		This:C1470._update()
	Else 
		BEEP:C151
	End if 
	
	
	
Function _last()
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_cards_count; $vL_cards_position : Integer
	Form:C1466.is_QA:=False:C215
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=Form:C1466.l_position
	If ($vL_cards_position<($vL_cards_count-1))
		$vL_cards_position:=$vL_cards_count-1
		Form:C1466.l_position:=$vL_cards_position
		This:C1470._update()
	Else 
		BEEP:C151
	End if 
	
	
Function _ruler_click()
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_cards_count; $vL_cards_position : Integer
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=OBJECT Get value:C1743("oL_ruler")-1
	$vL_cards_position:=wox_max(0; wox_min($vL_cards_count-1; $vL_cards_position))
	Form:C1466.l_position:=$vL_cards_position
	Form:C1466.is_QA:=False:C215
	This:C1470._update()
	
	
Function _canvas_click($vP_canvas : Pointer)
	var $isOk : Boolean
	var $vL_cards_position : Integer
	var $vT_idSvg : Text
	Case of 
		: (Form event code:C388=On Mouse Move:K2:35)
			
		: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Double Clicked:K2:5)
			If (Right click:C712)
				If (waz_io_confirm_popup("Copy to pasteboard?"))
					SET PICTURE TO PASTEBOARD:C521($vP_canvas->)
				End if 
			Else 
				$isOk:=True:C214
				$vT_idSvg:=SVG Find element ID by coordinates:C1054($vP_canvas->; mouseX; mouseY)  // ID de l'élément svg survolé
				$vL_cards_position:=0
				If ($vT_idSvg#"root")
					Case of 
						: (Position:C15("no_"; $vT_idSvg)=1)
							$vL_cards_position:=Num:C11($vT_idSvg)
							
							//: (Position("id_truth";$idSvg)=1)
							//: (Position("id_wood";$idSvg)=1)
						Else 
							$isOk:=False:C215
					End case 
				End if 
				If ($isOk)
					Form:C1466.l_position:=$vL_cards_position
					Form:C1466.is_QA:=False:C215
					This:C1470._update()
				End if 
			End if 
	End case 
	
	
	
Function _play_svg($vJ_cards : Object; $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection)
	var $is_card_current : Boolean
	var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity
	var $vL_cards_count; $vL_cards_position; $vL_yinYang_msk; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_svg_height; $vL_svg_width; $vL_svg_scale; $vL_center_x; $vL_color_bkg; $vL_font_size; $vL_font_style; $vL_font_align; $vL_padding; $vL_x_left; $vL_x_right; $vL_card_width; $vL_text_width; $vL_y_top; $vL_y_bottom; $vL_gap; $vL_card_height; $vL_text_height; $vL_y_top_truth; $vL_y_top_wood; $vL_truth_pattern; $vL_wood_pattern; $vL_colors; $vL_pat_stroke; $vL_pat_fill; $vL_width; $vL_height; $y; $vL_w; $vL_h; $x; $vL_rxy; $vL_paddingD2; $vL_cards_w; $vL_card_w; $vL_card_h; $vL_size; $idx; $vL_pattern; $x1; $y1; $vL_size1; $vL_offset; $x2; $y2 : Integer
	var $vO_img : Picture
	var $vP_canvas; $vP_oT_txt : Pointer
	var $vR_ratio; $vR_coef : Real
	var $vT_svg_id; $vT_color_bkg_svg; $vT_object; $vT_font_name; $vT_key_stroke_svg; $vT_key_fill_svg; $vT_pat_stroke_svg; $vT_pat_fill_svg; $vT_patt_yin_name; $vT_patt_yang_name; $txt; $vT_g; $vT_idText; $vT_path; $vT_svg_b; $vT_dot_stroke_svg; $vT_dot_fill_svg; $vT_patt_name : Text
	
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "canvas")
	$vP_oT_txt:=OBJECT Get pointer:C1124(Object named:K67:5; "oT_txt")
	
	$cE_FRAGMENTS:=Form:C1466.c4E
	$vL_cards_count:=$vJ_cards.l_cards
	$vL_cards_position:=$vJ_cards.l_card
	$vL_yinYang_msk:=$vJ_cards.l_yinYang_msk
	
	OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_svg_height:=$vL_bottom-$vL_top
	$vL_svg_width:=$vL_right-$vL_left
	$vL_svg_scale:=2
	$vL_svg_width:=$vL_svg_width*$vL_svg_scale
	$vL_svg_height:=$vL_svg_height*$vL_svg_scale
	
	$vL_center_x:=$vL_svg_width/2
	$vL_color_bkg:=k_MDcolorGrey-2
	
	$vT_svg_id:=SVG_New($vL_svg_width; $vL_svg_height)
	If ($vL_color_bkg#k_MDcolorTransparent)
		$vT_color_bkg_svg:=woc_sp_color_to_svg($vL_color_bkg)
		$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_svg_width; $vL_svg_height; 0; 0; $vT_color_bkg_svg; $vT_color_bkg_svg; 0)
	End if 
	
	$vT_font_name:="Calibri"
	
	$vR_coef:=$vL_svg_width/1400
	$vL_font_size:=80*$vR_coef
	$vL_font_style:=Bold:K14:2
	$vL_font_align:=3
	
	$vL_padding:=$vL_svg_width*0.01
	$vL_x_left:=$vL_svg_width*0.02
	$vL_x_right:=$vL_x_left
	$vL_card_width:=$vL_svg_width-$vL_x_left-$vL_x_right
	$vL_text_width:=$vL_card_width-($vL_padding*2)
	
	// TWO cards in height
	$vL_y_top:=$vL_x_left
	$vL_y_bottom:=$vL_svg_height*0.3
	
	$vL_gap:=20*$vL_svg_scale
	$vL_card_height:=$vL_svg_height-$vL_y_top-$vL_y_bottom-$vL_gap/2
	$vL_text_height:=$vL_card_height-($vL_padding*2)
	
	$vL_y_top_truth:=$vL_y_top
	$vL_y_top_wood:=$vL_y_top_truth+$vL_card_height+$vL_gap
	
	$vL_truth_pattern:=20
	$vL_wood_pattern:=22
	
	$vL_colors:=$cE_FRAGMENTS.colors
	woc_sp_colors_to_svg($vL_colors; ->$vT_key_stroke_svg; ->$vT_key_fill_svg)
	
	woc_sp_colors_to_sf($vL_colors; ->$vL_pat_stroke; ->$vL_pat_fill)
	$vL_colors:=woc_sp_colors_from_sf($vL_pat_fill+4; $vL_pat_fill)
	woc_sp_colors_to_svg($vL_colors; ->$vT_pat_stroke_svg; ->$vT_pat_fill_svg)
	$vT_patt_yin_name:="yinPattern"
	$vT_patt_yang_name:="yangPattern"
	woc_svg_patterns($vT_svg_id; $vT_patt_yin_name; $vL_truth_pattern; $vT_pat_stroke_svg; $vT_pat_fill_svg)
	woc_svg_patterns($vT_svg_id; $vT_patt_yang_name; $vL_wood_pattern; $vT_pat_stroke_svg; $vT_pat_fill_svg)
	
	// Truth
	If ($vL_yinYang_msk ?? 0)
		$txt:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS.yinTongue
		$txt:=This:C1470._clean_text($txt; Char:C90(Carriage return:K15:38))
		$vT_g:=SVG_New_group($vT_svg_id)
		$vT_object:=SVG_New_rect($vT_g; $vL_x_left; $vL_y_top_truth; $vL_card_width; $vL_card_height; 0; 0; $vT_key_stroke_svg; "url(#"+$vT_patt_yin_name+")"; 2*$vL_svg_scale)
		
		OBJECT SET FONT:C164($vP_oT_txt->; $vT_font_name)
		OBJECT SET FONT SIZE:C165($vP_oT_txt->; $vL_font_size)
		OBJECT SET FONT STYLE:C166($vP_oT_txt->; $vL_font_style)
		$vP_oT_txt->:=$txt
		OBJECT GET BEST SIZE:C717($vP_oT_txt->; $vL_width; $vL_height; $vL_text_width)
		$y:=$vL_y_top_truth+(($vL_card_height-$vL_height)/2)
		$vT_idText:=SVG_New_textArea($vT_g; $txt; $vL_x_left+$vL_padding; $y; $vL_text_width; $vL_height; $vT_font_name; $vL_font_size; $vL_font_style; $vL_font_align)
		SVG_SET_FONT_COLOR($vT_idText; $vT_key_stroke_svg; $vT_key_stroke_svg)
		SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
		SVG_SET_ID($vT_g; "id_truth")
		
		$vT_path:=Get 4D folder:C485(Current resources folder:K5:16)+"metier"+Folder separator:K24:12+"icnb_yinTongue.png"
		READ PICTURE FILE:C678($vT_path; $vO_img)
		PICTURE PROPERTIES:C457($vO_img; $vL_w; $vL_h)
		$x:=$vL_x_left-($vL_w/2)
		$y:=$vL_y_top_truth-($vL_h/2)
		$vT_svg_b:=SVG_New_embedded_image($vT_g; $vO_img; $x; $y)
	End if 
	
	// Wood
	If ($vL_yinYang_msk ?? 1)
		$txt:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS.yangTongue
		$txt:=This:C1470._clean_text($txt; Char:C90(Carriage return:K15:38))
		$vT_g:=SVG_New_group($vT_svg_id)
		//$object:=SVG_New_rect ($g;$x_left;$y_top_wood;$card_width;$card_height;0;0;$key_stroke_svg;$key_fill_svg;2*$vL_svg_scale)
		$vT_object:=SVG_New_rect($vT_g; $vL_x_left; $vL_y_top_wood; $vL_card_width; $vL_card_height; 0; 0; $vT_key_stroke_svg; "url(#"+$vT_patt_yang_name+")"; 2*$vL_svg_scale)
		//$idText:=SVG_New_textArea ($g;$txt;$x_left+$padding;$y_top_wood+$padding;$text_width;$text_height;$font_name;$font_size;$font_style;$font_align)
		
		OBJECT SET FONT:C164($vP_oT_txt->; $vT_font_name)
		OBJECT SET FONT SIZE:C165($vP_oT_txt->; $vL_font_size)
		OBJECT SET FONT STYLE:C166($vP_oT_txt->; $vL_font_style)
		$vP_oT_txt->:=$txt
		OBJECT GET BEST SIZE:C717($vP_oT_txt->; $vL_width; $vL_height; $vL_text_width)
		$y:=$vL_y_top_wood+(($vL_card_height-$vL_height)/2)
		$vT_idText:=SVG_New_textArea($vT_g; $txt; $vL_x_left+$vL_padding; $y; $vL_text_width; $vL_text_height; $vT_font_name; $vL_font_size; $vL_font_style; $vL_font_align)
		
		SVG_SET_FONT_COLOR($vT_idText; $vT_key_stroke_svg; $vT_key_stroke_svg)
		SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
		SVG_SET_ID($vT_g; "id_wood")
		
		$vT_path:=Get 4D folder:C485(Current resources folder:K5:16)+"metier"+Folder separator:K24:12+"icnb_yangTongue.png"
		READ PICTURE FILE:C678($vT_path; $vO_img)
		PICTURE PROPERTIES:C457($vO_img; $vL_w; $vL_h)
		$x:=$vL_x_left-($vL_w/2)
		$y:=$vL_y_top_wood-($vL_h/2)
		$vT_svg_b:=SVG_New_embedded_image($vT_g; $vO_img; $x; $y)
	End if 
	
	// ALL CARDS
	// $y_bottom : $svg_height : $x_left ; $x_right
	
	//$ptr_aT_cat_lbl:=$5
	//$ptr_aL_cat_colors:=$6
	
	
	$vL_rxy:=5*$vL_svg_scale
	$vL_padding:=$vL_svg_width*0.01
	$vL_paddingD2:=$vL_padding/2
	$vL_cards_w:=$vL_svg_width-($vL_padding*2)
	$vL_card_w:=$vL_cards_w/$vL_cards_count
	
	
	// ***** Reformate to ratio
	// *
	$vR_ratio:=43/67  // 0.64
	$vR_coef:=0.6
	$vL_card_h:=($vL_y_bottom*$vR_coef)-($vL_padding*2)
	$vL_card_w:=wox_min($vL_card_w; $vL_card_h*$vR_ratio)
	$vL_card_h:=$vL_card_w/$vR_ratio
	$vL_cards_w:=$vL_card_w*$vL_cards_count
	
	$vL_size:=$vL_card_h/8
	
	$y:=$vL_svg_height-$vL_card_h
	$x:=$vL_center_x-($vL_cards_w/2)+$vL_paddingD2
	
	$cES_FRAGMENTS:=Form:C1466.c4ES
	$vL_cards_count:=$cES_FRAGMENTS.length
	$vL_cards_position:=Form:C1466.l_position
	$idx:=0
	For each ($cE_FRAGMENTS; $cES_FRAGMENTS)
		$is_card_current:=($vL_cards_position=$idx)
		$vL_colors:=$cE_FRAGMENTS.colors
		woc_sp_colors_to_svg(woc_sp_colors_inverse($vL_colors; False:C215); ->$vT_dot_stroke_svg; ->$vT_dot_fill_svg)
		If ($is_card_current)  // Plain size
			woc_sp_colors_to_sf($vL_colors; ->$vL_pat_stroke; ->$vL_pat_fill)
			$vL_colors:=woc_sp_colors_from_sf($vL_pat_fill; $vL_pat_fill+1)
			woc_sp_colors_to_svg($vL_colors; ->$vT_pat_stroke_svg; ->$vT_pat_fill_svg)
		Else 
			$vT_pat_fill_svg:="#DFDBE5"
			$vT_pat_stroke_svg:="#9c92ac"
		End if 
		
		$vT_patt_name:="cardPattern"+String:C10($idx)
		$vL_pattern:=4
		woc_svg_patterns($vT_svg_id; $vT_patt_name; $vL_pattern; $vT_pat_stroke_svg; $vT_pat_fill_svg)
		
		If ($is_card_current)  // Plain size
			$vL_w:=$vL_card_w/$vR_coef
			$vL_h:=$vL_card_h/$vR_coef
			$x1:=$x-(($vL_w-$vL_card_w)/2)
			$y1:=$y-($vL_h-$vL_card_h)
			$vL_size1:=$vL_size/$vR_coef
		Else 
			$vL_w:=$vL_card_w
			$vL_h:=$vL_card_h
			$x1:=$x
			$y1:=$y
			$vL_size1:=$vL_size
		End if 
		$vL_offset:=$vL_size1*0.7
		$vT_g:=SVG_New_group($vT_svg_id)
		$vT_object:=SVG_New_rect($vT_g; $x1; $y1; $vL_w-$vL_padding; $vL_h-$vL_padding; $vL_rxy; $vL_rxy; $vT_dot_stroke_svg; "url(#"+$vT_patt_name+")"; 2*$vL_svg_scale)
		$x2:=$x1+$vL_padding
		$y2:=$y1+$vL_padding
		$vT_object:=SVG_New_circle($vT_g; $x2; $y2; $vL_size1*0.8; $vT_dot_stroke_svg; $vT_dot_fill_svg; 1*$vL_svg_scale)
		$vT_idText:=SVG_New_text($vT_g; String:C10($idx+1); $x2; $y2-$vL_offset; $vT_font_name; $vL_size1; Bold:K14:2; 3; $vT_dot_stroke_svg)
		SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
		SVG_SET_ID($vT_g; "no_"+String:C10($idx))
		$x:=$x+$vL_card_w
		$idx+=1
	End for each 
	
	SVG EXPORT TO PICTURE:C1017($vT_svg_id; $vP_canvas->; Get XML data source:K45:16)
	SVG_CLEAR($vT_svg_id)
	
	
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
	