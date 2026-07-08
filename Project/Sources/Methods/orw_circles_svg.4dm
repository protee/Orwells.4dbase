//%attributes = {"lang":"en"}

#DECLARE($vL_svg_width : Integer; $vL_svg_height : Integer; $vJ_data : Object)->$vO_pict : Picture
var $vL_scale; $vL_yin_colors; $vL_yang_colors; $vL_stroke_bkg : Integer
var $vL_coef_dots : Integer
var $vL_stroke_D2; $vL_stroke_line; $vL_diameter; $idx; $vL_x; $vL_y : Integer
var $vL_radius_xy; $vL_diameter_dot; $vL_radius_dot; $vL_diameter_dot2; $vL_diameter_dot4; $vL_diameter_dot8; $vL_x1; $vL_y1 : Integer
var $vL_yinH_colors; $vL_yinH_opacity; $vL_yangH_colors; $vL_yangH_opacity; $vL_yangH_stroke : Integer
var $vL_x4; $vL_y4; $vL_x2; $vL_y2; $vL_horto_count : Integer
var $vL_yin_opacity; $vL_yang_opacity : Integer
var $vL_stroke; $vL_coef; $vL_radius_y : Integer
var $vL_angle; $vL_colors; $vL_pattern; $vL_rxy; $vL_opacity : Integer
var $vL_cx; $vL_cy; $vL_radius_x; $vL_yin_stroke; $vL_yang_stroke; $vL_yinH_stroke : Integer
var $vT_svg_root; $vT_color_bkg; $vT_object; $vT_yin_stroke; $vT_yin_fill; $vT_patt_none_name : Text
var $vT_yinH_stroke; $vT_yinH_fill; $vT_yangH_stroke; $vT_yangH_fill : Text
var $vT_yang_stroke; $vT_yang_fill : Text
var $vT_svg_yin; $vT_stroke_svg; $vT_fill_svg : Text
var $is_yang_stroke; $is_yin_stroke; $is_yin_fill; $is_bkg; $is_multiple_horto : Boolean
var $is_yinH_stroke; $is_yinH_fill; $is_yinH_border; $is_yangH_stroke; $is_yangH_fill; $is_yangH_border : Boolean
var $is_yang_fill; $is_bkg_ellipse : Boolean
var $vJ_bkg; $vJ_yin; $vJ_yang; $vJ_yinH; $vJ_yangH : Object
var $vR_coef; $vR_coef_dot; $vR_angle_step1; $vR_pi_count; $vR_stroke_coef : Real
var $vR_angle; $vR_pi6; $vR_pi3; $vR_angle_step; $vR_angle2; $vR_angle3; $vR_rad : Real
var $vC_al_diameters : Collection


$vL_scale:=app__storage_prefs.l_scale
$vL_svg_width*=$vL_scale
$vL_svg_height*=$vL_scale

$vL_coef:=$vJ_data.l_coef
$vL_coef_dots:=$vJ_data.l_coef_dots
$vL_angle:=$vJ_data.l_angle
$vL_stroke:=$vJ_data.l_stroke*$vL_scale
$vL_horto_count:=$vJ_data.l_hortoCount

//$is_border:=$vJ_data.is_border
$vJ_yin:=$vJ_data.j_yin
$vL_yin_colors:=$vJ_yin.l_colors
$is_yin_stroke:=$vJ_yin.is_stroke
$is_yin_fill:=$vJ_yin.is_fill
$vL_yin_stroke:=$vJ_yin.l_stroke
$vL_yin_opacity:=$vJ_yin.l_opacity

$vJ_yang:=$vJ_data.j_yang
$vL_yang_colors:=$vJ_yang.l_colors
$is_yang_stroke:=$vJ_yang.is_stroke
$is_yang_fill:=$vJ_yang.is_fill
$vL_yang_stroke:=$vJ_yang.l_stroke
$vL_yang_opacity:=$vJ_yang.l_opacity

$vJ_yinH:=$vJ_data.j_yinHorto
$vL_yinH_colors:=$vJ_yinH.l_colors
$is_yinH_stroke:=$vJ_yinH.is_stroke
$is_yinH_fill:=$vJ_yinH.is_fill
$vL_yinH_stroke:=$vJ_yinH.l_stroke
$vL_yinH_opacity:=$vJ_yinH.l_opacity
$is_yinH_border:=$vJ_yinH.is_border

