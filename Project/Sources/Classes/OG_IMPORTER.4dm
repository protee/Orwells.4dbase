
Class constructor($vT_LB : Text)
	//wox_prefs_windows_load()
	This:C1470._initialize()
	// *
	// *****
	
	
	// *****
	// *
Function form_events($vL_event_code : Integer)
	var $isOk : Boolean
	var $vJ_formEvent; $vJ_table : Object
	var $vT_objectName; $vT_table : Text
	
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			//wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					
				: ($vT_objectName="btn_import")
					$isOk:=This:C1470._do_it_import()
					
				: ($vT_objectName="btn_relate")
					$isOk:=This:C1470._do_it_relate()
					
				: ($vT_objectName="btn_clean")
					$isOk:=This:C1470._do_it_clean()
					
					
				: ($vT_objectName="btn_orwells")
					$isOk:=This:C1470._do_it_ORWELLS()
					
					
					
			End case 
			
		: ($vL_event_code=On Double Clicked:K2:5)
			Case of 
				: ($vT_objectName="LB")
					$vJ_table:=Form:C1466.lb_current
					$vT_table:=$vJ_table.t_table
					zen_table_open($vT_table)
			End case 
	End case 
	// *
	// *****
	
	
	// *****
	// *
Function _initialize()
	var $vJ_key_toTable : Object
	var $vC_at_meta_fields; $vC_al_meta_fields : Collection
	$vJ_key_toTable:=New object:C1471()
	$vJ_key_toTable.category:="CATEGORIES"
	//$vJ_key_toTable.picture:="PICTURES"
	//$vJ_key_toTable.bank:="BANKS"
	//$vJ_key_toTable.pack:="PACKS"
	//$vJ_key_toTable.parent:="TYPES_R"
	//$vJ_key_toTable.type:="TYPES_R"
	//$vJ_key_toTable.product:="PRODUCTS"
	//$vJ_key_toTable.Pcols:="TEMPLATES"
	Form:C1466.j_key_toTable:=$vJ_key_toTable
	
	//$vJ_this:=This
	//$vJ_tables_options:=New object()
	//Form.j_tables_options:=$vJ_tables_options
	//$vJ_table_options:=New object()
	//$vJ_tables_options.CATEGORIES:=$vJ_table_options
	//$vJ_table_options.t_file:="CATEGORIES"
	
	//$vJ_table_options:=New object()
	//$vJ_tables_options.TYPES_R:=$vJ_table_options
	//$vJ_table_options.t_file:="PRODUCTS_TYPES"
	//$vJ_table_options:=New object()
	//$vJ_tables_options.PATHS:=$vJ_table_options
	//$vJ_table_options.t_file:="PRODUCTS_PACKS"
	//$vJ_table_options:=New object()
	//$vJ_tables_options.PACKS:=$vJ_table_options
	//$vJ_table_options.fu_record:=Formula($vJ_this.packs_record($1))
	//$vJ_table_options:=New object()
	//$vJ_tables_options.BANKS:=$vJ_table_options
	//$vJ_table_options.fu_record:=Formula($vJ_this.banks_record($1))
	
	//$vJ_table_options:=New object()
	//$vJ_tables_options.SETS:=$vJ_table_options
	//$vJ_table_options.t_file:="BANKS_SETS"
	//$vJ_table_options.fu_record:=Formula($vJ_this.sets_record($1))
	
	//$vJ_table_options:=New object()
	//$vJ_tables_options.TEMPLATES:=$vJ_table_options
	//$vJ_table_options.t_file:="BUTTONS_TEMPLATES"
	//$vJ_table_options.fu_record:=Formula($vJ_this.templates_record($1))
	
	//$vJ_table_options:=New object()
	//$vJ_tables_options.MEDIA:=$vJ_table_options
	//$vJ_table_options.t_file:="BANKS_BUTTONS"
	//$vJ_table_options.fu_record:=Formula($vJ_this.media_record($1))
	
	// ****
	$vC_at_meta_fields:=New collection:C1472()
	$vC_at_meta_fields.push("ID"; "Cuser"; "Cdate"; "Ctime"; "Muser"; "Mdate"; "Mtime")
	Form:C1466.at_meta_fields:=$vC_at_meta_fields
	$vC_al_meta_fields:=New collection:C1472()
	$vC_al_meta_fields.push(Is longint:K8:6; Is alpha field:K8:1; Is date:K8:7; Is time:K8:8; Is alpha field:K8:1; Is date:K8:7; Is time:K8:8)
	Form:C1466.al_meta_fields:=$vC_al_meta_fields
	
	This:C1470.lb_load()
	// *
	// *****
	
	
	// *****
	// *
