//%attributes = {"lang":"en"}

var $cE_TESSERAC : cs:C1710.TESSERACEntity
var $cES_TESSERAC : cs:C1710.TESSERACSelection
var $vJ_fields; $vJ_polygons; $vJ_cube; $vJ_lines; $vJ_pattern : Object
var $vC_at_properties : Collection
var $vT_property : Text

$cES_TESSERAC:=ds:C1482.TESSERAC.all()
If (waz_io_confirm_popup("ARE YOU SURE?"))
	For each ($cE_TESSERAC; $cES_TESSERAC)
		
		$vJ_fields:=$cE_TESSERAC.fields
		// l_angle ; l_stroke OK
		// Polygons
		$vJ_polygons:=New object:C1471()
		$vJ_fields.j_polygons:=$vJ_polygons
		$vJ_polygons.l_colors:=$vJ_fields.l_polygons
		$vJ_polygons.is_stroke:=$vJ_fields.is_poly_stroke
		$vJ_polygons.is_fill:=$vJ_fields.is_poly_fill
		$vJ_polygons.l_stroke:=2
		$vJ_polygons.l_opacity:=100
		// Cube
		$vJ_cube:=New object:C1471()
		$vJ_fields.j_cube:=$vJ_cube
		$vJ_cube.l_colors:=$vJ_fields.l_cube
		$vJ_cube.is_internal:=$vJ_fields.is_cube1
		$vJ_cube.is_external:=$vJ_fields.is_cube2
		$vJ_cube.l_stroke:=2
		$vJ_cube.l_opacity:=100
		// Lines
		$vJ_lines:=New object:C1471()
		$vJ_fields.j_lines:=$vJ_lines
		$vJ_lines.l_colors:=$vJ_fields.l_lines
		$vJ_lines.is_lines1:=$vJ_fields.is_lines1
		$vJ_lines.is_lines2:=$vJ_fields.is_lines2
		$vJ_lines.l_stroke:=2
		$vJ_lines.l_opacity:=100
		
		// l_bkg
		$vJ_fields.is_bkg:=True:C214
		$vJ_fields.is_bkg_ellipse:=False:C215
		$vJ_pattern:=New object:C1471()
		$vJ_fields.j_bkg:=$vJ_pattern
		$vJ_pattern.l_pattern:=2  // Fill
		$vJ_pattern.l_colors:=$vJ_fields.l_bkg
		$vJ_pattern.l_rxy:=-1
		$vJ_pattern.l_stroke:=0
		$vJ_pattern.l_opacity:=100
		
		$vC_at_properties:=New collection:C1472()
		$vC_at_properties.push("l_polygons"; "is_poly_stroke"; "is_poly_fill")
		$vC_at_properties.push("l_cube"; "is_cube1"; "is_cube2")
		$vC_at_properties.push("l_lines"; "is_lines1"; "is_lines2")
		For each ($vT_property; $vC_at_properties)
			OB REMOVE:C1226($vJ_fields; $vT_property)
		End for each 
		
		$cE_TESSERAC.fields:=$vJ_fields
		$cE_TESSERAC.save()
	End for each 
End if 
