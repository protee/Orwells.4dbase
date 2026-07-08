// *****
// *
// Class: _wocs
// Olivier Grimbert — Protée sarl — 15/08/2024 14:18:11
//
// Description: 
//
// Date       | Who | Comment
// 15/08/2024 | OG  | Updated
// *
// *****

Class constructor($vT_widget : Text)
	If ($vT_widget#"")
		This:C1470.__vJ_params($vT_widget)
	End if 
	
	//This.j_value:=New object
	This:C1470.t_property:=""
	This:C1470.p_value:=Null:C1517
	This:C1470.l_border:=Border None:K42:27
	This:C1470.t_widget:=""
	
	
Function __vJ_params($vT_widget : Text)
	var $vC_entries : Collection
	var $vL_count_parameters; $vL_type : Integer
	var $vJ_widget; $vJ_item : Object
	var $vT_key : Text
	var $vV_value : Variant
	//$vJ_widget:=zen__storage_widgets($vT_widget)
	$vJ_widget:=Storage:C1525.j_widgets[$vT_widget]  // APP independent !
	$vL_count_parameters:=Count parameters:C259
	
	$vC_entries:=OB Entries:C1720($vJ_widget)
	For each ($vJ_item; $vC_entries)
		$vT_key:=$vJ_item.key
		$vV_value:=$vJ_item.value
		$vL_type:=Value type:C1509($vV_value)
		Case of 
			: ($vL_type=Is object:K8:27)
				This:C1470[$vT_key]:=OB Copy:C1225($vV_value; ck not shared:K85:35)
			: ($vL_type=Is collection:K8:32)
				This:C1470[$vT_key]:=$vV_value.copy(ck not shared:K85:35)
			Else 
				This:C1470[$vT_key]:=$vV_value
		End case 
	End for each 
	
	
	// *****
	// *
Function load($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; Border None:K42:27)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._load()))
	
	
Function resize($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; This:C1470.l_border)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._resize()))
	
	
Function redraw($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._redraw()))
	
	
Function update($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	OBJECT SET BORDER STYLE:C1262(*; $vT_widget; This:C1470.l_border)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._update()))
	
	
Function unload($vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._unload()))
	
	
Function get_object_wh($vT_object : Text; $vP_width : Pointer; $vP_height : Pointer; $vT_widget : Text)  // Wrapper into subform
	var $vJ_this : Object
	$vT_widget:=This:C1470._get_widget_name($vT_widget)
	$vJ_this:=This:C1470
	EXECUTE METHOD IN SUBFORM:C1085($vT_widget; Formula:C1597($vJ_this._get_object_wh($vT_object; $vP_width; $vP_height)))
	
	
Function get_canvas_wh($vP_width : Pointer; $vP_height : Pointer; $vT_widget : Text)  // Wrapper into subform
	This:C1470.get_object_wh("canvas"; $vP_width; $vP_height; $vT_widget)
	// *
	// *****
	
	
	// *****
	// *
Function set_widget_name($vT_widget : Text)
	// Set the widget instance name into the class, empty = OBJECT Get name, else $vT_widget
	$vT_widget:=$vT_widget="" ? OBJECT Get name:C1087 : $vT_widget
	This:C1470.t_widget:=$vT_widget
	
	
Function bind_to($vT_property : Text; $vJ_value : Object)
	$vJ_value:=$vJ_value#Null:C1517 ? $vJ_value : Form:C1466
	This:C1470.j_value:=$vJ_value
	This:C1470.t_property:=$vT_property
	
	
Function bind_to_c4E($vT_property : Text; $vV_default : Variant)
	var $vJ_value : Object
	This:C1470.is_editing:=Form:C1466.is_editing
	$vJ_value:=Form:C1466.c4E
	This:C1470.j_value:=$vJ_value
	This:C1470.t_property:=$vT_property
	If (Count parameters:C259>=2) && Form:C1466.is_new
		$vJ_value[$vT_property]:=$vV_default
	End if 
	
	
Function bind_to_c4E_vJ($vT_field : Text; $vJ_default : Object)
	var $c4E : 4D:C1709.Entity
	var $vJ_field : Object
	var $is_new : Boolean
	$is_new:=Form:C1466.is_new
	This:C1470.is_new:=$is_new
	This:C1470.is_editing:=Form:C1466.is_editing
	$c4E:=Form:C1466.c4E
	$vJ_field:=$c4E[$vT_field]
	If ($vJ_field=Null:C1517) || ($is_new && Not:C34(Form:C1466.is_dup))
		$c4E[$vT_field]:=$vJ_default#Null:C1517 ? $vJ_default : This:C1470.j_value
	Else 
		This:C1470.j_value:=$c4E[$vT_field]
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _get_object_wh($vT_object : Text; $vP_width : Pointer; $vP_height : Pointer)
	var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
	OBJECT GET COORDINATES:C663(*; $vT_object; $vL_left; $vL_top; $vL_right; $vL_bottom)
	$vP_width->:=$vL_right-$vL_left
	$vP_height->:=$vL_bottom-$vL_top
	
	
