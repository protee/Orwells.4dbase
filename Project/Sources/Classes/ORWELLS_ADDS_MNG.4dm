

Class constructor($vT_LB : Text)
	//wox_prefs_windows_load()
	This:C1470._initialize()
	
Function _initialize()
	OBJECT SET VISIBLE:C603(*; "@_speeches"; Bool:C1537(Form:C1466.is_speaches))
	This:C1470._yinYang_change()
	
	
Function form_events($vL_event_code : Integer)
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $isOk : Boolean
	
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			//wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="btn_sepCheck")
					This:C1470._do_sepCheck()
					
				: ($vT_objectName="btn_parse")
					This:C1470._do_parse()
					
				: ($vT_objectName="btn_stringify")
					This:C1470._do_stringify()
					
				: ($vT_objectName="btn_delete")
					This:C1470._do_delete()
					
				: ($vT_objectName="btn_cancel")
					CANCEL:C270
					
				: ($vT_objectName="btn_accept")
					$isOk:=This:C1470._do_it()
					If ($isOk)
						ACCEPT:C269
					End if 
			End case 
			
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _yinYang_change()
	var $vL_yinYang : Integer
	$vL_yinYang:=Form:C1466.l_yinYang
	OBJECT SET VISIBLE:C603(*; "@_sepLine"; $vL_yinYang=2)
	OBJECT SET VISIBLE:C603(*; "wox_yinISO2"; $vL_yinYang#1)
	OBJECT SET VISIBLE:C603(*; "wox_yangISO2"; $vL_yinYang#0)
	// *
	// *****
	
	
	// *****
	// *
Function _get_separator()->$vC_at_separators : Collection
	$vC_at_separators:=app__storage_menuBtns().m_separators.at_separators
	
	
Function _get_separator_char($is_lines : Boolean; $is_stringify : Boolean)->$vT_separator : Text
	var $vC_at_separators : Collection
	var $vL_separator : Integer
	$vC_at_separators:=This:C1470._get_separator()
	$vL_separator:=$is_lines ? Form:C1466.l_sepLines : Form:C1466.l_sepLine
	$vT_separator:=$vC_at_separators[$vL_separator]
	If ($is_stringify)
		$vT_separator:=$vT_separator<" " ? $vT_separator : ($vT_separator="," ? $vT_separator+" " : " "+$vT_separator+" ")
	End if 
	
	
Function _get_lb_selected()->$vC_lb_selected : Collection
	$vC_lb_selected:=Form:C1466.lb_selected
	$vC_lb_selected:=$vC_lb_selected#Null:C1517 ? $vC_lb_selected : New collection:C1472()
	$vC_lb_selected:=$vC_lb_selected.length#0 ? $vC_lb_selected : Form:C1466.lb_selection
	
	
Function _do_sepCheck()
	var $vC_at_separators : Collection
	var $idx_start; $vL_sepLine; $vL_sepLines; $idx : Integer
	var $vJ_widget : Object
	var $vT_yinYang; $vT_sep : Text
	$vC_at_separators:=This:C1470._get_separator()
	$vT_yinYang:=OBJECT Get value:C1743("oT_yinYang")
	// Check for line
	$idx_start:=$vC_at_separators.length-1
	$vL_sepLine:=-1
	$vL_sepLines:=-1
	For ($idx; $idx_start; 0; -1)
		$vT_sep:=$vC_at_separators[$idx]
		If (Position:C15($vT_sep; $vT_yinYang)>0)
			$vL_sepLine:=$idx
			break
		End if 
	End for 
	// Check for lines
	$idx:=0
	For each ($vT_sep; $vC_at_separators)
		If (Position:C15($vT_sep; $vT_yinYang)>0)
			$vL_sepLines:=$idx
			break
		End if 
		$idx+=1
	End for each 
	
	If ($vL_sepLine>=0)
		$vJ_widget:=OBJECT Get value:C1743("waz_sepLine")
		Form:C1466.l_sepLine:=$vL_sepLine
		$vJ_widget.redraw()
	End if 
	If ($vL_sepLines>=0)
		$vJ_widget:=OBJECT Get value:C1743("waz_sepLines")
		Form:C1466.l_sepLines:=$vL_sepLines
		$vJ_widget.redraw()
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _do_parse($is_wood : Boolean)
	var $vC_yinYang; $vC_lb_selection; $vC_line : Collection
	var $vL_yinYang; $tt : Integer
	var $vJ_line : Object
	var $vT_yinYang; $vT_sepLine; $vT_sepLines; $vT_line; $vT_yin; $vT_yang : Text
	$vT_yinYang:=OBJECT Get value:C1743("oT_yinYang")
	$vL_yinYang:=Form:C1466.l_yinYang
	
	$vT_sepLine:=This:C1470._get_separator_char(False:C215)
	$vT_sepLines:=This:C1470._get_separator_char(True:C214)
	$vC_yinYang:=Split string:C1554($vT_yinYang; $vT_sepLines)
	
	$vC_lb_selection:=New collection:C1472()
	For each ($vT_line; $vC_yinYang)
		$vJ_line:=New object:C1471()
		Case of 
			: ($vL_yinYang=0)
				$vT_yin:=$vT_line
				$vT_yang:=""
				
			: ($vL_yinYang=1)
				$vT_yin:=""
				$vT_yang:=$vT_line
				
			Else 
				$vC_line:=Split string:C1554($vT_line; $vT_sepLine; sk trim spaces:K86:2)
				$tt:=$vC_line.length
				$vT_yin:=$tt>=1 ? $vC_line[0] : ""
				$vT_yang:=$tt>=2 ? $vC_line[1] : ""
				
		End case 
		$vJ_line.t_yin:=$vT_yin
		$vJ_line.t_yang:=$vT_yang
		$vC_lb_selection.push($vJ_line)
	End for each 
	Form:C1466.lb_selection:=$vC_lb_selection
	
	
Function _do_stringify()
	var $vC_yinYang; $vC_lb_selected : Collection
	var $vL_yinYang; $tt : Integer
	var $vJ_line : Object
	var $vT_sepLine; $vT_sepLines; $vT_yin; $vT_yang; $vT_line; $vT_yinYang : Text
	var $isOk : Boolean
	$vC_lb_selected:=This:C1470._get_lb_selected()
	$tt:=$vC_lb_selected.length
	$isOk:=waz_io_confirm_popup("Stringify lines ("+String:C10($tt)+"?")
	If ($isOk)
		$vL_yinYang:=Form:C1466.l_yinYang
		$vT_sepLine:=This:C1470._get_separator_char(False:C215; True:C214)
		$vT_sepLines:=This:C1470._get_separator_char(True:C214; True:C214)
		$vC_yinYang:=New collection:C1472()
		For each ($vJ_line; $vC_lb_selected)
			$vT_yin:=$vJ_line.t_yin
			$vT_yang:=$vJ_line.t_yang
			Case of 
				: ($vL_yinYang=0)
					$vT_line:=$vT_yin
					
				: ($vL_yinYang=1)
					$vT_line:=$vT_yang
					
				Else 
					$vT_line:=$vT_yin+$vT_sepLine+$vT_yang
					
			End case 
			$vC_yinYang.push($vT_line)
		End for each 
		$vT_yinYang:=$vC_yinYang.join($vT_sepLines)
		OBJECT SET VALUE:C1742("oT_yinYang"; $vT_yinYang)
	End if 
	
	
Function _do_delete()
	var $vC_lb_selected; $vC_lb_selection : Collection
	var $idx_end; $idx : Integer
	var $vJ_selection : Object
	$vC_lb_selected:=This:C1470._get_lb_selected()
	$vC_lb_selection:=Form:C1466.lb_selection
	$idx_end:=$vC_lb_selection.length-1
	For ($idx; $idx_end; 0; -1)
		$vJ_selection:=$vC_lb_selection[$idx]
		If ($vC_lb_selected.indexOf($vJ_selection)>=0)
			$vC_lb_selection.remove($idx)
		End if 
	End for 
	Form:C1466.lb_selection:=$vC_lb_selection
	LISTBOX SELECT ROW:C912(*; "LB"; 0; lk remove from selection:K53:3)
	// *
	// *****
	
	
Function _do_it()->$isOk : Boolean
	var $vC_at_yinTongue; $vC_at_yangTongue; $vC_lb_selected : Collection
	var $tt : Integer
	var $vT_UIDcategory; $vT_popup : Text
	
	$vC_lb_selected:=This:C1470._get_lb_selected()
	$tt:=$vC_lb_selected.length
	If ($tt=0)
		waz_io_alert_popup("No Keywords !")
	Else 
		$vT_UIDcategory:=Form:C1466.UIDcategory
		$vT_popup:="Keywords found: "+String:C10($tt)
		If ($vT_UIDcategory="")
			$vT_popup+=" (No category selected)"
		End if 
		$isOk:=waz_io_confirm_popup($vT_popup+" ?")
		If ($isOk)
			$vC_at_yinTongue:=$vC_lb_selected.extract("t_yin")
			$vC_at_yangTongue:=$vC_lb_selected.extract("t_yang")
			Form:C1466.at_yinTongue:=$vC_at_yinTongue
			Form:C1466.at_yangTongue:=$vC_at_yangTongue
		End if 
	End if 
	
	