//%attributes = {"lang":"en"}

#DECLARE($vP_object : Pointer; $vJ_prefs : Object)->$vO_pict : Picture
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_height; $vL_width : Integer

OBJECT GET COORDINATES:C663($vP_object->; $vL_left; $vL_top; $vL_right; $vL_bottom)
$vL_height:=$vL_bottom-$vL_top
$vL_width:=$vL_right-$vL_left

$vO_pict:=orw_multiplay_svg($vL_width; $vL_height; $vJ_prefs)
