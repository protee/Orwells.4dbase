Class extends Entity


Function getFragments()->$vC_aj_answer : Collection
	var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vL_playOrder : Integer
	var $vJ_answer : Object
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	$cES_FRAGMENTS:=This:C1470.SPEECHES_FRAGMENTS
	$vL_playOrder:=This:C1470.playOrder
	Case of 
		: ($vL_playOrder=0)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order")
			
		: ($vL_playOrder=1)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order DESC")
			
		: ($vL_playOrder=2)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderByFormula(Formula:C1597(Random:C100))
	End case 
	
	$vC_aj_answer:=New collection:C1472()
	For each ($cE_FRAGMENTS; $cES_FRAGMENTS)
		$vJ_answer:=New object:C1471()
		$vC_aj_answer.push($vJ_answer)
		$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
		$vJ_answer.t_yin:=$cE_ORWELLS.yinTongue
		$vJ_answer.t_yang:=$cE_ORWELLS.yangTongue
	End for each 
	