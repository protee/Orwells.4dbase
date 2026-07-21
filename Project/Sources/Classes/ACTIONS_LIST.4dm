
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	var $vT_LB : Text
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vT_column : Text
	var $vJ_meta_cell : Object
	$vJ_meta:=New object:C1471
	$vL_colors:=$c4E_entity.colors
	//This.meta_colors($vJ_meta; $vL_colors)
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("label")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_active_img($cE_speeches : cs:C1710.SPEECHESEntity)->$vO_img : Picture  // Form.fc.lb_active_img(This)
	$vO_img:=This:C1470.get_icon_img($cE_speeches.isActive)
	
	
	//Function lb_colors_img($cE_speeches : cs.SPEECHESEntity)->$vO_img : Picture
	//var $vL_colors; $vL_size; $vL_shape : Integer
	//$vL_colors:=$cE_speeches.colors
	//$vL_shape:=-3
	//$vL_size:=20
	//$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
	