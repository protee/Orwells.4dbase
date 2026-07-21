//%attributes = {"lang":"en"}
// Project Method: wox__storage_prefs
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

#DECLARE->$vJ_stuff : Object
var $vJ_preset : Object
$vJ_stuff:=Storage:C1525.j_stuff

Use ($vJ_stuff)
	// ***** Dial colors
	// *
	$vJ_preset:=zenh_io_colors_from_row(Null:C1517; k_MDcolorsIdx_red)
	$vJ_stuff.j_io_red:=OB Copy:C1225($vJ_preset; ck shared:K85:29; $vJ_stuff)
	
	$vJ_preset:=zenh_io_colors_from_row(Null:C1517; k_MDcolorsIdx_orange)
	$vJ_stuff.j_io_orange:=OB Copy:C1225($vJ_preset; ck shared:K85:29; $vJ_stuff)
	
End use 

