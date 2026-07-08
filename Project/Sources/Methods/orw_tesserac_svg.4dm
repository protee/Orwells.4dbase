//%attributes = {"lang":"en"}

#DECLARE($vL_svg_width : Integer; $vL_svg_height : Integer; $vJ_data : Object)->$vO_pict : Picture
var $vL_scale; $vL_cube_colors; $vL_lines_colors; $vL_stroke_line; $x1; $y1; $x2; $y2 : Integer
var $vL_polygons_stroke; $vL_polygons_opacity; $vL_cube_stroke; $vL_cube_opacity; $vL_lines_stroke; $vL_lines_opacity; $vL_pattern; $vL_colors; $vL_rxy; $vL_stroke_bkg : Integer
var $vL_xp1_last; $vL_yp1_last; $vL_xp2_last; $vL_yp2_last; $vL_xp1; $vL_yp1; $vL_xp2; $vL_yp2 : Integer
var $vL_stroke; $vL_count; $vL_radius_x1; $vL_radius_y1; $vL_radius; $vL_cx1; $vL_cy1 : Integer
var $vL_x1_last; $vL_y1_last; $vL_x2_last; $vL_y2_last : Integer
var $vL_polygons_colors; $vL_angle; $vL_radius_xy; $vL_opacity; $vL_coef : Integer
var $vL_cx; $vL_cy; $vL_radius_x; $vL_radius_y; $vL_radius_x2; $vL_radius_y2; $idx : Integer
var $vR_2PI; $vR_PI2; $vR_PI3; $vR_angle; $vR_angle_offset; $vR_angle1 : Real
var $vR_step; $vR_angle_p; $vR_angle1_last; $vR_angle_c; $vR_stroke_coef; $vR_coef : Real
var $vT_svg_root; $vT_color_bkg; $vT_object; $vT_cube_stroke; $vT_cube_fill : Text
var $vT_lines_stroke; $vT_lines_fill; $vT_polygons_stroke; $vT_polygons_fill; $vT_stroke_color; $vT_fill_color : Text
var $vT_patt_none_name; $vT_stroke_svg; $vT_fill_svg : Text
var $is_lines1; $is_polygons; $is_cube_internal; $is_cube_external; $is_polygons_stroke; $is_polygons_fill : Boolean
var $is_lines2; $is_bkg; $is_bkg_ellipse : Boolean
var $vJ_polygons; $vJ_cube; $vJ_lines; $vJ_bkg : Object


$vL_scale:=app__storage_prefs.l_scale
$vL_svg_width*=$vL_scale
$vL_svg_height*=$vL_scale
$vR_stroke_coef:=$vL_scale*$vL_svg_width/2000

$vL_coef:=$vJ_data.l_coef
$vL_angle:=$vJ_data.l_angle
//$vL_stroke:=$vJ_data.l_stroke*$vL_scale  //*$vL_svg_width/2000
$vL_stroke:=wox_max(1; $vJ_data.l_stroke*$vR_stroke_coef)

$vJ_polygons:=$vJ_data.j_polygons
$vL_polygons_colors:=$vJ_polygons.l_colors
$is_polygons_stroke:=$vJ_polygons.is_stroke
$is_polygons_fill:=$vJ_polygons.is_fill
$vL_polygons_stroke:=$vJ_polygons.l_stroke
$vL_polygons_opacity:=$vJ_polygons.l_opacity
$vL_polygons_stroke:=wox_max(1; $vL_polygons_stroke*$vR_stroke_coef)

$vJ_cube:=$vJ_data.j_cube
$vL_cube_colors:=$vJ_cube.l_colors
$is_cube_internal:=$vJ_cube.is_internal
$is_cube_external:=$vJ_cube.is_external
$vL_cube_stroke:=$vJ_cube.l_stroke
$vL_cube_opacity:=$vJ_cube.l_opacity
$vL_cube_stroke:=wox_max(1; $vL_cube_stroke*$vR_stroke_coef)

$vJ_lines:=$vJ_data.j_lines
$vL_lines_colors:=$vJ_lines.l_colors
$is_lines1:=$vJ_lines.is_lines1
$is_lines2:=$vJ_lines.is_lines2
$vL_lines_stroke:=$vJ_lines.l_stroke
$vL_lines_opacity:=$vJ_lines.l_opacity
$vL_lines_stroke:=wox_max(1; $vL_lines_stroke*$vR_stroke_coef)

