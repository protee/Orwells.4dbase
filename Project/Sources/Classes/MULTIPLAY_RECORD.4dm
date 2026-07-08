
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	var $vJ_fields : Object
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	If (Form:C1466.is_new)
		$vJ_fields:=Form:C1466.c4E.fields
		$vJ_fields.l_bkg:=255
		$vJ_fields.l_count:=133
		$vJ_fields.l_dash:=0
		$vJ_fields.l_dots:=-2011684506
		$vJ_fields.l_lines:=134217762
		$vJ_fields.l_stroke:=3
		$vJ_fields.l_type:=1
		$vJ_fields.r_factor:=34
		This:C1470.widgets_upd()
	End if 
	This:C1470.oO_types_load()
	This:C1470.oO_types_redraw()
	This:C1470.redraw()
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	$c4E_entity:=Form:C1466.c4E
	var $vJ_okValidate : Object
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.label=""); True:C214; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=Form:C1466.is_touched
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
				: ($vT_objectName="btn_count_sub")
					This:C1470.btn_count(-1)
					
				: ($vT_objectName="btn_count_add")
					This:C1470.btn_count(1)
					
				: ($vT_objectName="btn_factor_sub")
					This:C1470.btn_factor(-1)
					
				: ($vT_objectName="btn_factor_add")
					This:C1470.btn_factor(1)
					
				: ($vT_objectName="oO_types")
					This:C1470.oO_types_click($vT_objectName)
					
				: ($vT_objectName="oO_svg")
					This:C1470.redraw()
					
				: ($vT_objectName="oO_svg1")
					This:C1470.redraw()
					
			End case 
			
		: ($vL_event_code=On Double Clicked:K2:5)
			Case of 
				: ($vT_objectName="oO_svg")
					This:C1470._copy_PP($vT_objectName)
					
				: ($vT_objectName="oO_svg1")
					This:C1470._copy_PP($vT_objectName)
			End case 
			
			
		: ($vL_event_code=On Timer:K2:25)
			This:C1470.timer()
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
Function btn_count($vL_value : Integer)
	var $vJ_fields; $vJ_widget : Object
	$vJ_fields:=Form:C1466.c4E.fields
	var $vL_count : Integer
	$vL_count:=$vJ_fields.l_count
	$vL_count+=$vL_value
	$vJ_fields.l_count:=$vL_count
	
	$vJ_widget:=OBJECT Get value:C1743("waz_count")
	$vJ_widget.redraw()
	This:C1470.redraw()
	
	
Function btn_factor($vL_value : Integer)
	var $vJ_fields; $vJ_widget : Object
	$vJ_fields:=Form:C1466.c4E.fields
	var $vR_factor : Real
	$vR_factor:=$vJ_fields.r_factor
	$vR_factor+=$vL_value
	$vJ_fields.r_factor:=$vR_factor
	
	$vJ_widget:=OBJECT Get value:C1743("waz_factor")
	$vJ_widget.redraw()
	This:C1470.redraw()
	
	
Function bt_play($vL_value : Integer)
	If ($vL_value=0)
		This:C1470.stop_timer()
	Else 
		This:C1470.start_timer()
	End if 
	
	
	
Function widgets_upd()
	var $vC_at_widgets : Collection
	var $vJ_widget : Object
	var $vT_widget : Text
	$vC_at_widgets:=New collection:C1472()
	$vC_at_widgets.push("waz_count"; "waz_factor"; "waz_stroke"; "woc_dots"; "woc_lines"; "woc_bkg")
	For each ($vT_widget; $vC_at_widgets)
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.redraw()
	End for each 
	
	
Function oO_types_load()
	var $vC_lbl; $vC_colors : Collection
	$vC_lbl:=New collection:C1472
	$vC_colors:=New collection:C1472
	$vC_lbl.push("1"; "2"; "3")
	$vC_colors.push(857649260; 857649414; 857649450)
	Form:C1466.at_type_lbl:=$vC_lbl
	Form:C1466.at_type_colors:=$vC_colors
	
	
