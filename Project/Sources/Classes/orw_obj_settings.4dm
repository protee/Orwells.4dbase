
property is_touched : Boolean
property l_value : Integer
property _at_waz_l; _at_woc_l; _at_waz_is : Collection


Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_obj_settings")
	This:C1470.l_value:=0
	This:C1470.is_touched:=False:C215  // Indication touched
	
	This:C1470._init()
	// *
	// *****
	
	
	// ***** USER
	// *
	// *
	// *****
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
		: ($vL_event_code=On Clicked:K2:4)
			//Case of 
			//: ($vT_objectName="bt_palette")
			//This.bt_palette()
			
			//: ($vT_objectName="bt_more")
			//This.bt_more()
			
			//End case 
			
	End case 
	// *
	// *****
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
Function _init()
	var $vC_at_tags : Collection
	$vC_at_tags:=New collection:C1472()  // waz l_
	$vC_at_tags.push("stroke"; "opacity")
	This:C1470._at_waz_l:=$vC_at_tags
	
	$vC_at_tags:=New collection:C1472()  // woc
	$vC_at_tags.push("colors")
	This:C1470._at_woc_l:=$vC_at_tags
	
	$vC_at_tags:=New collection:C1472()  // waz is_
	//$vC_at_widget.push("border")
	$vC_at_tags.push("stroke"; "fill")
	This:C1470._at_waz_is:=$vC_at_tags
	
	
Function _get_at_is()->$vC_at_is : Collection
	var $vL_mode : Integer
	$vC_at_is:=New collection:C1472()
	$vL_mode:=This:C1470.l_mode
	Case of 
		: $vL_mode=1
			$vC_at_is.push("internal"; "external")
		: $vL_mode=2
			$vC_at_is.push("lines1"; "lines2")
		Else 
			$vC_at_is.push("stroke"; "fill")
	End case 
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height; $idx : Integer
	var $vC_at_tags; $vC_at_is : Collection
	var $vJ_value; $vJ_widget : Object
	var $vT_tag; $vT_widget; $vT_is : Text
	var $is_border : Boolean
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	//$vP_canvas:=OBJECT Get pointer(Object named; "canvas")
	//OBJECT SET COORDINATES($vP_canvas->; 0; 0; $vL_width; $vL_height)
	
	OBJECT SET TITLE:C194(*; "ot_group"; This:C1470.t_tip)
	$vJ_value:=This:C1470.j_value
	$vC_at_tags:=This:C1470._at_waz_l
	For each ($vT_tag; $vC_at_tags)
		$vT_widget:="waz_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.bind_to("l_"+$vT_tag; $vJ_value)
		$vJ_widget.t_tip:=$vT_tag
		$vJ_widget.resize($vT_widget)
	End for each 
	
	$vC_at_tags:=This:C1470._at_woc_l
	For each ($vT_tag; $vC_at_tags)
		$vT_widget:="woc_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_sf:=True:C214
		//$vJ_widget.l_shape:=-1  // Text
		$vJ_widget.bind_to("l_"+$vT_tag; $vJ_value)
		$vJ_widget.t_tip:=$vT_tag
		$vJ_widget.resize($vT_widget)
	End for each 
	
	$vC_at_is:=This:C1470._get_at_is()
	$vC_at_tags:=This:C1470._at_waz_is
	$is_border:=This:C1470.is_border
	OBJECT SET VISIBLE:C603(*; "@_is_border"; $is_border)
	If ($is_border)
		$vC_at_is.push("border")
		$vC_at_tags.push("border")
	End if 
	$idx:=0
	For each ($vT_tag; $vC_at_tags)
		If ($idx<=1)
			$vT_is:=$vC_at_is[$idx]
			OBJECT SET TITLE:C194(*; "ot_is_"+$vT_tag; $vT_is)
		Else 
			$vT_is:=$vT_tag
		End if 
		$vT_widget:="waz_is_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.bind_to("is_"+$vT_is; $vJ_value)
		$vJ_widget.t_tip:=$vT_tag
		$vJ_widget.resize($vT_widget)
		$idx+=1
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $vJ_widget : Object
	var $is_editing : Boolean
	var $vC_at_tags : Collection
	var $vT_tag; $vT_widget : Text
	
	$is_editing:=This:C1470.is_editing
	$vC_at_tags:=This:C1470._at_waz_l
	For each ($vT_tag; $vC_at_tags)
		$vT_widget:="waz_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	
	$vC_at_tags:=This:C1470._at_woc_l
	For each ($vT_tag; $vC_at_tags)
		$vT_widget:="woc_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	
	$vC_at_tags:=This:C1470._at_waz_is
	For each ($vT_tag; $vC_at_tags)
		$vT_widget:="waz_is_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _chge($vJ_widget : Object)
	This:C1470._call_subform()
	
Function _call_subform()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	This:C1470.is_touched:=True:C214
	
	