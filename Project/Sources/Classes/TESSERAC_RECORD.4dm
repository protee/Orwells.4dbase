
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	//If (Form.is_new)
	//$vJ_fields:=Form.c4E.fields
	//$vJ_fields.l_cube:=-2012004047
	//$vJ_fields.is_cube1:=True
	//$vJ_fields.is_cube2:=True
	//$vJ_fields.l_lines:=-2012319448
	//$vJ_fields.is_lines1:=False
	//$vJ_fields.is_lines2:=False
	//$vJ_fields.l_polygons:=-2011999921
	//$vJ_fields.is_poly_fill:=False
	//$vJ_fields.is_poly_stroke:=True
	//$vJ_fields.l_bkg:=134218202
	//$vJ_fields.l_stroke:=3
	//$vJ_fields.l_angle:=30
	////$vJ_fields.l_count:=6
	//This.widgets_upd()
	//End if 
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
				: ($vT_objectName="oO_svg")
					This:C1470.redraw()
					
				: ($vT_objectName="oO_svg1")
					This:C1470.redraw()
					
				: ($vT_objectName="btn_square")
					This:C1470.square()
					
			End case 
			
		: ($vL_event_code=On Double Clicked:K2:5)
			Case of 
				: ($vT_objectName="oO_svg")
					This:C1470._copy_PP($vT_objectName)
					
				: ($vT_objectName="oO_svg1")
					This:C1470._copy_PP($vT_objectName)
			End case 
			
			
		: ($vL_event_code=On Resize:K2:27)
			SET TIMER:C645(1)
			
		: ($vL_event_code=On Timer:K2:25)
			SET TIMER:C645(0)
			This:C1470.redraw()
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	//Function widgets_upd()
	//var $vC_at_widgets : Collection
	//var $vJ_widget : Object
	//var $vT_widget : Text
	//$vC_at_widgets:=New collection()
	//$vC_at_widgets.push("waz_angle"; "waz_stroke"; "woc_cube"; "woc_polygons"; "woc_lines"; "woc_bkg")
	//$vC_at_widgets.push("waz_isCube1"; "waz_isCube2"; "waz_isPoly_stroke"; "waz_isPoly_fill")
	//$vC_at_widgets.push("waz_isLines1"; "waz_isLines2")
	//For each ($vT_widget; $vC_at_widgets)
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$vJ_widget.redraw()
	//End for each 
	
	
	
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
	$vP_svg->:=orw_tesserac_svg_object($vP_svg; $vJ_fields)
	$vP_svg1:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg1")
	$vP_svg1->:=orw_tesserac_svg_object($vP_svg1; $vJ_fields)
	
	
Function square()
	var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_width; $vL_height; $vL_wh : Integer
	var $vP_svg : Pointer
	$vP_svg:=OBJECT Get pointer:C1124(Object named:K67:5; "oO_svg")
	OBJECT GET COORDINATES:C663($vP_svg->; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vL_width:=$vL_right-$vL_left
	$vL_height:=$vL_bottom-$vL_top
	$vL_wh:=wox_min($vL_width; $vL_height)
	$vL_width:=$vL_wh-$vL_width
	$vL_height:=$vL_wh-$vL_height
	RESIZE FORM WINDOW:C890($vL_width; $vL_height)
	
	
Function start_timer()
	SET TIMER:C645(-1)
	//$ptr_factor->:=0
	
Function stop_timer()
	SET TIMER:C645(0)
	
	