$vJ_yangH:=$vJ_data.j_yangHorto
$vL_yangH_colors:=$vJ_yangH.l_colors
$is_yangH_stroke:=$vJ_yangH.is_stroke
$is_yangH_fill:=$vJ_yangH.is_fill
$vL_yangH_stroke:=$vJ_yangH.l_stroke
$vL_yangH_opacity:=$vJ_yangH.l_opacity
$is_yangH_border:=$vJ_yangH.is_border

$is_bkg:=$vJ_data.is_bkg
$is_bkg_ellipse:=$vJ_data.is_bkg_ellipse
$vJ_bkg:=$vJ_data.j_bkg


SVG_SET_OPTIONS(SVG_Get_options ?+ 5)  // pour produire un code svg lisible

$vT_svg_root:=SVG_New($vL_svg_width; $vL_svg_height; "Circles"; "Creator Gnana Olee"; True:C214; Truncated non centered:K6:4)
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")
//SVG_SET_VIEWBOX ($svg;paletteViewX;paletteViewY;paletteViewLargeur;paletteViewHauteur;"xMinYMin")  // NOTE : meet et slice non acceptés !

$vR_coef:=$vL_coef/100
$vL_cx:=$vL_svg_width/2
$vL_cy:=$vL_svg_height/2

If ($is_bkg)
	$vL_pattern:=$vJ_bkg.l_pattern
	$vL_colors:=$vJ_bkg.l_colors
	$vT_patt_none_name:="nonePattern"
	woc_sp_colors_to_svg($vL_colors; ->$vT_stroke_svg; ->$vT_fill_svg)
	woc_svg_pattern_empty($vT_svg_root; $vT_patt_none_name; $vL_pattern; $vT_stroke_svg; $vT_fill_svg)
	
	$vT_color_bkg:="url(#"+$vT_patt_none_name+")"
	$vL_rxy:=$vJ_bkg.l_rxy
	$vL_rxy:=($vL_rxy=-1) ? wox_min($vL_svg_width/10; $vL_svg_height/10) : $vL_rxy
	$vL_stroke_bkg:=$vJ_bkg.l_stroke
	$vL_opacity:=$vJ_bkg.l_opacity
	$vL_radius_x:=$vL_cx
	$vL_radius_y:=$vL_cy
	If ($is_bkg_ellipse)
		$vT_object:=SVG_New_ellipse($vT_svg_root; $vL_cx; $vL_cy; $vL_radius_x; $vL_radius_y; $vT_stroke_svg; $vT_color_bkg; $vL_stroke_bkg)
	Else 
		$vT_object:=SVG_New_rect($vT_svg_root; $vL_cx-$vL_radius_x; $vL_cy-$vL_radius_y; $vL_radius_x*2; $vL_radius_y*2; $vL_rxy; $vL_rxy; $vT_stroke_svg; $vT_color_bkg; $vL_stroke_bkg)
	End if 
	SVG_SET_OPACITY($vT_object; $vL_opacity; $vL_opacity)
End if 


woc_sp_colors_to_svg($vL_yin_colors; ->$vT_yin_stroke; ->$vT_yin_fill)
woc_sp_colors_to_svg($vL_yang_colors; ->$vT_yang_stroke; ->$vT_yang_fill)
woc_sp_colors_to_svg($vL_yinH_colors; ->$vT_yinH_stroke; ->$vT_yinH_fill)
woc_sp_colors_to_svg($vL_yangH_colors; ->$vT_yangH_stroke; ->$vT_yangH_fill)
$vT_yin_stroke:=$is_yin_stroke ? $vT_yin_stroke : "none"
$vT_yin_fill:=$is_yin_fill ? $vT_yin_fill : "none"
$vT_yang_stroke:=$is_yang_stroke ? $vT_yang_stroke : "none"
$vT_yang_fill:=$is_yang_fill ? $vT_yang_fill : "none"
$vT_yinH_stroke:=$is_yinH_stroke ? $vT_yinH_stroke : "none"
$vT_yinH_fill:=$is_yinH_fill ? $vT_yinH_fill : "none"
$vT_yangH_stroke:=$is_yangH_stroke ? $vT_yangH_stroke : "none"
$vT_yangH_fill:=$is_yangH_fill ? $vT_yangH_fill : "none"

