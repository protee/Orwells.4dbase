//%attributes = {"preemptive":"incapable"}

#DECLARE($vT_prefix : Text; $vT_language_source : Text; $vJ_languages : Object; $vC_at_languages : Collection; $vT_refMenu : Text)->$vT_refMenu_answer : Text
var $is_toAttach : Boolean
$is_toAttach:=($vT_refMenu#"")

var $vT_path_menu : Text
$vT_path_menu:="path:/RESOURCES/flags/"

var $vT_label : Text
$vT_label:="Translate from "+Uppercase:C13($vT_language_source)+" to…"

var $vC_languages_lbl; $vC_languages_short : Collection
$vC_languages_lbl:=$vJ_languages.at_lbl
$vC_languages_short:=$vJ_languages.at_short

$vT_refMenu_answer:=Create menu:C408
APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label; *)
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_language_source+k_png_ext)
DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
APPEND MENU ITEM:C411($vT_refMenu_answer; "-")

var $vC_all_flags : Collection
var $vT_all_flags : Text
$vC_all_flags:=$vC_languages_short.filter(Formula:C1597($1.value#$2); $vT_language_source)
$vT_all_flags:=Uppercase:C13($vC_all_flags.join(", "))

APPEND MENU ITEM:C411($vT_refMenu_answer; "ALL flags ("+$vT_all_flags+")"; *)
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_prefix+"all_flags")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+"_all"+k_png_ext)

var $vC_languages_all : Collection
var $vT_all : Text
$vC_languages_all:=$vC_at_languages.filter(Formula:C1597($1.value#$2); $vT_language_source)
$vT_all:=Uppercase:C13($vC_languages_all.join(", "))
APPEND MENU ITEM:C411($vT_refMenu_answer; "ALL ("+$vT_all+")"; *)
SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_prefix+"all")
SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+"_all"+k_png_ext)

APPEND MENU ITEM:C411($vT_refMenu_answer; "-")

var $vT_icon; $vT_item_parameter : Text
var $idx : Integer
var $vT_code : Text
$idx:=0
var $vT_language : Text
For each ($vT_code; $vC_languages_all)
	var $idx_code : Integer
	$idx_code:=$vC_languages_short.indexOf($vT_code)
	$vT_language:=$idx_code>=0 ? $vC_languages_lbl[$idx_code]+" ("+Uppercase:C13($vT_code)+")" : Uppercase:C13($vT_code)
	If ($vT_language_source#$vT_code)
		$vT_icon:=$vT_code
		$vT_item_parameter:=$vT_prefix+$vT_code
		APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_language; *)
		SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_item_parameter)
		SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_icon+k_png_ext)
	End if 
	$idx+=1
End for each 

If ($is_toAttach)
	APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_answer; *)
	RELEASE MENU:C978($vT_refMenu_answer)
	SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+"infos"+k_png_ext)
End if 
