//%attributes = {}

#DECLARE($vL_winRef : Integer; $vP_vL_width : Pointer; $vP_vL_height : Pointer)
var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer

GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom; $vL_winRef)
$vP_vL_width->:=$vL_right-$vL_left
$vP_vL_height->:=$vL_bottom-$vL_top
