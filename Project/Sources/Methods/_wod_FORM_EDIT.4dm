//%attributes = {}
// *****
// *
// Method: _wod_FORM_EDIT
// By Olivier Grimbert — Protée sarl
// on 29/03/2024 11:03:53
//
// Description: 
//
// Date        Init  Description
// ===================================================================
// 29/03/2024   OG   Initial version.
// *
// *****

#DECLARE($vL_noTable : Integer; $vT_form : Text; $vT_object : Text)
var $is_R8plus : Boolean
var $vL_version; $vL_release : Integer
var $vT_version : Text
var $vP_table : Pointer

$vT_version:=Application version:C493()
$vL_version:=Num:C11(Substring:C12($vT_version; 1; 2))
$vL_release:=Num:C11(Substring:C12($vT_version; 3; 1))
$is_R8plus:=($vL_version>=21) || (($vL_version>=20) && ($vL_release>=8))
If ($vL_noTable=0)
	If ($is_R8plus)
		FORM EDIT:C1749($vT_form; $vT_object)
	Else 
		FORM EDIT:C1749($vT_form)
	End if 
Else 
	$vP_table:=Table:C252($vL_noTable)
	If ($is_R8plus)
		FORM EDIT:C1749($vP_table->; $vT_form; $vT_object)
	Else 
		FORM EDIT:C1749($vP_table->; $vT_form)
	End if 
End if 