Function oO_types_redraw($vT_objectName : Text)
	var $vC_lbl; $vC_colors : Collection
	var $vL_type : Integer
	var $vJ_field : Object
	var $vP_canvas : Pointer
	$vT_objectName:=$vT_objectName="" ? "oO_types" : $vT_objectName
	$vC_lbl:=Form:C1466.at_type_lbl
	$vC_colors:=Form:C1466.at_type_colors
	$vJ_field:=Form:C1466.c4E.fields
	$vL_type:=$vJ_field.l_type
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	f_types_svg($vP_canvas; $vC_lbl; $vC_colors; $vL_type)
	
	
Function oO_types_click($vT_objectName : Text)
	var $is_editing; $isOk : Boolean
	var $vC_lbl; $vC_colors : Collection
	var $vL_type : Integer
	var $vJ_field : Object
	var $vP_canvas : Pointer
	var $vT_idSvg : Text
	$vP_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$is_editing:=Form:C1466.is_editing
	If ($is_editing)
		$vT_idSvg:=SVG Find element ID by coordinates:C1054($vP_canvas->; mouseX; mouseY)  // ID de l'élément svg survolé
		If ($vT_idSvg#"root")
			If ($vT_idSvg="pro_@")
				$vL_type:=Num:C11($vT_idSvg)
				$isOk:=($vL_type>=0)
				If ($isOk)
					$vJ_field:=Form:C1466.c4E.fields
					$vJ_field.l_type:=$vL_type
					This:C1470.redraw()
					$vC_lbl:=Form:C1466.at_type_lbl
					$vC_colors:=Form:C1466.at_type_colors
					This:C1470.oO_types_redraw($vT_objectName)
				End if 
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
	
	
	
Function _copy_PP($vT_objectName : Text)
	var $vO_picture : Picture
	var $vP_svg : Pointer
	$vP_svg:=OBJECT Get pointer:C1124(Object named:K67:5; $vT_objectName)
	$vO_picture:=$vP_svg->
	CONVERT PICTURE:C1002($vO_picture; ".png")
	SET PICTURE TO PASTEBOARD:C521($vO_picture)
	wox_sounds_play_glop()
	
	
Function redraw()
	var $vJ_fields : Object
	var $vP_svg; $vP_svg1 : Pointer
	
	$vJ_fields:=Form:C1466.c4E.fields
	$vP_svg:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg")
	$vP_svg->:=orw_multiplay_svg_object($vP_svg; $vJ_fields)
	$vP_svg1:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg1")
	//$vP_svg1->:=$vP_svg->
	$vP_svg1->:=orw_multiplay_svg_object($vP_svg1; $vJ_fields)
	
	
Function start_timer()
	SET TIMER:C645(-1)
	//$ptr_factor->:=0
	
Function stop_timer()
	SET TIMER:C645(0)
	
	
Function timer()
	var $vL_count; $vL_factor; $vL_pgcd : Integer
	var $vJ_fields : Object
	var $vP_svg; $vP_pgcd; $vP_btn; $vP_svg1 : Pointer
	var $vR_factor : Real
	$vP_svg:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg")
	$vP_svg1:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg1")
	$vP_pgcd:=OBJECT Get pointer:C1124(Object named:K67:5; "oL_pgcd")
	
	$vJ_fields:=Form:C1466.c4E.fields
	$vL_count:=$vJ_fields.l_count
	$vR_factor:=$vJ_fields.r_factor
	
	If ($vR_factor<300)
		$vR_factor:=$vR_factor+0.01
		$vL_factor:=Int:C8($vR_factor)
		$vJ_fields.r_factor:=$vR_factor
		$vP_svg->:=orw_multiplay_svg_object($vP_svg; $vJ_fields)
		$vP_svg1->:=orw_multiplay_svg_object($vP_svg1; $vJ_fields)
		If (($vR_factor-$vL_factor)=0)
			SET TIMER:C645(60)
			$vJ_widget:=OBJECT Get value:C1743("waz_factor")
			$vJ_widget.redraw()
		Else 
			SET TIMER:C645(This:C1470.l_timer)
		End if 
	Else 
		SET TIMER:C645(0)
		$vP_btn:=OBJECT Get pointer:C1124(Object named:K67:5; "btn_play")
		x_btn_toggleSet($vP_btn; 0)
	End if 
	$vL_pgcd:=orw_euclide($vL_count; $vL_factor)
	$vP_pgcd->:=$vL_pgcd
	