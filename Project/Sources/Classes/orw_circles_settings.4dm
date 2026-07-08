
property is_touched : Boolean
property l_value : Integer
property _at_waz_l; _at_orw_j; _at_waz_is : Collection


Class extends ZEN__WIDGETS

Class constructor
	Super:C1705("j_circles_settings")
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
	var $vC_at_widget : Collection
	$vC_at_widget:=New collection:C1472()  // waz l_
	$vC_at_widget.push("coef"; "coef_dots"; "angle"; "stroke"; "hortoCount")
	This:C1470._at_waz_l:=$vC_at_widget
	
	$vC_at_widget:=New collection:C1472()  // waz l_
	$vC_at_widget.push("yin"; "yang"; "yinHorto"; "yangHorto")
	This:C1470._at_orw_j:=$vC_at_widget
	
	$vC_at_widget:=New collection:C1472()  // waz is_
	$vC_at_widget.push("bkg_ellipse"; "bkg")
	This:C1470._at_waz_is:=$vC_at_widget
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	var $vC_at_widget : Collection
	var $vJ_value; $vJ_widget : Object
	var $vT_tag; $vT_widget : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	//$vP_canvas:=OBJECT Get pointer(Object named; "canvas")
	//OBJECT SET COORDINATES($vP_canvas->; 0; 0; $vL_width; $vL_height)
	
	//This._set_bkg()
	$vJ_value:=This:C1470.j_value
	$vC_at_widget:=This:C1470._at_waz_l
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="waz_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.bind_to("l_"+$vT_tag; $vJ_value)
		$vJ_widget.t_tip:=$vT_tag
		$vJ_widget.resize($vT_widget)
	End for each 
	
	$vC_at_widget:=This:C1470._at_orw_j
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="orw_obj_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.j_value:=$vJ_value["j_"+$vT_tag]
		$vJ_widget.resize($vT_widget)
	End for each 
	
	$vC_at_widget:=This:C1470._at_waz_is
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="waz_is_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.bind_to("is_"+$vT_tag; $vJ_value)
		$vJ_widget.t_tip:=$vT_tag
		$vJ_widget.resize($vT_widget)
	End for each 
	
	$vT_widget:="woc_pattern"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.j_value:=$vJ_value.j_bkg
	$vJ_widget.resize($vT_widget)
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	var $vJ_widget : Object
	var $is_editing : Boolean
	var $vC_at_widget : Collection
	var $vT_tag; $vT_widget : Text
	
	$is_editing:=This:C1470.is_editing
	$vC_at_widget:=This:C1470._at_waz_l
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="waz_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	
	$vC_at_widget:=This:C1470._at_orw_j
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="orw_obj_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	
	$vC_at_widget:=This:C1470._at_waz_is
	For each ($vT_tag; $vC_at_widget)
		$vT_widget:="waz_is_"+$vT_tag
		$vJ_widget:=OBJECT Get value:C1743($vT_widget)
		$vJ_widget.is_editing:=$is_editing
		$vJ_widget.redraw()
	End for each 
	
	$vT_widget:="woc_pattern"
	$vJ_widget:=OBJECT Get value:C1743($vT_widget)
	$vJ_widget.is_editing:=$is_editing
	$vJ_widget.redraw()
	// *
	// *****
	
	
	// *****
	// *
Function _chge($vJ_widget : Object)
	This:C1470._call_subform()
	
Function _call_subform()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	This:C1470.is_touched:=True:C214
	
	