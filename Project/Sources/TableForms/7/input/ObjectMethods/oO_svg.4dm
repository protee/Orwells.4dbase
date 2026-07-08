
var $vP_mosaic : Pointer
$vP_mosaic:=Self:C308

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.fc.redraw()
		
	: (Form event code:C388=On Mouse Move:K2:35)
		var $isOk : Boolean
		var $txt; $vT_idSvg : Text
		$vT_idSvg:=SVG Find element ID by coordinates:C1054($vP_mosaic->; mouseX; mouseY)  // ID de l'élément svg survolé
		
		$isOk:=($vT_idSvg="line_@")
		If ($isOk)
			//$vL_index:=Num($vT_idSvg)
			$txt:=$vT_idSvg
			OBJECT SET HELP TIP:C1181($vP_mosaic->; $txt)
		End if 
		
End case 
