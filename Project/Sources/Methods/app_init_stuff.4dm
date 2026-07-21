//%attributes = {"lang":"en"}

var $vC_primeNumber : Collection
var $vJ_stuff; $vJ_colors_square; $vJ_color_square; $vJ_colors_text : Object
$vJ_stuff:=Storage:C1525.j_stuff
$vJ_stuff:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_stuff:=$vJ_stuff
End use 

Use ($vJ_stuff)
	$vJ_colors_square:=New shared object:C1526
	$vJ_stuff.j_colors_square:=$vJ_colors_square
	$vJ_colors_square.l_space:=k_mdo_space
	$vJ_colors_square.is_sf:=True:C214
	$vJ_colors_square.l_shape:=-5  // Horto circle
	
	$vJ_color_square:=New shared object:C1526
	$vJ_stuff.j_color_square:=$vJ_color_square
	$vJ_color_square.l_space:=k_mdo_space
	$vJ_color_square.is_sf:=False:C215
	$vJ_color_square.l_shape:=-1  // square
	$vJ_stuff.j_color_square:=OB Copy:C1225($vJ_color_square; ck shared:K85:29)
	
	$vJ_colors_text:=New shared object:C1526
	$vJ_stuff.j_colors_text:=$vJ_colors_text
	$vJ_colors_text.l_space:=k_mdo_space
	$vJ_colors_text.is_sf:=True:C214
	$vJ_colors_text.l_shape:=-3  // Text
	
	$vC_primeNumber:=New shared collection:C1527
	$vJ_stuff.al_primeNumber:=$vC_primeNumber
	$vC_primeNumber.push(2; 3; 5; 7; 11; 13; 17; 19; 23; 29; 31; 37; 41; 43; 47; 53; 59; 61; 67; 71; 73; 79; 83; 89; 97)
	$vC_primeNumber.push(101; 103; 107; 109; 113; 127; 131; 137; 139; 149; 151; 157; 163; 167; 173; 179; 181; 191; 193; 197; 199; 211; 223; 227; 229; 233; 239; 241; 251; 257)
	
End use 

