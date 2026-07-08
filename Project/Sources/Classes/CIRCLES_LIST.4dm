
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	var $vT_LB : Text
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")  // To be able being used in preemptive (4DV generation process server)
		This:C1470.lb_meta_info_set()
	End if 
	
	
Function lb_meta_info($cE_YIN_YANG : cs:C1710.YIN_YANGEntity)->$vJ_meta : Object
	//$vJ_meta:=New object
	//var $vL_colors; $vL_color_lines; $vL_color_bkg : Integer
	//var $vJ_fields : Object
	//var $vT_color_stroke; $vT_color_fill : Text
	//$vJ_fields:=$cE_YIN_YANG.fields
	//$vL_color_lines:=$vJ_fields.l_lines
	//$vL_color_bkg:=$vJ_fields.l_bkg
	//$vL_colors:=woc_sp_colors_from_sf($vL_color_lines; $vL_color_bkg)
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	// For cell
	//var $vJ_meta_cell : Object
	//$vJ_meta_cell:=New object
	//$vJ_meta.cell:=$vJ_meta_cell
	
	//var $vJ_meta_cell_values : Object
	//$vJ_meta_cell_values:=New object
	//$vJ_meta_cell.Column13:=$vJ_meta_cell_values // Issue => give the column name that can change
	//$vL_colors:=($c4E_entity.Pseudo#"") ? k_MDcolorsAppSecondary : k_MDcolorsBW
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta_cell_values.stroke:=$vT_color_stroke
	//$vJ_meta_cell_values.fill:=$vT_color_fill
	
	
Function lb_yin_colors_img($cE_YIN_YANG : cs:C1710.YIN_YANGEntity)->$vO_img : Picture
	var $vL_colors; $vL_size : Integer
	$vL_colors:=$cE_YIN_YANG.fields.l_yin
	var $vL_shape : Integer
	$vL_shape:=-3
	$vL_size:=24
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
Function lb_yang_colors_img($cE_YIN_YANG : cs:C1710.YIN_YANGEntity)->$vO_img : Picture
	var $vL_colors; $vL_size : Integer
	$vL_colors:=$cE_YIN_YANG.fields.l_yang
	var $vL_shape : Integer
	$vL_shape:=-3
	$vL_size:=24
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
Function lb_bkg_color_img($cE_YIN_YANG : cs:C1710.YIN_YANGEntity)->$vO_img : Picture
	var $vL_color : Integer
	$vL_color:=$cE_YIN_YANG.fields.l_bkg
	$vO_img:=woc_sp_color_get_icns($vL_color; True:C214)
	
	
Function circles_draw($cE_CIRCLES : cs:C1710.CIRCLESEntity)->$vO_img : Picture
	var $vL_width; $vL_height : Integer
	var $vJ_fields : Object
	$vL_width:=64
	$vL_height:=64
	$vJ_fields:=$cE_CIRCLES.fields
	$vO_img:=orw_circles_svg($vL_width; $vL_height; $vJ_fields)
	
	