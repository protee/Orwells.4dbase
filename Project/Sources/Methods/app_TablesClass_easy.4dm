//%attributes = {"lang":"en","preemptive":"capable"}

#DECLARE()->$vC_aj_TablesClass : Collection
var $vC_aj_modulesTables; $vC_tables : Collection
var $vL_color_table_idx : Integer
var $vJ_module; $vJ_relate : Object


// ***** Easy create
// *
$vJ_relate:=zen__storage_widgets().j_relate
Use ($vJ_relate)
	$vJ_relate.t_base_name:=app__storage_prefs.t_name
	//$vJ_relate.l_bkg_color:=k_MDcolorBlack
	$vJ_relate.l_modules_mdx:=13
	$vJ_relate.l_tables_mdx:=5
	$vJ_relate.l_links_mdx:=4
	$vJ_relate.l_modules_opacity:=50
	//$vJ_relate.l_opacity:=80
End use 
$vL_color_table_idx:=6  // Start color MD idx
// *
// *****
$vC_aj_modulesTables:=New collection:C1472()


// ***** Module Orwell
// *
$vJ_module:=New object:C1471()
$vC_aj_modulesTables.push($vJ_module)
$vJ_module.t_char:="O"
$vJ_module.t_label:="Orwell"
$vC_tables:=New collection:C1472()
$vJ_module.ap_tables:=$vC_tables  // ORDER IMPORTANT FOR IMPORT ID -> UID
$vC_tables.push(->[SESSIONS:11]; ->[SPEECHES:12]; ->[FRAGMENTS:13])
$vC_tables.push(->[ORWELLS:15]; ->[CATEGORIES:16]; ->[ACTIONS:14])
// *
// *****

// ***** Module Public
// *
$vJ_module:=New object:C1471()
$vC_aj_modulesTables.push($vJ_module)
$vJ_module.t_char:="S"
$vJ_module.t_label:="SVG Stuff"
$vC_tables:=New collection:C1472()
$vJ_module.ap_tables:=$vC_tables
$vC_tables.push(->[MULTIPLAY:7]; ->[TESSERAC:8]; ->[YIN_YANG:31]; ->[CIRCLES:33])
// *
// *****

$vC_aj_TablesClass:=zen_TablesClass_easy_create($vC_aj_modulesTables; $vL_color_table_idx)

