//%attributes = {"lang":"en"}

var $vJ_widgets; $vJ_widget; $vJ_value; $vJ_pattern; $vJ_obj : Object
$vJ_widgets:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_widgets:=$vJ_widgets
End use 

Use ($vJ_widgets)
	// ***** orw_obj_settings – Object settings
	// *
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_obj_settings:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_tip:="Object"
	$vJ_widget.is_border:=False:C215
	$vJ_widget.l_mode:=0  // 0: is_stroke is_fill # DEFAULT
	// 1: is_internal is_external 2: is_lines1 is_lines2
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value  // No prefix as widget binded to record's fields
	$vJ_value.l_colors:=9  // Yin colors
	$vJ_value.is_stroke:=True:C214
	$vJ_value.is_fill:=False:C215
	$vJ_value.l_stroke:=2
	$vJ_value.l_opacity:=85
	
	
	// ***** orw_tesserac_settings – Yin yang
	// * scalars
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_tesserac_settings:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value  // No prefix as widget binded to record's fields
	$vJ_value.l_coef:=90  // Coef global
	$vJ_value.l_angle:=30  // Angle
	$vJ_value.l_stroke:=3  // Stroke
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_polygons:=$vJ_obj
	$vJ_obj.l_colors:=-2011999921
	$vJ_obj.is_stroke:=True:C214
	$vJ_obj.is_fill:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=90
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_cube:=$vJ_obj
	$vJ_obj.l_colors:=-2012004047
	$vJ_obj.is_internal:=True:C214
	$vJ_obj.is_external:=True:C214
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=90
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_lines:=$vJ_obj
	$vJ_obj.l_colors:=-2012319448
	$vJ_obj.is_lines1:=False:C215
	$vJ_obj.is_lines2:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=90
	
	$vJ_value.is_bkg:=True:C214
	$vJ_value.is_bkg_ellipse:=False:C215
	$vJ_pattern:=New shared object:C1526()
	$vJ_value.j_bkg:=$vJ_pattern
	$vJ_pattern.l_pattern:=35
	$vJ_pattern.l_colors:=134218202
	$vJ_pattern.l_rxy:=-1
	$vJ_pattern.l_stroke:=4
	$vJ_pattern.l_opacity:=100
	
	
	
	// ***** orw_yin_yang_settings – Yin yang
	// * scalars
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_yin_yang_settings:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value  // No prefix as widget binded to record's fields
	$vJ_value.l_coef:=100  // Coef global
	$vJ_value.l_angle:=0  // Angle
	$vJ_value.l_stroke:=3  // Stroke
	$vJ_value.l_coef_dots:=5  // Dots coef
	$vJ_value.l_gap:=5  // Gap between
	$vJ_value.is_reverse:=False:C215  // Reverse
	
	$vJ_value.l_yin:=0x88066061  // Yin colors
	$vJ_value.is_yinStroke:=True:C214
	$vJ_value.is_yinFill:=True:C214
	$vJ_value.l_yinOpacity:=100
	$vJ_value.l_yang:=0x8811C117  // Yang colors
	$vJ_value.is_yangStroke:=True:C214
	$vJ_value.is_yangFill:=True:C214
	$vJ_value.l_yangOpacity:=100
	
	$vJ_value.is_bkg:=False:C215
	$vJ_value.is_bkg_ellipse:=False:C215
	$vJ_pattern:=New shared object:C1526()
	$vJ_value.j_bkg:=$vJ_pattern
	$vJ_pattern.l_pattern:=71
	$vJ_pattern.l_colors:=0x330001EB  // [rale:0] – [rale:491]
	$vJ_pattern.l_rxy:=-1
	$vJ_pattern.l_stroke:=4
	$vJ_pattern.l_opacity:=100
	
	
	
	// ***** orw_circles_settings – Yin yang
	// * scalars
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_circles_settings:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value  // No prefix as widget binded to record's fields
	$vJ_value.l_coef:=100  // Coef global
	$vJ_value.l_coef_dots:=20  // Dots coef
	$vJ_value.l_angle:=90  // Angle
	$vJ_value.l_stroke:=3  // Stroke
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_yin:=$vJ_obj
	$vJ_obj.l_colors:=9  // Yin colors
	$vJ_obj.is_stroke:=True:C214
	$vJ_obj.is_fill:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=70
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_yang:=$vJ_obj
	$vJ_obj.l_colors:=9  // Yin colors
	$vJ_obj.is_stroke:=True:C214
	$vJ_obj.is_fill:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=70
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_yinHorto:=$vJ_obj
	$vJ_obj.l_colors:=9  // Yang colors
	$vJ_obj.is_stroke:=True:C214
	$vJ_obj.is_fill:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=70
	
	$vJ_obj:=New shared object:C1526()
	$vJ_value.j_yangHorto:=$vJ_obj
	$vJ_obj.l_colors:=9  // Yin colors
	$vJ_obj.is_stroke:=True:C214
	$vJ_obj.is_fill:=False:C215
	$vJ_obj.l_stroke:=1
	$vJ_obj.l_opacity:=70
	
	
	$vJ_value.is_bkg:=True:C214
	$vJ_value.is_bkg_ellipse:=False:C215
	$vJ_pattern:=New shared object:C1526()
	$vJ_value.j_bkg:=$vJ_pattern
	$vJ_pattern.l_pattern:=35
	$vJ_pattern.l_colors:=0x331E81EA  // [rale:488] – [rale:490]
	$vJ_pattern.l_rxy:=-1
	$vJ_pattern.l_stroke:=4
	$vJ_pattern.l_opacity:=100
	
End use 

