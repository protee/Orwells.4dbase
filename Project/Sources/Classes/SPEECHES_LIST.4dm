
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_meta:=New object:C1471
	//$is_active:=$c4E_entity.isActive
	//$vL_colors:=woc_sp_colors_from_row($is_active ? k_MDcolorsIdx_lime : k_MDcolorsIdx_grey)
	$vL_colors:=$c4E_entity.colors
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta.stroke:=$vT_color_stroke
	$vJ_meta.fill:=$vT_color_fill
	
	
	//Function lb_active_img($cE_speeches : cs.SPEECHESEntity)->$vO_img : Picture  // Form.fc.lb_active_img(This)
	//$vO_img:=This.get_icon_img($cE_speeches.isActive)
	
	
	//Function lb_colors_img($cE_speeches : cs.SPEECHESEntity)->$vO_img : Picture
	//var $vL_colors; $vL_size; $vL_shape : Integer
	//$vL_colors:=$cE_speeches.colors
	//$vL_shape:=-3
	//$vL_size:=20
	//$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
	