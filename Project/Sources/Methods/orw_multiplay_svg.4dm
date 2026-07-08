//%attributes = {"lang":"en"}

#DECLARE($vL_svg_width : Integer; $vL_svg_height : Integer; $vJ_data : Object)->$vO_pict : Picture
var $is_lines_bkg : Boolean
var $vL_scale; $vL_count; $vL_colors_dots; $vL_color_line; $vL_color_bkg; $vL_type_line; $vL_stroke; $vL_dash; $vL_x_center; $vL_y_center; $vL_min_radius; $vL_x_radius; $vL_y_radius; $vL_itemRadius; $vL_txt_size; $i; $x1; $y1; $x2; $y2; $vL_color; $vL_x; $vL_y : Integer
var $vR_factor; $vR_2PI; $vR_PI2; $vR_a; $vR_a_start; $vR_multiply; $vR_a_end : Real
var $vR_stroke_scaled; $vR_stroke_circle; $vR_stroke_line : Real
var $vT_svg_root; $vT_color_bkg; $vT_object; $vT_stroke_dots; $vT_fill_dots; $vT_color_line; $vT_text : Text


$vL_scale:=app__storage_prefs.l_scale
$vL_svg_width:=$vL_svg_width*$vL_scale
$vL_svg_height:=$vL_svg_height*$vL_scale

$vL_count:=$vJ_data.l_count
$vR_factor:=$vJ_data.r_factor
$vL_colors_dots:=$vJ_data.l_dots
$vL_color_line:=$vJ_data.l_lines
$vL_color_bkg:=$vJ_data.l_bkg
$vL_type_line:=$vJ_data.l_type
$vL_stroke:=wox_max(1; $vJ_data.l_stroke*$vL_scale*$vL_svg_width/2000)
$vL_dash:=$vJ_data.l_dash  //3*$vL_scale


SVG_SET_OPTIONS(SVG_Get_options ?+ 5)  // pour produire un code svg lisible
$vT_svg_root:=SVG_New($vL_svg_width; $vL_svg_height; "Multiplay"; "Creator Gnana Olee"; True:C214; Truncated non centered:K6:4)
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")  // afin d'avoir accès à la viewBox pour la modifier plus tard

//SVG_SET_VIEWBOX ($svg;paletteViewX;paletteViewY;paletteViewLargeur;paletteViewHauteur;"xMinYMin")  // NOTE : meet et slice non acceptés !

SVG_Define_shadow($vT_svg_root; "ombreDefaut"; 0; 0; 0)
SVG_Define_shadow($vT_svg_root; "ombreSelection")  //;0;0;0)  // aucune ombre par exemple ici pour un élément sélectionné

$vT_color_bkg:=woc_sp_color_to_svg($vL_color_bkg)
$vT_object:=SVG_New_rect($vT_svg_root; 0; 0; $vL_svg_width; $vL_svg_height; 0; 0; "none"; $vT_color_bkg; 0)


// DRAW

$is_lines_bkg:=True:C214

$vL_x_center:=$vL_svg_width/2
$vL_y_center:=$vL_svg_height/2
$vL_min_radius:=wox_min($vL_x_center; $vL_y_center)*0.9
$vL_x_radius:=$vL_min_radius
$vL_y_radius:=$vL_x_radius

$vL_itemRadius:=$vL_min_radius*0.01
$vL_itemRadius:=$vL_min_radius/$vL_count*0.5+1  // *0.015


woc_sp_colors_to_svg($vL_colors_dots; ->$vT_stroke_dots; ->$vT_fill_dots)
$vT_color_line:=woc_sp_color_to_svg($vL_color_line)

//$vR_stroke_scaled:=$vL_min_radius*$vL_stroke/100
$vR_stroke_scaled:=$vL_stroke
$vR_stroke_circle:=$vR_stroke_scaled
$vR_stroke_line:=$vR_stroke_scaled
$vL_txt_size:=16*$vL_scale

If ($vL_count=0)
	$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center; $vL_y_center; $vL_min_radius; $vT_stroke_dots; $vT_fill_dots; $vR_stroke_circle)
