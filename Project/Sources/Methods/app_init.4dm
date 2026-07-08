//%attributes = {"lang":"en"}
// Project Method: Compiler_init
//
// Parameter Type Description
//
//
// Description:
//
//
// Date        Init  Description
// ===================================================================
// 09/04/2023   OG   Initial version.

var $vJ_prefs : Object
$vJ_prefs:=app__storage_prefs

var $vT_host : Text
$vT_host:="Orwells"
wox_prefs_set_host_name($vT_host)

Use ($vJ_prefs)
	$vJ_prefs.t_name:=$vT_host
	$vJ_prefs.t_version:="21.0.00"
	$vJ_prefs.t_app:="orw"
	$vJ_prefs.l_make:=2  // 0 Database ; 1 Component ; 2 HDI ; 3 Quick
	$vJ_prefs.fo_rsc:=Folder:C1567(fk resources folder:K87:11)
	$vJ_prefs.is_free:=True:C214  // ✅ flag for wok registration
	$vJ_prefs.is_host:=True:C214  // Remove from menu ogToolsSuite
	$vJ_prefs.fu_callback_init:=Formula:C1597(_wom_callback_init)
	//$vJ_prefs.fu_callback_built:=Formula(_wom_callback_built)
	
	$vJ_prefs.l_scale:=2
End use 


