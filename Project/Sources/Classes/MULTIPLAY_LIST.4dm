
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")  // To be able being used in preemptive (4DV generation process server)
		This:C1470.lb_meta_info_set()
	End if 
	
	
Function lb_meta_info($cE_MULTIPLAY : cs:C1710.MULTIPLAYEntity)->$vJ_meta : Object
	$vJ_meta:=New object:C1471
	var $vL_colors; $vL_color_lines; $vL_color_bkg : Integer
	var $vJ_fields : Object
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_fields:=$cE_MULTIPLAY.fields
	$vL_color_lines:=$vJ_fields.l_lines
	$vL_color_bkg:=$vJ_fields.l_bkg
	$vL_colors:=woc_sp_colors_from_sf($vL_color_lines; $vL_color_bkg)
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta.stroke:=$vT_color_stroke
	$vJ_meta.fill:=$vT_color_fill
	
	// For cells
	//var $vJ_meta_cell : Object
	//$vJ_meta_cell:=New object
	//$vJ_meta.cell:=$vJ_meta_cell
	
	//$vL_colors:=($c4E_entity.Pseudo#"") ? k_MDcolorsAppSecondary : k_MDcolorsBW
	//This.meta_cell_colors($vJ_meta_cell; "Column13"; $vL_colors_assPer)
	
	
	
Function multiplay_draw($cE_MULTIPLAY : cs:C1710.MULTIPLAYEntity)->$vO_img : Picture
	var $vL_width; $vL_height; $vL_scale : Integer
	var $vJ_fields : Object
	$vL_width:=64
	$vL_height:=64
	$vJ_fields:=$cE_MULTIPLAY.fields
	$vO_img:=orw_multiplay_svg($vL_width; $vL_height; $vJ_fields)
	
	