//%attributes = {}

var $vJ_fields; $vJ_yin; $vJ_yang : Object
var $vC_at_properties : Collection
var $vT_property : Text
var $cE_YIN_YANG : cs:C1710.YIN_YANGEntity
var $cES_YIN_YANG : cs:C1710.YIN_YANGSelection

$cES_YIN_YANG:=ds:C1482.YIN_YANG.all()
If (waz_io_confirm_popup("ARE YOU SURE?"))
	For each ($cE_YIN_YANG; $cES_YIN_YANG)
		
		$vJ_fields:=$cE_YIN_YANG.fields
		// l_coef ; l_angle ; l_stroke ; l_coef_dots ; l_gap OK
		// YIN
		$vJ_yin:=New object:C1471()
		$vJ_fields.j_yin:=$vJ_yin
		$vJ_yin.l_colors:=$vJ_fields.l_yin
		$vJ_yin.is_stroke:=$vJ_fields.is_yinStroke
		$vJ_yin.is_fill:=$vJ_fields.is_yinFill
		$vJ_yin.l_stroke:=2
		$vJ_yin.l_opacity:=$vJ_fields.l_yinOpacity
		// YANG
		$vJ_yang:=New object:C1471()
		$vJ_fields.j_yang:=$vJ_yang
		$vJ_yang.l_colors:=$vJ_fields.l_yang
		$vJ_yang.is_stroke:=$vJ_fields.is_yangStroke
		$vJ_yang.is_fill:=$vJ_fields.is_yangFill
		$vJ_yang.l_stroke:=2
		$vJ_yang.l_opacity:=$vJ_fields.l_yangOpacity
		
		$vC_at_properties:=New collection:C1472()
		$vC_at_properties.push("l_yin"; "is_yinStroke"; "is_yinFill"; "l_yinOpacity")
		$vC_at_properties.push("l_yang"; "is_yangStroke"; "is_yangFill"; "l_yangOpacity")
		For each ($vT_property; $vC_at_properties)
			OB REMOVE:C1226($vJ_fields; $vT_property)
		End for each 
		
		$cE_YIN_YANG.fields:=$vJ_fields
		$cE_YIN_YANG.save()
	End for each 
End if 