Else 
	
	$vR_2PI:=2*Pi:K30:1
	$vR_PI2:=Pi:K30:1/2
	
	//$vT_object:=SVG_New_circle($vT_svgRoot; $vL_x_center+$x1; $vL_y_center+$y1; $vL_itemRadius; $vT_stroke_dots; $vT_stroke_dots; $vL_stroke_circle)
	//$vT_object:=SVG_New_circle($vT_svgRoot; $vL_x_center; $vL_y_center; $vL_min_radius; $vT_stroke_dots; "none"; $vL_stroke_circle*2)
	
	If (Not:C34($is_lines_bkg))
		For ($i; 0; $vL_count)
			$vR_a:=$i*$vR_2PI/$vL_count
			$x1:=$vL_x_radius*Cos:C18($vR_a)
			$y1:=$vL_y_radius*Sin:C17($vR_a)
			//$colorFill_dot:=$i
			//$colors:=wog_colorsMDadd (<>colors_dots;0;$i)
			//$colors_dots:=<>colors_dots
			//woc_colorsMDtoSVG($vL_colors_dots; ->$vT_stroke_dots; ->$vT_fill_dots)
			$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center+$x1; $vL_y_center+$y1; $vL_itemRadius; $vT_stroke_dots; $vT_fill_dots; $vR_stroke_circle)
			$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center+$x1; $vL_y_center+$y1; $vL_itemRadius/8; $vT_stroke_dots; $vT_stroke_dots; $vR_stroke_circle)
		End for 
	End if 
	
	For ($i; 1; $vL_count)
		$vR_a_start:=($i*$vR_2PI/$vL_count)+$vR_PI2
		If ($vR_a_start>$vR_2PI)
			$vR_a_start-=$vR_2PI
		End if 
		$x1:=$vL_x_radius*Cos:C18($vR_a_start)
		$y1:=$vL_y_radius*Sin:C17($vR_a_start)
		$vR_multiply:=$i*$vR_factor
		$vR_a_end:=$vR_multiply*$vR_2PI/$vL_count+$vR_PI2
		While ($vR_a_end>$vR_2PI)
			$vR_a_end-=$vR_2PI
		End while 
		
		If ($vR_a_end<0) || ($vR_a_end>$vR_2PI)
			TRACE:C157
		End if 
		//If ($i=29)
		//TRACE
		//End if
		
		$x2:=$vL_x_radius*Cos:C18($vR_a_end)
		$y2:=$vL_y_radius*Sin:C17($vR_a_end)
		
		
		//$colorFill_line:=wog_colorMDadd (<>color_lines;$multiply%$count)
		//$colorFill_line:=<>color_lines
		$vL_color:=$vL_color_line+($vR_multiply%4)
		//$vL_color:=$vL_color_line-Abs($vR_a_end-$vR_a_start)
		//$vL_color:=$vL_color_line+($i%4)
		$vT_color_line:=woc_sp_color_to_svg($vL_color)
		
		Case of 
			: ($vL_type_line=0)
				$vT_object:=SVG_New_line($vT_svg_root; $vL_x_center+$x1; $vL_y_center+$y1; $vL_x_center+$x2; $vL_y_center+$y2; $vT_color_line; $vR_stroke_line)
				
			: ($vL_type_line=1)
				$vT_object:=woc_svg_circleArcHorto($vT_svg_root; $vL_x_center; $vL_y_center; $vL_x_radius; $vR_a_start; $vR_a_end; $vT_color_line; $vR_stroke_line; $vL_dash)
				
			: ($vL_type_line=2)
				$vT_object:=woc_svg_circleArcCenter($vT_svg_root; $vL_x_center; $vL_y_center; $vL_x_radius; $vR_a_start; $vR_a_end; $vT_color_line; $vR_stroke_line; $vL_dash)
		End case 
		SVG_SET_ID($vT_object; "line_"+String:C10($i))
		
		$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center+$x2; $vL_y_center+$y2; $vL_itemRadius/8; $vT_color_line; $vT_color_line; 0)
		
		If (False:C215)
			$vL_x:=($x1+$x2)/2
			$vL_y:=($y1+$y2)/2
			$vT_text:=String:C10($i)
			//$vT_object:=SVG_New_text($vT_svgRoot; $vT_text; $vL_x; $vL_y; ""; $vL_txt_size; 0; 3; $vT_color_line)
			//$vT_object:=SVG_New_text($vT_svgRoot; $vT_text; $vL_x_center; $vL_y_center; ""; $vL_txt_size; 0; 3; $vT_color_line)
			$vT_object:=SVG_New_text($vT_svg_root; $vT_text; $vL_x_center+$vL_x; $vL_y_center+$vL_y; ""; $vL_txt_size; 0; 3; $vT_stroke_dots)
		End if 
	End for 
	$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center; $vL_y_center; $vL_min_radius; $vT_stroke_dots; "none"; $vR_stroke_circle)
	
	If ($is_lines_bkg)
		For ($i; 0; $vL_count)
			$vR_a:=$i*$vR_2PI/$vL_count+$vR_PI2
			$x1:=$vL_x_radius*Cos:C18($vR_a)
			$y1:=$vL_y_radius*Sin:C17($vR_a)
			//$colorFill_dot:=$i
			//$colors:=wog_colorsMDadd (<>colors_dots;0;$i)
			//$colors_dots:=<>colors_dots
			//woc_colorsMDtoSVG($vL_colors_dots; ->$vT_stroke_dots; ->$vT_fill_dots)
			$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center+$x1; $vL_y_center+$y1; $vL_itemRadius; $vT_stroke_dots; $vT_fill_dots; $vR_stroke_circle)
			$vT_object:=SVG_New_circle($vT_svg_root; $vL_x_center+$x1; $vL_y_center+$y1; $vL_itemRadius/8; $vT_stroke_dots; $vT_stroke_dots; $vR_stroke_circle)
		End for 
	End if 
	
End if 

$vO_pict:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

