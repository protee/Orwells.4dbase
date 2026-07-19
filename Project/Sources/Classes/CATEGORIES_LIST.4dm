
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
		
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row min height:K53:73; 28; lk pixels:K53:22)
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row max height:K53:74; 150; lk pixels:K53:22)
		//$vT_column:="Column2"
		$vT_column:=This:C1470.get_column("infos")
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk auto row height:K53:72; lk yes:K53:69)
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk allow wordwrap:K53:39; lk yes:K53:69)
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$c4E_entity.colors
	//This.meta_colors($vJ_meta; $vL_colors)
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("label")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_orwells_count($cE_categories : cs:C1710.CATEGORIESEntity)->$vL_count : Integer
	$vL_count:=$cE_categories.CATEGORIES_ORWELLS.length
	
	
Function lb_colors_img($cE_categories : cs:C1710.CATEGORIESEntity)->$vO_img : Picture
	var $vL_colors; $vL_size; $vL_shape : Integer
	$vL_colors:=$cE_categories.colors
	$vL_shape:=-3
	$vL_size:=20
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_active_img($cE_categories : cs:C1710.CATEGORIESEntity)->$vO_img : Picture  // Form.fc.lb_active_img(This)
	$vO_img:=This:C1470.get_icon_img($cE_categories.isActive)
	
	