// DRAW

$vR_coef_dot:=$vL_coef_dots/100
$vL_radius_x:=$vL_cx*$vR_coef
$vL_radius_y:=$vL_cy*$vR_coef
$vL_radius_xy:=wox_min($vL_radius_x; $vL_radius_y)

$vR_stroke_coef:=$vL_radius_xy/500
$vL_stroke:=$vL_stroke*$vR_stroke_coef
$vL_yin_stroke:=$vL_yin_stroke*$vR_stroke_coef
$vL_yang_stroke:=$vL_yang_stroke*$vR_stroke_coef
$vL_yinH_stroke:=$vL_yinH_stroke*$vR_stroke_coef
$vL_yangH_stroke:=$vL_yangH_stroke*$vR_stroke_coef

$vL_stroke_D2:=($vL_stroke/2)
$vL_stroke_line:=$vL_stroke

$vL_diameter_dot:=$vL_radius_xy*$vR_coef_dot
$vL_radius_dot:=$vL_diameter_dot/2
$vL_diameter_dot2:=$vL_diameter_dot*2
//$vL_diameter_dot3:=$vL_diameter_dot*3
$vL_diameter_dot4:=$vL_diameter_dot2*2
$vL_diameter_dot8:=$vL_diameter_dot4*2


//$vL_reverse:=Num($is_reverse)
//$vL_reverse1:=Num(Not($is_reverse))
//If ($is_reverse)
//$vL_radius_x:=-$vL_radius_x
//End if 
//$vL_radius_x_D2:=$vL_radius_x/2

$vR_angle:=$vL_angle*Degree:K30:2
$vT_svg_yin:=SVG_New_group($vT_svg_root; "yin")
$vR_pi6:=Pi:K30:1/6
$vR_pi3:=Pi:K30:1/3


// ***** Basic Circles
// *
$vT_object:=SVG_New_circle($vT_svg_yin; $vL_cx; $vL_cy; $vL_radius_dot; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
SVG_SET_OPACITY($vT_object; $vL_yin_opacity; $vL_yin_opacity)
For ($vR_angle_step; 0; k_two_pi-0.1; $vR_pi3)
	$vL_x:=$vL_diameter_dot*Cos:C18($vR_angle_step)+$vL_cx
	$vL_y:=$vL_diameter_dot*Sin:C17($vR_angle_step)+$vL_cy
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x; $vL_y; $vL_radius_dot; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yin_opacity; $vL_yin_opacity)
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x; $vL_y; $vL_diameter_dot; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yang_opacity; $vL_yang_opacity)
	
	$vL_x2:=$vL_diameter_dot2*Cos:C18($vR_angle_step)+$vL_cx
	$vL_y2:=$vL_diameter_dot2*Sin:C17($vR_angle_step)+$vL_cy
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x2; $vL_y2; $vL_radius_dot; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yin_opacity; $vL_yin_opacity)
	// Double radius
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x; $vL_y; $vL_diameter_dot; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yang_opacity; $vL_yang_opacity)
	
	//$vL_x3:=$vL_diameter_dot3*Cos($vR_angle_step)+$vL_cx
	//$vL_y3:=$vL_diameter_dot3*Sin($vR_angle_step)+$vL_cy
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x2; $vL_y2; $vL_diameter_dot; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yang_opacity; $vL_yang_opacity)
	
	$vL_x4:=$vL_diameter_dot4*Cos:C18($vR_angle_step)+$vL_cx
	$vL_y4:=$vL_diameter_dot4*Sin:C17($vR_angle_step)+$vL_cy
	$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x4; $vL_y4; $vL_diameter_dot; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_SET_OPACITY($vT_object; $vL_yang_opacity; $vL_yang_opacity)
End for 

