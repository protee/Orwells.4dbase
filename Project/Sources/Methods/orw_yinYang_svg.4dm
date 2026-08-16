//%attributes = {"lang":"en"}

#DECLARE($vL_svg_width : Integer; $vL_svg_height : Integer; $vJ_data : Object)->$vO_pict : Picture
var $vL_scale; $vL_yin_colors; $vL_yang_colors; $vL_color_bkg; $vL_stroke_bkg : Integer
var $vL_coef_dots; $vL_cx_yin; $vL_cy_yin; $vL_cx_yang; $vL_cy_yang; $vL_gap : Integer
var $vL_stroke_D2; $vL_radius_y_D2; $vL_radius_x_dot; $vL_radius_y_dot; $vL_radius_x1; $vL_radius_y1; $vL_radius_x1_D2; $vL_radius_y1_D2 : Integer
var $vL_yin_opacity; $vL_yang_opacity; $vL_yin_stroke; $vL_yang_stroke; $vL_stroke_coef : Integer
var $vL_stroke; $vL_coef; $vL_radius_y; $vL_radius_x9; $vL_radius_y9 : Integer
var $vL_angle; $vL_min_radius; $vL_colors; $vL_pattern; $vL_rxy; $vL_opacity : Integer
var $vL_cx; $vL_cy; $vL_radius_x; $vL_radius_x_D2; $vL_reverse; $vL_reverse1 : Integer
var $vT_svg_root; $vT_color_bkg; $vT_object; $vT_yin_stroke; $vT_yin_fill; $vT_patt_none_name : Text
var $vT_yang_stroke; $vT_yang_fill; $vT_svg_yin1; $vT_svg_yang1 : Text
var $vT_svg_yin; $vT_svg_yang; $vT_svg_yinYang; $vT_stroke_svg; $vT_fill_svg : Text
var $is_yang_stroke; $is_yin_stroke; $is_yin_fill; $is_bkg; $is_reverse : Boolean
var $is_yang_fill; $is_bkg_ellipse : Boolean
var $vJ_bkg; $vJ_yin; $vJ_yang : Object
var $vR_coef; $vR_coef_dot; $vR_coef_angle : Real


$vL_scale:=orw__storage_prefs.l_scale
$vL_svg_width*=$vL_scale
$vL_svg_height*=$vL_scale

$vL_coef:=$vJ_data.l_coef
$vL_coef_dots:=$vJ_data.l_coef_dots
$vL_angle:=$vJ_data.l_angle
$vL_stroke:=$vJ_data.l_stroke*$vL_scale
$vL_gap:=$vJ_data.l_gap

$is_reverse:=$vJ_data.is_reverse

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

$is_bkg:=$vJ_data.is_bkg
$is_bkg_ellipse:=$vJ_data.is_bkg_ellipse
$vJ_bkg:=$vJ_data.j_bkg
$vL_color_bkg:=$vJ_data.l_bkg


SVG_SET_OPTIONS(SVG_Get_options ?+ 5)  // pour produire un code svg lisible

$vT_svg_root:=SVG_New($vL_svg_width; $vL_svg_height; "Tesserac"; "Creator Gnana Olee"; True:C214; Truncated non centered:K6:4)
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")
//SVG_SET_VIEWBOX ($svg;paletteViewX;paletteViewY;paletteViewLargeur;paletteViewHauteur;"xMinYMin")  // NOTE : meet et slice non acceptés !

//SVG_Define_shadow($vT_svg_root; "ombreDefaut"; 0; 0; 0)
//SVG_Define_shadow($vT_svg_root; "ombreSelection")  //;0;0;0)  // aucune ombre par exemple ici pour un élément sélectionné

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

// DRAW

$vL_radius_x:=$vL_cx*$vR_coef
$vL_radius_y:=$vL_cy*$vR_coef
$vL_min_radius:=wox_min($vL_radius_x; $vL_radius_y)
$vL_stroke_coef:=$vL_min_radius/500
$vL_yin_stroke*=$vL_stroke_coef
$vL_yang_stroke*=$vL_stroke_coef
$vL_stroke*=$vL_stroke_coef
$vL_stroke_D2:=($vL_stroke/2)
$vL_gap*=$vL_stroke_coef
$vR_coef_dot:=$vL_coef_dots/100

$vR_coef_angle:=1-(Abs:C99($vL_angle-90)/90)
$vL_radius_x9:=$vL_radius_x
$vL_radius_y9:=$vL_radius_y
$vL_radius_x:=$vL_radius_x9+(($vL_radius_y9-$vL_radius_x9)*$vR_coef_angle)
$vL_radius_y:=$vL_radius_y9+(($vL_radius_x9-$vL_radius_y9)*$vR_coef_angle)

$vL_radius_x-=$vL_stroke_D2
$vL_radius_x_D2:=$vL_radius_x/2
$vL_radius_y-=$vL_stroke_D2
$vL_radius_y_D2:=$vL_radius_y/2

$vL_radius_x_dot:=$vL_radius_x_D2*$vR_coef_dot
$vL_radius_y_dot:=$vL_radius_y_D2*$vR_coef_dot