$is_bkg:=$vJ_data.is_bkg
$is_bkg_ellipse:=$vJ_data.is_bkg_ellipse
$vJ_bkg:=$vJ_data.j_bkg

//$vL_angle:=30
//$vL_count:=$vJ_prefs.l_count
$vL_count:=6


SVG_SET_OPTIONS(SVG_Get_options ?+ 5)  // pour produire un code svg lisible

$vT_svg_root:=SVG_New($vL_svg_width; $vL_svg_height; "Tesserac"; "Creator Gnana Olee"; True:C214; Truncated non centered:K6:4)
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")
//SVG_SET_VIEWBOX ($svg;paletteViewX;paletteViewY;paletteViewLargeur;paletteViewHauteur;"xMinYMin")  // NOTE : meet et slice non acceptés !

SVG_Define_shadow($vT_svg_root; "ombreDefaut"; 0; 0; 0)
SVG_Define_shadow($vT_svg_root; "ombreSelection")  //;0;0;0)  // aucune ombre par exemple ici pour un élément sélectionné

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

woc_sp_colors_to_svg($vL_polygons_colors; ->$vT_polygons_stroke; ->$vT_polygons_fill)
woc_sp_colors_to_svg($vL_cube_colors; ->$vT_cube_stroke; ->$vT_cube_fill)
woc_sp_colors_to_svg($vL_lines_colors; ->$vT_lines_stroke; ->$vT_lines_fill)

// DRAW


$vL_radius_xy:=wox_min($vL_cx; $vL_cy)*0.9
//$vL_stroke_line:=$vL_radius_xy*$vL_stroke/100

$vL_radius_x:=$vL_cx*$vR_coef
$vL_radius_y:=$vL_cy*$vR_coef
$vL_radius_x1:=$vL_radius_x*0.5+($vL_lines_stroke*1.5)
$vL_radius_y1:=$vL_radius_y*0.5+($vL_lines_stroke*1.5)
$vL_radius_x2:=$vL_radius_x*0.5
$vL_radius_y2:=$vL_radius_y*0.5


//$vT_object:=SVG_New_circle($vT_svg_root; $vL_cx; $vL_cy; $vL_radius_x2; $vT_stroke_dots; "none"; $vL_stroke_line)
//$vT_object:=SVG_New_circle($vT_svg_root; $vL_cx; $vL_cy; $vL_radius_x1; $vT_stroke_dots; "none"; $vL_stroke_line)

$vR_2PI:=2*Pi:K30:1
$vR_PI2:=Pi:K30:1/2
$vR_PI3:=Pi:K30:1/3

$vR_angle_offset:=$vL_angle*Degree:K30:2

$vR_step:=$vR_2PI/$vL_count
$vR_angle_p:=$vR_step*0.035

$idx:=0
$vR_angle:=0
$vR_angle1_last:=$vR_angle_offset
$vL_x1_last:=$vL_radius_x2*Cos:C18($vR_angle1_last)+$vL_cx
$vL_y1_last:=$vL_radius_y2*Sin:C17($vR_angle1_last)+$vL_cy
$vL_x2_last:=$vL_radius_x*Cos:C18($vR_angle1_last)+$vL_cx
$vL_y2_last:=$vL_radius_y*Sin:C17($vR_angle1_last)+$vL_cy

$is_polygons:=$is_polygons_stroke || $is_polygons_fill

