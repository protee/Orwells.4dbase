//%attributes = {}

// ***** DEFAULT
// *
HIDE TOOL BAR:C434
SET DEFAULT CENTURY:C392(20)
READ ONLY:C145(*)
MESSAGES OFF:C175
SET DATABASE PARAMETER:C642(Tips enabled:K37:79; 1)
SET DATABASE PARAMETER:C642(Tips delay:K37:80; 0.2*60)  // in tick
SET DATABASE PARAMETER:C642(Tips duration:K37:81; 12*60)  // in tick (12s) (edited)


// ***** COMPONENTS FOR PROD
// *
var $isOk : Boolean
var $vJ_prefs_wob; $vJ_screen; $vJ_screen_j_windows; $vJ_prefs_waz : Object
var $vJ_prefs; $vJ_wox_prefs : Object
var $c4Fo_prefs_zen : 4D:C1709.Folder
wok_init()
$vJ_wok_prefs:=wok__storage_prefs()

// *****
// * ogToolsSuite SERIAL VALID FOR ALL – in Orwells only
// *
$isOk:=wox_initRegister(""; "vvz03=S000003rkv?Z/0000T")
// *
// *****

If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($aT_components; 0)
	COMPONENT LIST:C1001($aT_components)
	
	If (Find in array:C230($aT_components; "wod_DevTools")>0)
		EXECUTE METHOD:C1007("wod_initRegister"; $isOk)
		EXECUTE METHOD:C1007("wod__storage_prefs"; $vJ_prefs)
		Use ($vJ_prefs)
			$vJ_prefs.fu_FORM_EDIT:=Formula:C1597(_wod_FORM_EDIT)
		End use 
		EXECUTE METHOD:C1007("wod_palette"; $isOk)
	End if 
	
	If (Find in array:C230($aT_components; "wom_Make")>0)
		EXECUTE METHOD:C1007("wom_initRegister"; $isOk)
		// *
		// *****
	End if 
	
End if 

$isOk:=woc_initRegister()
$isOk:=waz_initRegister()
$isOk:=wor_initRegister()
$isOk:=wqr_initRegister()
$isOk:=wob_initRegister()
$isOk:=zen_initRegister()  // zen_Nucleus init


// ***** Define a specific path for the sound's file prefs from this host
// *
$vJ_wox_prefs:=wox__storage_prefs()
$c4Fo_prefs_zen:=zen__prefs_get_c4Fo()
Use ($vJ_wox_prefs)
	$vJ_wox_prefs.fo_sounds_prefs:=$c4Fo_prefs_zen
End use 

// ***** DeepL api ; RapidApi
// *
// Or file in Library/ogToolsSuite/[wox]/api_keys.json Auto load in wox
//Use ($vJ_wox_prefs)
//$vJ_wox_prefs.t_DeepL_api_key:=""  // Your key – Used for all languages
//$vJ_wox_prefs.t_rapidApi_api_key:=""  // Your key – but tamil
//End use 
// *
// *****


// ***** Define the protected border of screen for windowing
// *
$vJ_screen:=wox__storage_prefs_screen()
$vJ_screen_j_windows:=$vJ_screen.j_windows
Use ($vJ_screen_j_windows)
	$vJ_screen_j_windows.l_left:=10
	$vJ_screen_j_windows.l_top:=Menu bar height:C440
	$vJ_screen_j_windows.l_right:=0  // Right border width
	$vJ_screen_j_windows.l_bottom:=0  // Bottom border height
End use 


// ***** Waz...
// *
$vJ_prefs_waz:=waz__storage_prefs()
Use ($vJ_prefs_waz)
	$vJ_prefs_waz.l_svg_scale:=2
End use 


// ***** Define the ogBoxes folder
// *
$vJ_prefs_wob:=wob__storage_prefs()
Use ($vJ_prefs_wob)
	$vJ_prefs_wob.fo_root_path:=Folder:C1567(fk data folder:K87:12).folder("DRIVE_BOX/zen_boxes")
End use 
// *
// *****