Function lb_load()
	var $is_local : Boolean
	var $vC_aj_TablesClass; $vC_tables; $vC_aj_tables : Collection
	var $idx; $vL_count_local; $vL_module : Integer
	var $vJ_prefs; $vJ_module; $vJ_tableClass; $vJ_table : Object
	var $vT_module : Text
	$vJ_prefs:=zen__storage_prefs
	$vC_aj_TablesClass:=$vJ_prefs.aj_TablesClass
	$vC_tables:=New collection:C1472()
	$idx:=0
	For each ($vJ_module; $vC_aj_TablesClass)
		$is_local:=$idx>=$vL_count_local
		$vT_module:=$vJ_module.t_label
		$vL_module:=This:C1470._colors_module($vJ_module.l_colors)
		$vC_aj_tables:=$vJ_module.aj_tables
		For each ($vJ_tableClass; $vC_aj_tables)
			$vJ_table:=New object:C1471()
			$vC_tables.push($vJ_table)
			$vJ_table.t_module:=$vT_module
			$vJ_table.l_colors_module:=$vL_module
			$vJ_table.t_table:=$vJ_tableClass.t_table
			$vJ_table.l_colors_table:=$vJ_tableClass.l_colors_table
		End for each 
		$idx+=1
	End for each 
	
	//$vJ_table:=New object()
	//$vC_tables.push($vJ_table)
	//$vJ_table.t_module:="ZEN"
	//$vJ_table.l_colors_module:=0
	//$vJ_table.t_table:="TYPES_R"
	//$vJ_table.l_colors_table:=0
	
	Form:C1466.lb_selection:=$vC_tables
	
Function _colors_module($vL_colors : Integer)->$vL_colors_out : Integer
	var $vL_color_stroke; $vL_color_fill : Integer
	woc_sp_colors_to_sf($vL_colors; ->$vL_color_stroke; ->$vL_color_fill)
	$vL_color_stroke:=woc_sp_color_s_for_f($vL_color_fill)
	$vL_colors_out:=woc_sp_colors_from_sf($vL_color_stroke; $vL_color_fill)
	
	
Function lb_meta_info($vJ_table : Object)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	$vJ_meta:=New object:C1471
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	
	$vL_colors:=$vJ_table.l_colors_module
	This:C1470.meta_cell_colors($vJ_meta_cell; "lb_module"; $vL_colors)
	$vL_colors:=$vJ_table.l_colors_table
	This:C1470.meta_cell_colors($vJ_meta_cell; "lb_table"; $vL_colors)
	
	
	
Function meta_cell_colors($vJ_meta_cell : Object; $vT_column : Text; $vL_colors : Integer)
	var $vJ_meta_cell_values : Object
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_meta_cell_values:=New object:C1471
	$vJ_meta_cell[$vT_column]:=$vJ_meta_cell_values  // Issue => give the column name that can change
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta_cell_values.stroke:=$vT_color_stroke
	$vJ_meta_cell_values.fill:=$vT_color_fill
	// *
	// *****
	
	
	
	// ***** DO Import, Relate, Clean => All in 3 steps to avoid order for table's import
	// *