// ***** Multiple cicrcles
// *
$vL_horto_count*=6
$vR_pi_count:=k_two_pi/$vL_horto_count
$is_multiple_horto:=True:C214
For ($vR_angle_step; 0; k_two_pi-$vR_pi_count; $vR_pi_count)
	If ($is_multiple_horto)
		$vR_angle2:=$vR_angle_step-$vR_pi_count
		$vR_angle3:=$vR_angle_step+$vR_pi_count
		$vR_rad:=$vL_diameter_dot2+$vL_diameter_dot
		$vT_object:=woc_svg_circleFillHorto($vT_svg_yin; $vL_cx; $vL_cy; $vR_rad; $vR_angle2; $vR_angle3; $vT_yinH_stroke; $vT_yinH_fill; $vL_yinH_stroke; $is_yinH_border)
		SVG_SET_OPACITY($vT_object; $vL_yinH_opacity; $vL_yinH_opacity)
	Else 
		$vL_x2:=$vL_diameter_dot2*Cos:C18($vR_angle_step)+$vL_cx
		$vL_y2:=$vL_diameter_dot2*Sin:C17($vR_angle_step)+$vL_cy
		$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x2; $vL_y2; $vL_diameter_dot; $vT_yinH_stroke; $vT_yinH_fill; $vL_yinH_stroke)
		SVG_SET_OPACITY($vT_object; $vL_yinH_opacity; $vL_yinH_opacity)
	End if 
	
	If ($is_multiple_horto)
		$vR_angle2:=$vR_angle_step-$vR_pi_count
		$vR_angle3:=$vR_angle_step+$vR_pi_count
		$vR_rad:=$vL_diameter_dot4+$vL_diameter_dot
		$vT_object:=woc_svg_circleFillHorto($vT_svg_yin; $vL_cx; $vL_cy; $vR_rad; $vR_angle2; $vR_angle3; $vT_yangH_stroke; $vT_yangH_fill; $vL_yangH_stroke; $is_yangH_border)
		SVG_SET_OPACITY($vT_object; $vL_yangH_opacity; $vL_yangH_opacity)
	Else 
		$vL_x2:=$vL_diameter_dot4*Cos:C18($vR_angle_step)+$vL_cx
		$vL_y2:=$vL_diameter_dot4*Sin:C17($vR_angle_step)+$vL_cy
		$vT_object:=SVG_New_circle($vT_svg_yin; $vL_x2; $vL_y2; $vL_diameter_dot; $vT_yangH_stroke; $vT_yangH_fill; $vL_yangH_stroke)
		SVG_SET_OPACITY($vT_object; $vL_yangH_opacity; $vL_yangH_opacity)
	End if 
End for 

// ***** Multiple Lines
// *
$vC_al_diameters:=New collection:C1472($vL_diameter_dot; $vL_diameter_dot2; $vL_diameter_dot4)
For ($vR_angle_step; 0; k_two_pi-0.1; $vR_pi3)
	//$vR_angle1:=$vR_angle_step+$vR_angle
	For each ($vL_diameter; $vC_al_diameters)
		$idx:=0
		For ($vR_angle_step1; $vR_angle_step; k_two_pi-0.1; $vR_pi3)
			If ($idx=0)
				$vL_x:=$vL_diameter*Cos:C18($vR_angle_step1)+$vL_cx
				$vL_y:=$vL_diameter*Sin:C17($vR_angle_step1)+$vL_cy
			Else 
				$vL_x1:=$vL_diameter*Cos:C18($vR_angle_step1)+$vL_cx
				$vL_y1:=$vL_diameter*Sin:C17($vR_angle_step1)+$vL_cy
				$vT_object:=SVG_New_line($vT_svg_yin; $vL_x; $vL_y; $vL_x1; $vL_y1; $vT_yin_stroke; $vL_stroke_line)
				SVG_SET_OPACITY($vT_object; $vL_yin_opacity; $vL_yin_opacity)
			End if 
			$idx+=1
		End for 
	End for each 
End for 

//SVG_SET_OPACITY($vT_svg_yin; $vL_yin_opacity; $vL_yin_opacity)
//SVG_SET_OPACITY($vT_svg_yang; $vL_yang_opacity; $vL_yang_opacity)

//SVG_ROTATION_CENTERED($vT_svg_yinYang; $vL_angle)
SVG_SET_TRANSFORM_ROTATE($vT_svg_yin; $vL_angle; $vL_cx; $vL_cy)

$vO_pict:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