Function _get_widget_name($vT_widget_in : Text)->$vT_widget : Text
	// get widget name, from stored, input or from OBJECT Get name
	var $vT_widget_object : Text
	$vT_widget_object:=This:C1470.t_widget
	If ($vT_widget_in="")  // Not given
		If ($vT_widget_object#"")
			$vT_widget:=$vT_widget_object  // Get stored
		Else 
			$vT_widget:=OBJECT Get name:C1087  // Get from object and store
			This:C1470.t_widget:=$vT_widget
		End if 
	Else 
		$vT_widget:=$vT_widget_in  // use given and store
		This:C1470.t_widget:=$vT_widget
	End if 
	
	
Function _update()
	This:C1470.resize()
	This:C1470.redraw()
	// *
	// *****
	
	
	
	// MARK: - read write
	
	
	// ***** TEXT
	// *
Function _ext_read_t()->$vT_value : Text
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_value:=$vP_value->
		This:C1470.t_value:=$vT_value
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "t_value"
		This:C1470[$vT_internal]:=$vT_value
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vT_value:=$vJ_value[$vT_property]
		Else 
			$vT_value:=This:C1470.t_value
		End if 
	End if 
	
	
Function _ext_write_t($vT_value : Text)
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	This:C1470.t_value:=$vT_value
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "t_value"
		$vP_value->:=This:C1470[$vT_internal]
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vJ_value[$vT_property]:=$vT_value
		End if 
	End if 
	// *
	// *****
	
	
	// ***** TEXT
	// *
Function _ext_read_UID()->$vT_UID : Text
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_UID:=$vP_value->
		This:C1470.t_UID:=$vT_UID
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "t_UID"
		This:C1470[$vT_internal]:=$vT_UID
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vT_UID:=$vJ_value[$vT_property]
		Else 
			$vT_UID:=This:C1470.t_UID
		End if 
	End if 
	
	
Function _ext_write_UID($vT_UID : Text)
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	This:C1470.t_UID:=$vT_UID
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "t_UID"
		$vP_value->:=This:C1470[$vT_internal]
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vJ_value[$vT_property]:=$vT_UID
		End if 
	End if 
	// *
	// *****
	
	
	// ***** INTEGER
	// *
Function _ext_read_l()->$vL_value : Integer
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vL_value:=$vP_value->
		This:C1470.l_value:=$vL_value
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "l_value"
		This:C1470[$vT_internal]:=$vL_value
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vL_value:=$vJ_value[$vT_property]
		Else 
			//$vV_value:=This.v_value
			//$vL_state:=(This.is_idle) ? $vV_value : Num($vV_value)
			$vL_value:=This:C1470.l_value
		End if 
	End if 
	
Function _ext_write_l($vL_value : Integer)
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	This:C1470.l_value:=$vL_value
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "l_value"
		$vP_value->:=This:C1470[$vT_internal]
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vJ_value[$vT_property]:=$vL_value
		End if 
	End if 
	// *
	// *****
	
	
	
	// ***** DATE
	// *
Function _ext_read_d()->$vD_value : Date
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vD_value:=$vP_value->
		This:C1470.d_value:=$vD_value
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "d_value"
		This:C1470[$vT_internal]:=$vD_value
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vD_value:=$vJ_value[$vT_property]
			This:C1470.d_value:=$vD_value
		Else 
			$vD_value:=This:C1470.d_value
		End if 
	End if 
	
	
Function _ext_write_d($vD_value : Date)
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	This:C1470.d_value:=$vD_value
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "d_value"
		$vP_value->:=This:C1470[$vT_internal]
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vJ_value[$vT_property]:=$vD_value
		End if 
	End if 
	// *
	// *****
	
	
	
	// ***** TIME
	// *
Function _ext_read_h()->$vH_value : Time
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vH_value:=$vP_value->
		This:C1470.h_value:=$vH_value
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "h_value"
		This:C1470[$vT_internal]:=$vH_value
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vH_value:=$vJ_value[$vT_property]
			This:C1470.h_value:=$vH_value
		Else 
			$vH_value:=This:C1470.h_value
		End if 
	End if 
	
	
Function _ext_write_h($vH_value : Time)
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	This:C1470.h_value:=$vH_value
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		$vT_internal:=$vT_internal#"" ? $vT_internal : "h_value"
		$vP_value->:=This:C1470[$vT_internal]
	Else 
		$vJ_value:=This:C1470.j_value
		If ($vJ_value#Null:C1517)
			$vT_property:=This:C1470.t_property
			$vJ_value[$vT_property]:=$vH_value
		End if 
	End if 
	// *
	// *****
	
	
	
	// MARK: - External read/write - pointer or j_value.t_property -> j_widget.t_internal
	// *
Function _externalRead()  // Synch an internal property to a pointer, or an j_value.t_property
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		If ($vT_internal#"")
			This:C1470[$vT_internal]:=$vP_value->
		End if 
	Else 
		$vJ_value:=This:C1470.j_value
		$vT_property:=This:C1470.t_property
		If ($vJ_value#Null:C1517) && ($vT_property#"")
			$vT_internal:=This:C1470.t_internal
			$vT_internal:=$vT_internal#"" ? $vT_internal : $vT_property  // Use $vT_property if $vT_internal empty
			This:C1470[$vT_internal]:=$vJ_value[$vT_property]
		End if 
	End if 
	
	
Function _externalWrite()
	var $vJ_value : Object
	var $vP_value : Pointer
	var $vT_internal; $vT_property : Text
	$vP_value:=This:C1470.p_value
	If ($vP_value#Null:C1517)
		$vT_internal:=This:C1470.t_internal
		If ($vT_internal#"")
			$vP_value->:=This:C1470[$vT_internal]
		End if 
	Else 
		$vJ_value:=This:C1470.j_value
		$vT_property:=This:C1470.t_property
		If ($vJ_value#Null:C1517) && ($vT_property#"")
			$vT_internal:=This:C1470.t_internal
			$vT_internal:=$vT_internal#"" ? $vT_internal : $vT_property  // Use $vT_property if $vT_internal empty
			$vJ_value[$vT_property]:=This:C1470[$vT_internal]
		End if 
	End if 
	// *
	// *****
	
	