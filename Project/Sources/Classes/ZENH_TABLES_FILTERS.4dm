
Class extends ZEN__WIDGETS

Class constructor($vT_table : Text; $vL_table : Integer; $is_local : Boolean; $vL_winRef : Integer)
	var $vJ_params : Object
	Super:C1705()
	This:C1470.t_table:=$vT_table
	This:C1470.l_table:=$vL_table
	This:C1470.is_local:=$is_local
	This:C1470.l_winRef:=$vL_winRef
	
	$vJ_params:=New object:C1471()
	This:C1470.j_params:=$vJ_params
	
	
	// *****
	// *
Function form_events()
	var $vC_aj_search : Collection
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vL_event_code:=Form event code:C388
	
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Load:K2:1)
			This:C1470.set_widgets()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_cancel")
					CANCEL:C270
					
				: ($vT_objectName="btn_accept")
					This:C1470.get_widgets()
					ACCEPT:C269
					
				: ($vT_objectName="btn_clear")
					$vC_aj_search:=Form:C1466.init_search()
					This:C1470.set_widgets($vC_aj_search)
					
			End case 
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)  
			
	End case 
	// *
	// *****
	
	
	
Function _resize()
	var $vL_width; $vL_height : Integer
	var $vT_group : Text
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_group:="group"
	OBJECT SET COORDINATES:C1248(*; $vT_group; 0; 0; $vL_width; $vL_height)
	
	
	
	// *****
	// *
Function _get_search_popup($vT_name : Text; $vT_popup : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="popup"
	$vJ_search.t_name:=$vT_name
	$vJ_search.t_popup:=$vT_popup  // Tag du popups
	
Function _get_search_dates($vT_name : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="dates"
	$vJ_search.t_name:=$vT_name
	
Function _get_search_date($vT_name : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="date"
	$vJ_search.t_name:=$vT_name
	
Function _get_search_switch($vT_name : Text; $is_boolean : Boolean)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="switch"
	$vJ_search.t_name:=$vT_name
	$vJ_search.v_value:=$is_boolean ? False:C215 : 2  // False or idle
	
Function _get_search_text($vT_name : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="text"
	$vJ_search.t_name:=$vT_name
	
Function _get_search_c4E($vT_name : Text; $vT_table : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="c4E"
	$vJ_search.t_name:=$vT_name
	$vJ_search.t_table:=$vT_table
	
Function _get_search_c4ES($vT_name : Text; $vT_table : Text)->$vJ_search : Object
	$vJ_search:=New object:C1471
	$vJ_search.t_type:="c4ES"
	$vJ_search.t_name:=$vT_name
	$vJ_search.t_table:=$vT_table
	// *
	// *****
	
	
	
	// *****
	// *
Function _get_aj_search()->$vC_aj_search : Collection
	var $vJ_params : Object
	$vJ_params:=This:C1470.j_params
	$vC_aj_search:=$vJ_params.aj_search
	
	
Function clear_search($vC_aj_search_in : Collection)->$vC_aj_search : Collection  // Default values stored when form is closed
	var $is_boolean : Boolean
	var $vJ_search : Object
	var $vT_name; $vT_type : Text
	$vC_aj_search:=$vC_aj_search_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_search_in
	For each ($vJ_search; $vC_aj_search)
		$vT_name:=$vJ_search.t_name
		$vT_type:=$vJ_search.t_type
		Case of 
			: ($vT_type="popup")
				$vJ_search.t_value:=""  // Idle
				
			: ($vT_type="dates")
				$vJ_search.d_value1:=!00-00-00!
				$vJ_search.d_value2:=!00-00-00!
				
			: ($vT_type="date")
				$vJ_search.d_value:=!00-00-00!
				
			: ($vT_type="switch")
				$is_boolean:=(Value type:C1509($vJ_search.v_value)=Is boolean:K8:9)
				$vJ_search.v_value:=$is_boolean ? False:C215 : 2  // False or idle
				
			: ($vT_type="c4E")
				$vJ_search.t_uid:=""
				
			: ($vT_type="c4ES")
				$vJ_search.c4ES:=Null:C1517
				
			: ($vT_type="text")
				$vJ_search[$vT_name]:=""
				
			Else 
		End case 
	End for each 
	
	
Function set_widgets($vC_aj_search_in : Collection)->$vC_aj_search : Collection
	var $vJ_search; $vJ_widget : Object
	var $vT_name; $vT_type : Text
	$vC_aj_search:=$vC_aj_search_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_search_in
	For each ($vJ_search; $vC_aj_search)
		$vT_name:=$vJ_search.t_name
		$vT_type:=$vJ_search.t_type
		Case of 
			: ($vT_type="popup")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "t_popup"; "t_value")
				$vJ_widget.resize()
				
			: ($vT_type="dates")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "d_value1"; "d_value2")
				
			: ($vT_type="date")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "d_value")
				
			: ($vT_type="switch")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "v_value")
				
			: ($vT_type="c4E")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "t_table"; "t_UID")
				
			: ($vT_type="c4ES")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_search; $vJ_widget; "t_table"; "c4ES")
				
			: ($vT_type="text")
				OBJECT SET VALUE:C1742($vT_name; $vJ_search[$vT_name])
			Else 
		End case 
		$vJ_widget.redraw()
	End for each 
	
	