Function _get_lb_selected()->$vC_lb_selected : Collection
	$vC_lb_selected:=Form:C1466.lb_selected
	$vC_lb_selected:=$vC_lb_selected.length#0 ? $vC_lb_selected : Form:C1466.lb_selection
	
	
Function _get_exports_folder()->$c4Fo_answer : 4D:C1709.Folder
	var $c4Fo_export : 4D:C1709.Folder
	$c4Fo_export:=Folder:C1567(fk data folder:K87:12).folder("Exports")
	If ($c4Fo_export.exists)
		$c4Fo_answer:=$c4Fo_export
	Else 
		waz_io_alert("No folder!")
	End if 
	
	
Function _do_it_import()->$isOk : Boolean
	var $c4Fo_export : 4D:C1709.Folder
	var $vC_lb_selected : Collection
	var $tt : Integer
	var $vT_table : Text
	var $vJ_table : Object
	$c4Fo_export:=This:C1470._get_exports_folder()
	If ($c4Fo_export#Null:C1517)
		$vC_lb_selected:=This:C1470._get_lb_selected()
		$tt:=$vC_lb_selected.length
		$isOk:=waz_io_confirm_popup("Tables found: "+String:C10($tt))
		If ($isOk)
			For each ($vJ_table; $vC_lb_selected)
				$vT_table:=$vJ_table.t_table
				This:C1470.import_table($c4Fo_export; $vT_table)
			End for each 
		End if 
	End if 
	
Function _do_it_relate()->$isOk : Boolean
	var $vC_lb_selected : Collection
	var $tt : Integer
	var $vT_table : Text
	var $vJ_table : Object
	$vC_lb_selected:=This:C1470._get_lb_selected()
	$tt:=$vC_lb_selected.length
	$isOk:=waz_io_confirm_popup("Tables found: "+String:C10($tt))
	If ($isOk)
		For each ($vJ_table; $vC_lb_selected)
			$vT_table:=$vJ_table.t_table
			This:C1470.relate_table($vT_table)
		End for each 
	End if 
	
	
Function _do_it_clean()->$isOk : Boolean
	var $vC_lb_selected : Collection
	var $tt : Integer
	var $vT_table : Text
	var $vJ_table : Object
	$vC_lb_selected:=This:C1470._get_lb_selected()
	$tt:=$vC_lb_selected.length
	$isOk:=waz_io_confirm_popup("Tables found: "+String:C10($tt))
	If ($isOk)
		For each ($vJ_table; $vC_lb_selected)
			$vT_table:=$vJ_table.t_table
			This:C1470.clean_table($vT_table)
		End for each 
	End if 
	// *
	// *****
	
	
	// ***** SPECIFICS
	// *
Function _do_it_ORWELLS()->$isOk : Boolean
	var $c4Fo_export : 4D:C1709.Folder
	var $c4DC : 4D:C1709.DataClass
	var $c4E_entity : 4D:C1709.Entity
	var $c4ES_entities : 4D:C1709.EntitySelection
	var $c4Fi_table : 4D:C1709.File
	var $isStopProgress : Boolean
	var $vC_records : Collection
	var $vL_tt; $vL_records : Integer
	var $vJ_record; $vJ_meta : Object
	var $vT_table; $vT_file; $vT_progress_uid; $vT_yangTongue; $vT_yinTongue : Text
	$c4Fo_export:=This:C1470._get_exports_folder()
	If ($c4Fo_export#Null:C1517)
		$vT_table:="ORWELLS"
		$vT_file:=$vT_table
		$c4DC:=ds:C1482[$vT_table]
		$vT_progress_uid:=waz_progress_new($vT_table)
		waz_progress_setButton($vT_progress_uid; "stop")
		$isStopProgress:=False:C215
		waz_progress_subtitle($vT_progress_uid; "Import meta…")
		
		$c4Fi_table:=$c4Fo_export.file($vT_file+".json")
		$vT_file:=$c4Fi_table.getText("UTF-8")
		$vC_records:=JSON Parse:C1218($vT_file)
		
		$vL_tt:=$vC_records.length
		$vL_records:=0
		For each ($vJ_record; $vC_records)
			waz_progress_setCounts($vT_progress_uid; $vL_records; $vL_tt)
			
			//$c4E_entity:=zen_entity_new($c4DC)
			$vT_yinTongue:=$vJ_record.truthTongue
			$vT_yangTongue:=$vJ_record.woodTongue
			$c4ES_entities:=$c4DC.query("yinTongue = :1 AND yangTongue = :2"; $vT_yinTongue; $vT_yangTongue)
			$c4E_entity:=$c4ES_entities.first()
			If ($c4E_entity#Null:C1517)
				$vJ_meta:=This:C1470.meta_create($c4E_entity; $vJ_record)
				zen_entity_save($c4E_entity)
			End if 
			$isStopProgress:=waz_progress_isStopped($vT_progress_uid)
			If ($isStopProgress)
				break
			End if 
			$vL_records+=1
		End for each 
		waz_progress_quit($vT_progress_uid)
	End if 
	
	
	//Function _do_it_PACKS_COLORS()->$isOk : Boolean
	//var $c4Fo_export : 4D.Folder
	//var $vJ_table_options; $vJ_this : Object
	//$c4Fo_export:=This._get_exports_folder()
	//If ($c4Fo_export#Null)
	//$vJ_table_options:=New object()
	//$vJ_table_options.t_file:="PACKS_COLORS"
	//$vJ_this:=This
	//$vJ_table_options.fu_record:=Formula($vJ_this.packs_colors_record($1))
	//$vJ_table_options.is_keep:=True
	//This.import_table($c4Fo_export; "TEMPLATES"; $vJ_table_options)
	//End if 
	// *
	// *****
	
	
	// *****
	// *
Function packs_record($vJ_record : Object)
	$vJ_record.isActive:=$vJ_record.isFavorite
	$vJ_record.infos:=$vJ_record.Infos
	OB REMOVE:C1226($vJ_record; "isFavorite")
	OB REMOVE:C1226($vJ_record; "Infos")
	
	
	// *
	// *****
	
	
	// *****
	// *
Function import_table($c4Fo_export : 4D:C1709.Folder; $vT_table : Text; $vJ_table_options : Object)
	var $c4E_entity : 4D:C1709.Entity
	var $c4ES_toDelete; $c4ES_notDeleted : 4D:C1709.EntitySelection
	var $c4Fi_table : 4D:C1709.File
	var $vX_value : Blob
	var $is_keep; $isStopProgress : Boolean
	var $vC_aj_fields; $vC_records; $vC_property : Collection
	var $vL_table; $vL_tt; $vL_field_type : Integer
	var $vL_records : Integer
	var $vO_value : Picture
	var $vT_progress_uid; $vT_pict_folder; $vT_blob_folder; $vT_WParea_folder; $vT_field_value; $vT_field_name : Text
	var $vT_property; $vT_file : Text
	var $vJ_field; $vJ_record; $vJ_meta; $vJ_tables_options : Object
	var $c4DC : 4D:C1709.DataClass
	var $c4Fu_record : 4D:C1709.Function
	
	If ($vJ_table_options=Null:C1517)
		$vJ_tables_options:=Form:C1466.j_tables_options
		$vJ_table_options:=$vJ_tables_options[$vT_table]
	End if 
	If ($vJ_table_options#Null:C1517)
		$vT_file:=$vJ_table_options.t_file
		$c4Fu_record:=$vJ_table_options.fu_record
		$is_keep:=$vJ_table_options.is_keep
	End if 
	$vT_file:=$vT_file#"" ? $vT_file : $vT_table
	
	$vL_table:=zen_get_tableNumber($vT_table)
	$c4DC:=ds:C1482[$vT_table]
	
	$vT_progress_uid:=waz_progress_new($vT_table)
	waz_progress_setButton($vT_progress_uid; "stop")
	$isStopProgress:=False:C215
	
	If (Not:C34($is_keep))
		waz_progress_subtitle($vT_progress_uid; $vT_table+" drop…")
		$c4ES_toDelete:=ds:C1482[$vT_table].all()
		$c4ES_notDeleted:=$c4ES_toDelete.drop(dk stop dropping on first error:K85:26)
	End if 
	
	waz_progress_subtitle($vT_progress_uid; "Import…")
	
	$c4Fi_table:=$c4Fo_export.file($vT_file+".json")
	$vT_file:=$c4Fi_table.getText("UTF-8")
	$vC_records:=JSON Parse:C1218($vT_file)
	
	$vT_pict_folder:="pictures"
	$vT_blob_folder:="blobs"
	$vT_WParea_folder:="WParea"
	
	$vC_aj_fields:=This:C1470.get_aj_fields($vL_table)
	
	$vL_tt:=$vC_records.length
	$vL_records:=0
	For each ($vJ_record; $vC_records)
		waz_progress_setCounts($vT_progress_uid; $vL_records; $vL_tt)
		
		If ($c4Fu_record#Null:C1517)
			$c4Fu_record.call(Null:C1517; $vJ_record)
		End if 
		
		$c4E_entity:=zen_entity_new($c4DC)
		$vJ_meta:=This:C1470.meta_create($c4E_entity; $vJ_record)
		
		//wox_vJ_overload($vJ_record; $c4E_entity)
		For each ($vT_property; $vJ_record)
			$vC_property:=$vC_aj_fields.query("t_name = :1"; $vT_property)
			If ($vC_property.length>0)
				$vJ_field:=$vC_property[0]
				
				$vT_field_name:=$vT_property
				$vL_field_type:=$vJ_field.l_type
				Case of 
					: ($vL_field_type=Is text:K8:3)
						// 254 þ 253 ý
						$vT_field_value:=$vJ_record[$vT_property]
						$vT_field_value:=Replace string:C233($vT_field_value; Char:C90(254); Char:C90(Carriage return:K15:38); *)
						$vT_field_value:=Replace string:C233($vT_field_value; Char:C90(253); Char:C90(Tab:K15:37); *)
						$c4E_entity[$vT_property]:=$vT_field_value
						
					: ($vL_field_type=Is picture:K8:10)
						$vT_field_value:=$vJ_record[$vT_property]
						If ($vT_field_value#"")
							READ PICTURE FILE:C678($c4Fo_export.file($vT_pict_folder+"/"+$vT_field_value).platformPath; $vO_value)
							$c4E_entity[$vT_property]:=$vO_value
						End if 
						
					: ($vL_field_type=Is BLOB:K8:12)
						$vT_field_value:=$vJ_record[$vT_property]
						If ($vT_field_value#"")
							DOCUMENT TO BLOB:C525($c4Fo_export.file($vT_blob_folder+"/"+$vT_field_value).platformPath; $vX_value)
							$c4E_entity[$vT_property]:=$vX_value
						End if 
						
					: ($vL_field_type=Is object:K8:27)
						//$vT_field_value:=$vJ_record[$vT_property]
						//If ($vT_field_name="WParea")
						//If ($vT_field_value#"")
						//$c4E_entity[$vT_property]:=WP Import document($c4Fo_export.file($vT_WParea_folder+"/"+$vT_field_value+".4wp").platformPath)
						//End if 
						//Else 
						$c4E_entity[$vT_property]:=$vJ_record[$vT_property]
						//End if 
					Else 
						$c4E_entity[$vT_property]:=$vJ_record[$vT_property]
				End case 
			End if 
		End for each 
		zen_entity_save($c4E_entity)
		$isStopProgress:=waz_progress_isStopped($vT_progress_uid)
		If ($isStopProgress)
			break
		End if 
		$vL_records+=1
	End for each 
	waz_progress_quit($vT_progress_uid)
	// *
	// *****
	
	
	// *****
	// *
Function meta_create($c4E_entity : 4D:C1709.Entity; $vJ_record : Object)->$vJ_meta : Object
	var $vC_values : Collection
	var $vT_field : Text
	var $vJ_value : Object
	$vJ_meta:=New object:C1471()
	$c4E_entity.meta:=$vJ_meta
	$vJ_meta.ID:=$vJ_record.ID
	$vJ_meta.createdUser:=$vJ_record.Cuser
	$vJ_meta.createdDate:=waz_utc_from_date_time($vJ_record.Cdate; $vJ_record.Ctime)
	$vJ_meta.updatedUser:=$vJ_record.Muser
	$vJ_meta.updatedDate:=waz_utc_from_date_time($vJ_record.Mdate; $vJ_record.Mtime)
	//$vC_at_meta_fields:=This.get_at_meta_fields()
	//For each ($vT_property; $vC_at_meta_fields)
	//OB REMOVE($vJ_record; $vT_property)
	//End for each 
	
	// integrate all key_@ in meta
	// And remove in vJ_records
	$vC_values:=OB Entries:C1720($vJ_record)
	For each ($vJ_value; $vC_values)
		$vT_field:=$vJ_value.key
		Case of 
			: ($vT_field="key_@")
				$vJ_meta[$vT_field]:=$vJ_record[$vT_field]
				//OB REMOVE($vJ_record; $vT_field)
				
			: ($vT_field="ID_@")  // For tables fusion, to get other ID than main table (ie PACKS_COLORS)
				$vJ_meta[$vT_field]:=$vJ_record[$vT_field]
				//OB REMOVE($vJ_record; $vT_field)
				
		End case 
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function get_aj_fields($vL_table : Integer)->$vC_aj_fields : Collection
	var $is_index; $is_unique; $is_invisible : Boolean
	var $vL_nb_fields; $vL_no_field; $vL_field_type; $vL_field_lenght; $idx : Integer
	var $vJ_field : Object
	$vL_nb_fields:=Get last field number:C255($vL_table)
	$vC_aj_fields:=New collection:C1472()
	$idx:=0
	For ($vL_no_field; 1; $vL_nb_fields)
		If (Is field number valid:C1000($vL_table; $vL_no_field))
			GET FIELD PROPERTIES:C258($vL_table; $vL_no_field; $vL_field_type; $vL_field_lenght; $is_index; $is_unique; $is_invisible)
			If (Not:C34($is_invisible)) & ($vL_field_type#7)  //Visible et non sous-tables
				$vJ_field:=New object:C1471()
				$vC_aj_fields.push($vJ_field)
				$vJ_field.t_name:=Field name:C257($vL_table; $vL_no_field)
				$vJ_field.l_type:=$vL_field_type
				$vJ_field.l_idx:=$idx
				$idx+=1
			End if 
		End if 
	End for 
	// *
	// *****
	
	
	// *****
	// *
Function relate_table($vT_table : Text)
	// Relate ID to UID
	var $c4E_entity : 4D:C1709.Entity
	var $c4ES_table : 4D:C1709.EntitySelection
	var $isStopProgress : Boolean
	var $tt; $vL_count; $vL_tt : Integer
	var $vT_progress_uid : Text
	$c4ES_table:=ds:C1482[$vT_table].all()
	$vT_progress_uid:=waz_progress_new($vT_table)
	waz_progress_setButton($vT_progress_uid; "stop")
	$isStopProgress:=False:C215
	waz_progress_subtitle($vT_progress_uid; "Relate…")
	$tt:=$c4ES_table.length
	$vL_count:=0
	For each ($c4E_entity; $c4ES_table)
		waz_progress_setCounts($vT_progress_uid; $vL_count; $vL_tt)
		This:C1470.key_links_affect($c4E_entity)
		zen_entity_save($c4E_entity)
		$vL_count+=1
		$isStopProgress:=waz_progress_isStopped($vT_progress_uid)
		If ($isStopProgress)
			break
		End if 
	End for each 
	waz_progress_quit($vT_progress_uid)
	
	
Function key_links_affect($c4E_entity : 4D:C1709.Entity)
	// key_xxx
	var $c4E_linked : 4D:C1709.Entity
	var $vC_values : Collection
	var $vL_ID : Integer
	var $vJ_key_toTable; $vJ_value; $vJ_meta : Object
	var $vT_field; $vT_key; $vT_table_linked; $vT_UIDtable; $vT_meta_ID : Text
	$vJ_key_toTable:=Form:C1466.j_key_toTable
	$vJ_meta:=$c4E_entity.meta
	$vC_values:=OB Entries:C1720($vJ_meta)
	For each ($vJ_value; $vC_values)
		$vT_field:=$vJ_value.key
		If ($vT_field="key_@")
			$vT_key:=Substring:C12($vT_field; 5)
			$vL_ID:=$vJ_meta[$vT_field]
			If ($vL_ID#0)
				$vT_meta_ID:="ID"  // Regular
				$vT_table_linked:=$vJ_key_toTable[$vT_key]
				// Exception for PACKS_COLORS -> Pcols
				If ($vT_key="Pcols")
					$vT_meta_ID+="_"+$vT_key
					$vT_key:="template"
				End if 
				$c4E_linked:=ds:C1482[$vT_table_linked].query("meta."+$vT_meta_ID+" = :1"; $vL_ID).first()
				$vT_UIDtable:=$c4E_linked#Null:C1517 ? $c4E_linked.UID : ""
				$c4E_entity["UID"+$vT_key]:=$vT_UIDtable
			End if 
			//OB REMOVE($vJ_meta; $vT_field)
		End if 
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function clean_table($vT_table : Text)
	// Relate ID to UID
	var $c4E_entity : 4D:C1709.Entity
	var $c4ES_table : 4D:C1709.EntitySelection
	var $isStopProgress : Boolean
	var $tt; $vL_count; $vL_tt : Integer
	var $vT_progress_uid : Text
	$c4ES_table:=ds:C1482[$vT_table].all()
	$vT_progress_uid:=waz_progress_new($vT_table)
	waz_progress_setButton($vT_progress_uid; "stop")
	$isStopProgress:=False:C215
	waz_progress_subtitle($vT_progress_uid; "Relate…")
	$tt:=$c4ES_table.length
	$vL_count:=0
	For each ($c4E_entity; $c4ES_table)
		waz_progress_setCounts($vT_progress_uid; $vL_count; $vL_tt)
		This:C1470.key_links_clean($c4E_entity)
		zen_entity_save($c4E_entity)
		$vL_count+=1
		$isStopProgress:=waz_progress_isStopped($vT_progress_uid)
		If ($isStopProgress)
			break
		End if 
	End for each 
	waz_progress_quit($vT_progress_uid)
	
	
Function key_links_clean($c4E_entity : 4D:C1709.Entity)
	// key_xxx
	var $vC_values : Collection
	var $vJ_key_toTable; $vJ_value; $vJ_meta : Object
	var $vT_field : Text
	$vJ_key_toTable:=Form:C1466.j_key_toTable
	$vJ_meta:=$c4E_entity.meta
	$vC_values:=OB Entries:C1720($vJ_meta)
	For each ($vJ_value; $vC_values)
		$vT_field:=$vJ_value.key
		If ($vT_field="key_@")
			OB REMOVE:C1226($vJ_meta; $vT_field)
		End if 
	End for each 
	// *
	// *****
	