For ($vR_angle; $vR_step; $vR_2PI; $vR_step)
	$vR_angle1:=$vR_angle+$vR_angle_offset
	$x1:=$vL_radius_x2*Cos:C18($vR_angle1)+$vL_cx
	$y1:=$vL_radius_y2*Sin:C17($vR_angle1)+$vL_cy
	$x2:=$vL_radius_x*Cos:C18($vR_angle1)+$vL_cx
	$y2:=$vL_radius_y*Sin:C17($vR_angle1)+$vL_cy
	
	If ($is_cube_internal)
		If (Not:C34($idx ?? 0))
			//$vT_object:=SVG_New_line($vT_svg_root; $x1; $y1; $x2; $y2; $vT_stroke_lines; $vL_stroke_line)
			$vT_object:=SVG_New_line($vT_svg_root; $vL_cx; $vL_cy; $x1; $y1; $vT_cube_fill; $vL_cube_stroke)
			SVG_SET_STROKE_LINECAP($vT_object; "round")
			SVG_SET_OPACITY($vT_object; $vL_cube_opacity; $vL_cube_opacity)
		End if 
	End if 
	If ($is_cube_external)
		$vT_object:=SVG_New_line($vT_svg_root; $vL_x1_last; $vL_y1_last; $x1; $y1; $vT_cube_stroke; $vL_cube_stroke)
		SVG_SET_STROKE_LINECAP($vT_object; "round")
		SVG_SET_OPACITY($vT_object; $vL_cube_opacity; $vL_cube_opacity)
	End if 
	
	If ($is_polygons)
		$vL_radius:=$vL_lines_stroke/2
		
		$vR_angle_c:=$vR_angle1_last+(Pi:K30:1/2)
		$vL_cx1:=$vL_radius*Cos:C18($vR_angle_c)+$vL_cx
		$vL_cy1:=$vL_radius*Sin:C17($vR_angle_c)+$vL_cy
		$vL_xp1_last:=$vL_radius_x1*Cos:C18($vR_angle1_last)+$vL_cx1
		$vL_yp1_last:=$vL_radius_y1*Sin:C17($vR_angle1_last)+$vL_cy1
		$vL_xp2_last:=$vL_radius_x*Cos:C18($vR_angle1_last)+$vL_cx1
		$vL_yp2_last:=$vL_radius_y*Sin:C17($vR_angle1_last)+$vL_cy1
		
		$vR_angle_c:=$vR_angle1-(Pi:K30:1/2)
		$vL_cx1:=$vL_radius*Cos:C18($vR_angle_c)+$vL_cx
		$vL_cy1:=$vL_radius*Sin:C17($vR_angle_c)+$vL_cy
		$vL_xp1:=$vL_radius_x1*Cos:C18($vR_angle1)+$vL_cx1
		$vL_yp1:=$vL_radius_y1*Sin:C17($vR_angle1)+$vL_cy1
		$vL_xp2:=$vL_radius_x*Cos:C18($vR_angle1)+$vL_cx1
		$vL_yp2:=$vL_radius_y*Sin:C17($vR_angle1)+$vL_cy1
		
		$vT_stroke_color:=$is_polygons_stroke ? $vT_polygons_stroke : "none"
		$vT_fill_color:=$is_polygons_fill ? $vT_polygons_fill : "none"
		
		$vT_object:=SVG_New_path($vT_svg_root; $vL_xp1_last; $vL_yp1_last; $vT_stroke_color; $vT_fill_color; $vL_polygons_stroke)
		SVG_PATH_LINE_TO($vT_object; $vL_xp1; $vL_yp1; $vL_xp2; $vL_yp2; $vL_xp2_last; $vL_yp2_last)
		SVG_PATH_CLOSE($vT_object)
		SVG_SET_STROKE_LINECAP($vT_object; "round")
		SVG_SET_OPACITY($vT_object; $vL_polygons_opacity; $vL_polygons_opacity)
	End if 
	
	
	If ($is_lines2)
		$vT_object:=SVG_New_line($vT_svg_root; $vL_x2_last; $vL_y2_last; $x2; $y2; $vT_lines_fill; $vL_lines_stroke)
		SVG_SET_STROKE_LINECAP($vT_object; "round")
		SVG_SET_OPACITY($vT_object; $vL_lines_opacity; $vL_lines_opacity)
	End if 
	
	
	$vL_x1_last:=$x1
	$vL_y1_last:=$y1
	$vL_x2_last:=$x2
	$vL_y2_last:=$y2
	
	$vR_angle1_last:=$vR_angle1
	$idx+=1
End for 

If ($is_lines1)
	For ($vR_angle; $vR_step; $vR_2PI; $vR_step)
		$vR_angle1:=$vR_angle+$vR_angle_offset
		$x1:=$vL_radius_x2*Cos:C18($vR_angle1)+$vL_cx
		$y1:=$vL_radius_y2*Sin:C17($vR_angle1)+$vL_cy
		$x2:=$vL_radius_x*Cos:C18($vR_angle1)+$vL_cx
		$y2:=$vL_radius_y*Sin:C17($vR_angle1)+$vL_cy
		
		$vT_object:=SVG_New_line($vT_svg_root; $x1; $y1; $x2; $y2; $vT_lines_stroke; $vL_lines_stroke)
		SVG_SET_STROKE_LINECAP($vT_object; "round")
		SVG_SET_OPACITY($vT_object; $vL_lines_opacity; $vL_lines_opacity)
		$idx+=1
	End for 
End if 


$vO_pict:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