Function get_widgets($vC_aj_search_in : Collection)->$vC_aj_search : Collection
	var $vJ_search; $vJ_widget : Object
	var $vT_name; $vT_type : Text
	$vC_aj_search:=$vC_aj_search_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_search_in
	For each ($vJ_search; $vC_aj_search)
		$vT_name:=$vJ_search.t_name
		$vT_type:=$vJ_search.t_type
		Case of 
			: ($vT_type="popup")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "t_value")
				
			: ($vT_type="dates")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "d_value1"; "d_value2")
				
			: ($vT_type="date")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "d_value")
				
			: ($vT_type="switch")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "v_value")
				
			: ($vT_type="c4E")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "t_UID")
				
			: ($vT_type="c4ES")
				$vJ_widget:=OBJECT Get value:C1743($vT_name)
				wox_vJ_overload($vJ_widget; $vJ_search; "c4ES")
				
			: ($vT_type="text")
				$vJ_search[$vT_name]:=OBJECT Get value:C1743($vT_name)
			Else 
		End case 
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function is_search($vC_aj_search_in : Collection)->$is_search : Boolean
	var $vC_aj_search : Collection
	var $vJ_search : Object
	var $vT_type; $vT_uid; $vT_name : Text
	var $vV_value : Variant
	var $c4ES : 4D:C1709.EntitySelection
	$vC_aj_search:=$vC_aj_search_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_search_in
	
	$is_search:=False:C215
	For each ($vJ_search; $vC_aj_search)
		$vT_type:=$vJ_search.t_type
		Case of 
			: ($vT_type="popup")
				$is_search:=($vJ_search.t_value#"")
				
			: ($vT_type="dates")
				$is_search:=($vJ_search.d_value1#!00-00-00!) || ($vJ_search.d_value2#!00-00-00!)
				
			: ($vT_type="date")
				$is_search:=($vJ_search.d_value#!00-00-00!)
				
			: ($vT_type="switch")
				$vV_value:=$vJ_search.v_value
				$is_search:=(Value type:C1509($vV_value)=Is boolean:K8:9 ? ($vV_value=True:C214) : ($vV_value#2))
				
			: ($vT_type="c4E")
				$vT_uid:=$vJ_search.t_uid
				$is_search:=($vT_uid#"")
				
			: ($vT_type="c4ES")
				$c4ES:=$vJ_search.c4ES
				$is_search:=($c4ES#Null:C1517) && ($c4ES.length#0)
				
			: ($vT_type="text")
				$is_search:=($vJ_search[$vT_name]#"")
			Else 
		End case 
		If ($is_search)
			break
		End if 
	End for each 
	// *
	// *****
	
	
	// ***** Seems to be automatically in the context of where the class was created - Forms open
	// *
Function search_form($vT_form : Text)->$isOk : Boolean
	$is_local:=This:C1470.is_local
	$vL_winRef:=This:C1470.l_winRef
	If ($is_local)
		$vT_table:=This:C1470.t_table
		$vT_form:=$vT_table+"_"+$vT_form
	Else 
		$vP_table:=Table:C252(This:C1470.l_table)
	End if 
	
	$isOk:=x_check_form_exists($vT_form; $vP_table)
	If ($isOk)
		$vJ_form:=This:C1470
		// Calculate the form to open
		$vL_winRef:=$vJ_params.l_winRef
		GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom; $vL_winRef)
		var $vL_offset : Integer
		var $vL_winRef; $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_form; $vL_winRef_record : Integer
		var $is_local : Boolean
		var $vJ_form; $vJ_params : Object
		var $vP_table : Pointer
		var $vT_table : Text
		$vL_offset:=16
		$vL_left+=$vL_offset
		$vL_top+=$vL_offset
		x_form_xy_calculate($vP_table; $vT_form; ->$vL_left; ->$vL_top; k_form_leftTop)
		$vL_form:=x_sheet_form_window()
		$vL_winRef_record:=Open form window:C675($vP_table->; $vT_form; $vL_form; $vL_left; $vL_top)
		If ($vP_table=Null:C1517)
			DIALOG:C40($vT_form; $vJ_form)
		Else 
			DIALOG:C40($vP_table->; $vT_form; $vJ_form)
		End if 
		$isOk:=(OK=1)
		CLOSE WINDOW:C154($vL_winRef_record)
		
	Else 
		cs:C1710.wox.SOUNDS.me.play_beep()
	End if 
	// *
	// *****
	
	