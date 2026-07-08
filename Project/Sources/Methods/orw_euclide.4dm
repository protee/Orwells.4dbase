//%attributes = {}
// Project Method: i_euclide
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 12/04/2023   OG   Initial version.

#DECLARE($vL_a : Integer; $vL_b : Integer)->$vL_pgcd : Integer

var $vL_t : Integer
While ($vL_b#0)
	$vL_t:=$vL_b
	$vL_b:=$vL_a%$vL_b
	$vL_a:=$vL_t
End while 
$vL_pgcd:=$vL_a