$vL_cx_yin:=$vL_cx
$vL_cy_yin:=$vL_cy+$vL_radius_y_D2

$vL_cx_yang:=$vL_cx
$vL_cy_yang:=$vL_cy-$vL_radius_y_D2


$vT_yin_stroke:=$is_yin_stroke ? $vT_yin_stroke : "none"
$vT_yin_fill:=$is_yin_fill ? $vT_yin_fill : "none"
$vT_yang_stroke:=$is_yang_stroke ? $vT_yang_stroke : "none"
$vT_yang_fill:=$is_yang_fill ? $vT_yang_fill : "none"

$vL_reverse:=Num:C11($is_reverse)
$vL_reverse1:=Num:C11(Not:C34($is_reverse))
If ($is_reverse)
	$vL_radius_x:=-$vL_radius_x
End if 
$vL_radius_x_D2:=$vL_radius_x/2


$vT_svg_yinYang:=SVG_New_group($vT_svg_root; "yinYang")

If ($vL_gap=0)
	
	// YIN
	$vT_svg_yin:=SVG_New_path($vT_svg_yinYang; $vL_cx; $vL_cy+$vL_radius_y; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x; $vL_radius_y; $vL_cx; $vL_cy-$vL_radius_y; 0; $vL_reverse)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x_D2; $vL_radius_y_D2; $vL_cx; $vL_cy; 0; $vL_reverse1)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x_D2; $vL_radius_y_D2; $vL_cx; $vL_cy+$vL_radius_y; 0; $vL_reverse)
	
	// YANG
	$vT_svg_yang:=SVG_New_path($vT_svg_yinYang; $vL_cx; $vL_cy-$vL_radius_y; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x; $vL_radius_y; $vL_cx; $vL_cy+$vL_radius_y; 0; $vL_reverse)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x_D2; $vL_radius_y_D2; $vL_cx; $vL_cy; 0; $vL_reverse1)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x_D2; $vL_radius_y_D2; $vL_cx; $vL_cy-$vL_radius_y; 0; $vL_reverse)
	//SVG_PATH_CLOSE($vT_svg_yang)
	
	
Else 
	$vL_radius_x1:=$vL_radius_x-$vL_gap
	$vL_radius_y1:=$vL_radius_y-$vL_gap
	$vL_radius_x1_D2:=$vL_radius_x1/2
	$vL_radius_y1_D2:=$vL_radius_y1/2
	
	// YIN
	$vT_svg_yin:=SVG_New_path($vT_svg_yinYang; $vL_cx; $vL_cy+$vL_radius_y-$vL_gap; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x1; $vL_radius_y1; $vL_cx; $vL_cy-$vL_radius_y; 0; 0)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x1_D2; $vL_radius_y1_D2; $vL_cx; $vL_cy+$vL_gap; 0; 1)
	SVG_PATH_ARC($vT_svg_yin; $vL_radius_x1_D2-$vL_gap; $vL_radius_y1_D2-$vL_gap; $vL_cx; $vL_cy+$vL_radius_y1; 0; 0)
	
	// YANG
	$vT_svg_yang:=SVG_New_path($vT_svg_yinYang; $vL_cx; $vL_cy-$vL_radius_y+$vL_gap; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x1; $vL_radius_y1; $vL_cx; $vL_cy+$vL_radius_y; 0; 0)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x1_D2; $vL_radius_y1_D2; $vL_cx; $vL_cy-$vL_gap; 0; 1)
	SVG_PATH_ARC($vT_svg_yang; $vL_radius_x_D2-$vL_gap; $vL_radius_y_D2-$vL_gap; $vL_cx; $vL_cy-$vL_radius_y1; 0; 0)
	//SVG_PATH_CLOSE($vT_svg_yin)
	
End if 

$vT_svg_yin1:=SVG_New_ellipse($vT_svg_yinYang; $vL_cx_yang; $vL_cy_yang; $vL_radius_x_dot; $vL_radius_y_dot; $vT_yin_stroke; $vT_yin_fill; $vL_yin_stroke)
$vT_svg_yang1:=SVG_New_ellipse($vT_svg_yinYang; $vL_cx_yin; $vL_cy_yin; $vL_radius_x_dot; $vL_radius_y_dot; $vT_yang_stroke; $vT_yang_fill; $vL_yang_stroke)

SVG_SET_OPACITY($vT_svg_yin; $vL_yin_opacity; $vL_yin_opacity)
SVG_SET_OPACITY($vT_svg_yang; $vL_yang_opacity; $vL_yang_opacity)
SVG_SET_OPACITY($vT_svg_yin1; $vL_yin_opacity; $vL_yin_opacity)
SVG_SET_OPACITY($vT_svg_yang1; $vL_yang_opacity; $vL_yang_opacity)

//SVG_ROTATION_CENTERED($vT_svg_yinYang; $vL_angle)
SVG_SET_TRANSFORM_ROTATE($vT_svg_yinYang; $vL_angle; $vL_cx; $vL_cy)

$vO_pict:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

