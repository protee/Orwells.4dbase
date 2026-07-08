//%attributes = {}

#DECLARE($cE_SPEECHES : cs:C1710.SPEECHESEntity; $vL_yinYang : Integer)->$c4ES_selection : 4D:C1709.EntitySelection
var $c4DC_orwells; $c4DC_FRAGMENTS : 4D:C1709.DataClass
var $isOk; $is_SPEECHES : Boolean
var $vC_at_yinTongue; $vC_at_yangTongue : Collection
var $cE_orwells : cs:C1710.ORWELLSEntity
var $cES_orwells : cs:C1710.ORWELLSSelection
var $vL_form; $vL_refWindow; $vL_orwells; $vL_count; $idx; $vL_order : Integer
var $vJ_form : Object
var $vT_form; $vT_title; $vT_UIDcategory; $vT_yin; $vT_yang : Text
var $vT_yinISO2; $vT_yangISO2 : Text
var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity

$is_SPEECHES:=$cE_SPEECHES#Null:C1517

$vJ_form:=New object:C1471()
$vJ_form.l_yinYang:=$vL_yinYang
$vJ_form.t_yinISO2:=$is_SPEECHES ? $cE_SPEECHES.yinISO2 : ""
$vJ_form.t_yangISO2:=$is_SPEECHES ? $cE_SPEECHES.yangISO2 : ""

$vT_form:="ORWELLS_ADDS_MNG"
$vL_form:=Sheet form window:K39:12
$vL_refWindow:=Open form window:C675($vT_form; $vL_form)
SET WINDOW TITLE:C213($vT_title; $vL_refWindow)
DIALOG:C40($vT_form; $vJ_form)
CLOSE WINDOW:C154($vL_refWindow)
$isOk:=(OK=1)
If ($isOk)
	$c4DC_orwells:=ds:C1482.ORWELLS
	$c4DC_FRAGMENTS:=ds:C1482.FRAGMENTS
	
	If ($is_SPEECHES)
		//$cE_FRAGMENTS:=$cE_SPEECHES.SPEECHES_FRAGMENTS.orderBy("order").last()
		$cE_FRAGMENTS:=ds:C1482.FRAGMENTS.query("UIDspeech = :1"; $cE_SPEECHES.UID).orderBy("order").last()
		$vL_order:=$cE_FRAGMENTS#Null:C1517 ? $cE_FRAGMENTS.order+1 : 1
	End if 
	
	$c4ES_selection:=$c4DC_orwells.newSelection()
	$vT_yinISO2:=$vJ_form.t_yinIso2
	$vT_yangISO2:=$vJ_form.t_yangIso2
	$vC_at_yinTongue:=$vJ_form.at_yinTongue
	$vC_at_yangTongue:=$vJ_form.at_yangTongue
	$vL_orwells:=$vJ_form.l_orwells
	$vT_UIDcategory:=$vJ_form.UIDcategory
	$vL_count:=0
	$idx:=0
	For each ($vT_yin; $vC_at_yinTongue)
		$vT_yang:=$vC_at_yangTongue[$idx]
		$cES_orwells:=$c4DC_orwells.query("yinTongue = :1 and yangTongue = :2"; $vT_yin; $vT_yang)
		If ($cES_orwells.length=0)
			$cE_orwells:=zen_entity_new($c4DC_orwells)
			$cE_orwells.yinISO2:=$vT_yinISO2
			$cE_orwells.yangISO2:=$vT_yangISO2
			$cE_orwells.yinTongue:=$vT_yin
			$cE_orwells.yangTongue:=$vT_yang
			$cE_orwells.colors:=$vL_orwells
			$cE_orwells.isActive:=True:C214
			$cE_orwells.UIDcategory:=$vT_UIDcategory
			zen_entity_save($cE_orwells)
		Else 
			$cE_orwells:=$cES_orwells[0]  // Take the first existing
		End if 
		
		If ($is_SPEECHES)
			$cE_FRAGMENTS:=zen_entity_new($c4DC_FRAGMENTS)
			$cE_FRAGMENTS.UIDorwell:=$cE_orwells.UID
			$cE_FRAGMENTS.UIDspeech:=$cE_SPEECHES.UID
			$cE_FRAGMENTS.order:=$vL_order
			$cE_FRAGMENTS.isActive:=True:C214
			zen_entity_save($cE_FRAGMENTS)
			$vL_order+=1
		End if 
		$c4ES_selection.add($cE_orwells)
		$vL_count+=1
		$idx+=1
	End for each 
	//waz_io_alert_popup("Imported : "+String($vL_count)+"!")
End if 

