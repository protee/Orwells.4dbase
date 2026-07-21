
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	var $vT_LB; $vT_column : Text
	Super:C1706.lb_initialize($vJ_data; $is_local)
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
		
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row min height:K53:73; 20; lk pixels:K53:22)
		LISTBOX SET AUTO ROW HEIGHT:C1501(*; $vT_LB; lk row max height:K53:74; 250; lk pixels:K53:22)
		$vT_column:=This:C1470.get_column("FRAGMENTS_ORWELLS.yinTongue")
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk auto row height:K53:72; lk yes:K53:69)
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk allow wordwrap:K53:39; lk yes:K53:69)
		$vT_column:=This:C1470.get_column("FRAGMENTS_ORWELLS.yangTongue")
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk auto row height:K53:72; lk yes:K53:69)
		LISTBOX SET PROPERTY:C1440(*; $vT_column; lk allow wordwrap:K53:39; lk yes:K53:69)
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vT_column : Text
	var $vJ_meta_cell : Object
	$vJ_meta:=New object:C1471
	//$is_active:=$c4E_entity.isActive
	//$vL_colors:=woc_sp_colors_from_row($is_active ? k_MDcolorsIdx_lime : k_MDcolorsIdx_grey)
	$vL_colors:=$c4E_entity.colors
	If ($vL_colors=0)
		$vL_colors:=$c4E_entity.FRAGMENTS_ORWELLS.colors
	End if 
	//This.meta_colors($vJ_meta; $vL_colors)
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("FRAGMENTS_ORWELLS.yinTongue")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("FRAGMENTS_ORWELLS.yangTongue")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_colors_img($cE_fragments : cs:C1710.FRAGMENTSEntity)->$vO_img : Picture
	var $vL_colors; $vL_size; $vL_shape : Integer
	$vL_colors:=$cE_fragments.colors
	If ($vL_colors#0)
		$vL_shape:=-3
		$vL_size:=20
		$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	End if 
	