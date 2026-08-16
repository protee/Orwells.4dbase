
Class constructor
	
	
	
Function _menu_sessions($vT_refMenu : Text)->$vT_refMenu_answer : Text  //  #GUESSED: $vT_refMenu_local
	var $is_toAttach : Boolean
	var $cE_SESSIONS : cs:C1710.SESSIONSEntity
	var $cES_SESSIONS : cs:C1710.SESSIONSSelection
	var $vT_refMenu_sub; $vT_path_icons : Text
	var $vL_color : Integer
	$is_toAttach:=($vT_refMenu#"")
	
	$vT_path_icons:="path:/RESOURCES/tables/icn_"
	$vT_refMenu_answer:=Create menu:C408
	APPEND MENU ITEM:C411($vT_refMenu_answer; "SESSIONS"; *)
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"sessions"+k_png_ext)
	DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
	//APPEND MENU ITEM($vT_refMenu_answer; "-")
	
	$cES_SESSIONS:=ds:C1482.SESSIONS.all().orderBy("label")
	For each ($cE_SESSIONS; $cES_SESSIONS)
		$vT_refMenu_sub:=This:C1470._menu_speeches($cE_SESSIONS)
		APPEND MENU ITEM:C411($vT_refMenu_answer; $cE_SESSIONS.label; $vT_refMenu_sub; *)
		//SET MENU ITEM PARAMETER($vT_refMenu_answer; -1; "SESSIONS-"+$cE_SESSIONS.UID)
		//SET MENU ITEM ICON($vT_refMenu_answer; -1; $vT_path_icons+"sessions"+k_png_ext)
		$vL_color:=woc_sp_colors_to_s_or_f($cE_SESSIONS.colors)
		woc_SET_MENU_ITEM_icns($vT_refMenu_answer; -1; $vL_color)
	End for each 
	
	If ($is_toAttach)
		APPEND MENU ITEM:C411($vT_refMenu; "Session"; $vT_refMenu_answer)
		RELEASE MENU:C978($vT_refMenu_answer)
	End if 
	
	
Function _menu_speeches($cE_SESSIONS : cs:C1710.SESSIONSEntity; $vT_refMenu : Text)->$vT_refMenu_answer : Text  //  #GUESSED: $vT_refMenu_local, $vL_id
	var $is_toAttach : Boolean
	var $cE_SPEECHES : cs:C1710.SPEECHESEntity
	var $cES_SPEECHES : cs:C1710.SPEECHESSelection
	var $vT_refMenu_sub; $vT_path_icons : Text
	var $vL_yinYang : Integer
	var $vJ_menu : Object
	$is_toAttach:=($vT_refMenu#"")
	
	$vT_path_icons:="path:/RESOURCES/tables/icn_"
	$vT_refMenu_answer:=Create menu:C408
	APPEND MENU ITEM:C411($vT_refMenu_answer; "SPEECHES"; *)
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"speeches"+k_png_ext)
	DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
	//APPEND MENU ITEM($vT_refMenu_answer; "-")
	
	$vJ_menu:=orw__storage_menuBtns().m_yinYangPlay
	$vT_path_icons:="path:/RESOURCES/"+$vJ_menu.t_path+"icn_"+$vJ_menu.t_key
	
	$cES_SPEECHES:=$cE_SESSIONS.SESSIONS_SPEECHES.orderBy("label")
	For each ($cE_SPEECHES; $cES_SPEECHES)
		$vT_refMenu_sub:=This:C1470._menu_fragments($cE_SPEECHES)
		APPEND MENU ITEM:C411($vT_refMenu_answer; $cE_SPEECHES.label; $vT_refMenu_sub; *)
		//SET MENU ITEM PARAMETER($vT_refMenu_answer; -1; "SPEECHES-"+$cE_SPEECHES.UID)
		$vL_yinYang:=$cE_SPEECHES.yinYang
		SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+String:C10($vL_yinYang)+k_png_ext)
	End for each 
	
	If ($is_toAttach)
		APPEND MENU ITEM:C411($vT_refMenu; "Speech"; $vT_refMenu_answer)
		RELEASE MENU:C978($vT_refMenu_answer)
	End if 
	
	
	
Function _menu_fragments($cE_SPEECHES : cs:C1710.SPEECHESEntity; $vT_refMenu : Text)->$vT_refMenu_answer : Text
	var $cE_FRAGMENTS : cs:C1710.FRAGMENTSEntity
	var $cE_ORWELLS : cs:C1710.ORWELLSEntity
	var $is_toAttach : Boolean
	var $cES_FRAGMENTS : cs:C1710.FRAGMENTSSelection
	var $vT_label; $vT_path_icons_01; $vT_path_icons; $vT_yinTongue; $vT_yangTongue; $vT_sep : Text
	var $vC_label : Collection
	var $vL_playOrder; $vL_colors; $vL_color : Integer
	$is_toAttach:=($vT_refMenu#"")
	
	$cES_FRAGMENTS:=$cE_SPEECHES.SPEECHES_FRAGMENTS
	$vL_playOrder:=$cE_SPEECHES.playOrder
	Case of 
		: ($vL_playOrder=0)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order")
			
		: ($vL_playOrder=1)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderBy("order DESC")
			
		: ($vL_playOrder=2)
			$cES_FRAGMENTS:=$cES_FRAGMENTS.orderByFormula(Formula:C1597(Random:C100))
	End case 
	
	$vT_path_icons_01:="path:/RESOURCES/icons/icn_magik_info.png"
	$vT_path_icons:="path:/RESOURCES/tables/icn_"
	$vT_refMenu_answer:=Create menu:C408
	
	APPEND MENU ITEM:C411($vT_refMenu_answer; "Play"; *)
	SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; "SPEECHES-"+$cE_SPEECHES.UID)
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"orwells"+k_png_ext)
	APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
	
	APPEND MENU ITEM:C411($vT_refMenu_answer; "FRAGMENTS"; *)
	SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"fragments"+k_png_ext)
	DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
	
	For each ($cE_FRAGMENTS; $cES_FRAGMENTS)
		$cE_ORWELLS:=$cE_FRAGMENTS.FRAGMENTS_ORWELLS
		$vC_label:=New collection:C1472()
		$vT_yinTongue:=Substring:C12($cE_ORWELLS.yinTongue; 1; 35)
		$vT_yangTongue:=Substring:C12($cE_ORWELLS.yangTongue; 1; 35)
		$vT_sep:=($vT_yinTongue#"") && ($vT_yangTongue#"") ? " | " : ""
		$vT_label:=$vT_yinTongue+$vT_sep+$vT_yangTongue+" ("+String:C10($cE_FRAGMENTS.order)+")"
		APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label; *)
		//SET MENU ITEM ICON($vT_refMenu_answer; -1; $vT_path_icons+"orwells"+k_png_ext)
		//SET MENU ITEM PARAMETER($vT_refMenu_answer; -1; "KEY-"+$cE_FRAGMENTS.UID)
		$vL_colors:=$cE_FRAGMENTS.colors
		$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_ORWELLS.colors
		$vL_color:=woc_sp_colors_to_s_or_f($vL_colors)
		woc_SET_MENU_ITEM_icns($vT_refMenu_answer; -1; $vL_color)
		
	End for each 
	
	If ($is_toAttach)
		APPEND MENU ITEM:C411($vT_refMenu; "Keyword"; $vT_refMenu_answer)
		RELEASE MENU:C978($vT_refMenu_answer)
	End if 
	
	