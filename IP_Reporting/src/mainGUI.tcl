
catch {namespace delete ::antolin::reportGui}

namespace eval ::antolin::reportGui {

	set ::antolin::reportGui::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::antolin::reportGui::scriptDir utils_gui.tbc]]} {
		source [file join $::antolin::reportGui::scriptDir utils_gui.tbc];
	} else {
		source [file join $::antolin::reportGui::scriptDir utils_gui.tcl];
	}
	if {[file exists [file join $::antolin::reportGui::scriptDir qualityFeel.tbc]]} {
		source [file join $::antolin::reportGui::scriptDir qualityFeel.tbc];
	} else {
		source [file join $::antolin::reportGui::scriptDir qualityFeel.tcl];
	}	
	if {[file exists [file join $::antolin::reportGui::scriptDir captureImages.tbc]]} {
		source [file join $::antolin::reportGui::scriptDir captureImages.tbc];
	} else {
		source [file join $::antolin::reportGui::scriptDir captureImages.tcl];
	}
	if {[file exists [file join $::antolin::reportGui::scriptDir input_tableGUI.tbc]]} {
		source [file join $::antolin::reportGui::scriptDir input_tableGUI.tbc];
	} else {
		source [file join $::antolin::reportGui::scriptDir input_tableGUI.tcl];
	}
	if {[file exists [file join $::antolin::reportGui::scriptDir tpl.tbc]]} {
		source [file join $::antolin::reportGui::scriptDir tpl.tbc];
	} else {
		source [file join $::antolin::reportGui::scriptDir tpl.tcl];
	}
	
}

proc ::antolin::reportGui::mainGui {} {
	
	catch {destroy .reportMain};
	set reportMainFrm [toplevel .reportMain];
	wm geometry $reportMainFrm +300+50;
	wm title $reportMainFrm "Antolin - Report Automation (IP)";
	wm maxsize  $reportMainFrm 900 900;
	wm minsize  $reportMainFrm 900 900;
	wm transient .reportMain .
	
	#---------------------------Supplier, Work order, Unit system----------------------------------
	set mainFrm1 [hwtk::frame $reportMainFrm.mainFrm1 ];
	pack $mainFrm1 -side top -pady 4 -padx 4 -anchor nw;
	
	set labelFrm1 [hwtk::labelframe $mainFrm1.labelFrm1 -text "Select" -labelanchor nw -padding 4];
	pack $labelFrm1 -side left -fill both -expand true -padx 10 -pady 4 -anchor nw;
	
	#solver
	set solverType_labelFrm [hwtk::label $labelFrm1.solverType_labelFrm -text "Solver Type" -width 12 ];
	pack $solverType_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set ::antolin::reportGui::solverTypeList [list "LsDyna" "Abaqus" "PamCrash" "Radioss" "Optistruct"];
	set ::antolin::reportGui::str_solverType [lindex $::antolin::reportGui::solverTypeList 0];
	set solverType_entryFrm [hwtk::editablecombobox $labelFrm1.solverType_entryFrm -state readonly -values $::antolin::reportGui::solverTypeList \
					 -default $::antolin::reportGui::str_solverType -textvariable ::antolin::reportGui::str_solverType -width 10 \
					 -selcommand ::antolin::reportGui::callBackSolverType];
	pack $solverType_entryFrm -side left -pady 4 -padx 8;
	
	#load case
	set loadCase_labelFrm [hwtk::label $labelFrm1.loadCase_labelFrm -text "Load Case" -width 10 ];
	pack $loadCase_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	set ::antolin::reportGui::loadcaseList [list "Static loadcases" "Crash loadcases" ];
	set ::antolin::reportGui::str_loadcase [lindex $::antolin::reportGui::loadcaseList 0];
	set loadcase_entryFrm [hwtk::editablecombobox $labelFrm1.loadcase_entryFrm -state readonly -values $::antolin::reportGui::loadcaseList \
					 -default $::antolin::reportGui::str_loadcase -textvariable ::antolin::reportGui::str_loadcase -width 14 \
					 -selcommand ::antolin::reportGui::callBackLoadcase];
	pack $loadcase_entryFrm -side left -pady 4 -padx 8;
	
	if {$::antolin::reportGui::str_loadcase == "Static loadcases"} {
		set ::antolin::reportGui::sub_loadcaseList [list "Quality feel" "Static stiffness" "Abuse loadcase"];
		set ::antolin::reportGui::str_subloadcase [lindex $::antolin::reportGui::sub_loadcaseList 0];
	}
	variable subloadcase_entryFrm
	set subloadcase_entryFrm [hwtk::editablecombobox $labelFrm1.subloadcase_entryFrm -state readonly -values $::antolin::reportGui::sub_loadcaseList \
					 -default $::antolin::reportGui::str_subloadcase -textvariable ::antolin::reportGui::str_subloadcase -width 14\
					 -selcommand ::antolin::reportGui::callBackSubloadcase];
	pack $subloadcase_entryFrm -side left -pady 4 -padx 8;
	
	#units 	
	set unit_labelFrm [hwtk::label $labelFrm1.unit_labelFrm -text "Unit System" -width 10];
	pack $unit_labelFrm -side left -pady 4 -padx 4 -anchor nw;
		
	set ::antolin::reportGui::unitList [list "TON_mm_S_N_Mpa" "KG_mm_MS_KN_GPa" "KG_mm_S_Mn_KPa" "G_mm_s_MN_Pa" "G_mm_MS_N_Mpa"];
	set ::antolin::reportGui::selectedUnit [lindex $::antolin::reportGui::unitList 0];
	set unitFrm [hwtk::editablecombobox $labelFrm1.unitFrm -state readonly -values $::antolin::reportGui::unitList \
					 -default $::antolin::reportGui::selectedUnit -textvariable ::antolin::reportGui::selectedUnit -width 18];
	pack $unitFrm -side left -pady 4 -padx 8;
	
	#---------------------------------Animation, Data file-------------------------------------------------------------
	set mainFrm2 [hwtk::frame $reportMainFrm.mainFrm2 ];
	pack $mainFrm2 -side top -pady 4 -padx 4 -anchor nw;
	
	set labelFrm2 [hwtk::labelframe $mainFrm2.labelFrm2 -text "Select Results" -labelanchor nw -padding 4];
	pack $labelFrm2 -side left -fill both -expand true -padx 10 -pady 4 -anchor nw;
		
	set anim_filter [lindex [::antolin::gui_utils::getFilters $::antolin::reportGui::str_solverType] 1];
	
	set sub_Frm1 [hwtk::frame $labelFrm2.sub_Frm1 ];
	pack $sub_Frm1 -side top -pady 4 -padx 4 -anchor nw;
	
	set anim_labelFrm [hwtk::label $sub_Frm1.anim_labelFrm -text "Animation" -width 10];
	pack $anim_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	variable anim_frm
	set anim_frm [hwtk::openfileentry $sub_Frm1.anim_frm -multiple 1 -width 110 -filetypes $anim_filter\
					-textvariable ::antolin::reportGui::animationFilePath]
	pack $anim_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	#TH file
	set sub_Frm2 [hwtk::frame $labelFrm2.sub_Frm2 ];
	pack $sub_Frm2 -side top -pady 4 -padx 4 -anchor nw;
	set datafile_labelFrm [hwtk::label $sub_Frm2.datafile_labelFrm -text "Data File" -width 10];
	pack $datafile_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	set datafile_frm [hwtk::openfileentry $sub_Frm2.datafile_frm -multiple 1 -width 110\
					-textvariable ::antolin::reportGui::dataFilePath]
	pack $datafile_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	#output directory
	set sub_Frm3 [hwtk::frame $labelFrm2.sub_Frm3 ];
	pack $sub_Frm3 -side top -pady 4 -padx 4 -anchor nw;
	set outputDir_labelFrm [hwtk::label $sub_Frm3.outputDir_labelFrm -text "Output Dir." -width 10];
	pack $outputDir_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	set outputDir_frm [hwtk::choosedirentry $sub_Frm3.outputDir_frm -width 110 -textvariable ::antolin::reportGui::outputDirPath]
	pack $outputDir_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
		
	
	#---------------------------------Output directory-------------------------------------------------------------
	# set mainFrm3 [hwtk::frame $reportMainFrm.mainFrm3 ];
	# pack $mainFrm3 -side top -pady 4 -padx 4 -anchor nw;
	
	# set outputDir_labelFrm [hwtk::label $mainFrm3.outputDir_labelFrm -text "Output Dir" -width 10];
	# pack $outputDir_labelFrm -side left -pady 4 -padx 4 -anchor nw;
		
	# set outputDir_frm [hwtk::choosedirentry $mainFrm3.outputDir_frm\
					# -textvariable ::antolin::reportGui::outputDirPath]
	# pack $outputDir_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	#--------------------------------- Input Table -------------------------------------------------------------
	set tableFrm [hwtk::frame $reportMainFrm.tableFrm ];
	pack $tableFrm -side top -pady 4 -padx 4 -anchor nw -fill both;
	::inputTable::createTable $tableFrm;
	::antolin::reportGui::callBackSubloadcase;
	
	#---------------------------------Apply - 1-------------------------------------------------------------
	set mainFrm5 [hwtk::frame $reportMainFrm.mainFrm5 ];
	pack $mainFrm5 -side top -pady 4 -padx 4 -anchor e;
	
	set apply1_frm [hwtk::button $mainFrm5.apply1_frm -text "Apply" -width 14 -command "::antolin::reportGui::executeReport"];
	pack $apply1_frm -side left -expand false -padx 10 -pady 4 -anchor nw ;
	
	set savetpl_frm [hwtk::button $mainFrm5.savetpl_frm -text "Save TPL" -width 14 -command "::tpl::save_main"];
	pack $savetpl_frm -side left -expand false -padx 10 -pady 4 -anchor nw ;
	
	
	# --------------------------------input result dir-------------------------------------------------------------
	set mainFrm6 [hwtk::frame $reportMainFrm.mainFrm6 ];
	pack $mainFrm6 -side top -pady 4 -padx 4 -anchor nw;
	
	set publish_labelFrm [hwtk::labelframe $mainFrm6.publish_labelFrm -text "Publish Report" -labelanchor nw -padding 4];
	pack $publish_labelFrm -side left -fill both -expand true -padx 10 -pady 4 -anchor nw;
	
	set inputDir_labelFrm [hwtk::label $publish_labelFrm.inputDir_labelFrm -text "Input Dir." -width 10];
	pack $inputDir_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	set inputDir_frm [hwtk::choosedirentry $publish_labelFrm.inputDir_frm -width 110 -textvariable ::antolin::reportGui::inputDirPath]
	pack $inputDir_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	
	# -----------------------Image and Publish ----------------------------------------------------------------
	set mainFrm7 [hwtk::frame $publish_labelFrm.mainFrm7 ];
	pack $mainFrm7 -side top -pady 4 -padx 4 -anchor e;
	
	set loadTPL_frm [hwtk::button $mainFrm7.loadTPL_frm -text "Load TPL" -width 14 -command "::tpl::load_main"];
	pack $loadTPL_frm -side left -expand false -padx 10 -pady 4 -anchor nw;
	
	set image_frm [hwtk::button $mainFrm7.image_frm -text "Images" -width 14 -command "::antolin::reportGui::captureImages"];
	pack $image_frm -side left -expand false -padx 10 -pady 4 -anchor nw;
	
	set publish_frm [hwtk::button $mainFrm7.publish_frm -text "Publish" -width 14 -command "::antolin::reportGui::publishReport"];
	pack $publish_frm -side left -expand false -padx 10 -pady 4 -anchor nw;
	
}


proc ::antolin::reportGui::callBackSolverType {} {

	variable anim_frm;
	set anim_filter [lindex [::antolin::gui_utils::getFilters $::antolin::reportGui::str_solverType] 1];
	$anim_frm config -filetypes $anim_filter
}

proc ::antolin::reportGui::callBackLoadcase {} {
	
	variable subloadcase_entryFrm;
	
	if {$::antolin::reportGui::str_loadcase == "Static loadcases"} {
		set ::antolin::reportGui::sub_loadcaseList [list "Quality feel" "Static stiffness" "Abuse loadcase"];
		set ::antolin::reportGui::str_subloadcase [lindex $::antolin::reportGui::sub_loadcaseList 0];
	}
	
	if {$::antolin::reportGui::str_loadcase == "Crash loadcases"} {
		set ::antolin::reportGui::sub_loadcaseList [list "Head impact" "Knee impact" "Pulse simulation"];
		set ::antolin::reportGui::str_subloadcase [lindex $::antolin::reportGui::sub_loadcaseList 0];
	}
	
	$subloadcase_entryFrm config -values [set ::antolin::reportGui::sub_loadcaseList];
	
	
	#this is temp condistion 
	if {[set ::antolin::reportGui::str_loadcase] != "Static loadcases" && [set ::antolin::reportGui::str_subloadcase] != "Quality feel"} {
		# delete rows 
		::inputTable::deleteTable;
	} else {
		::antolin::reportGui::callBackSubloadcase;
	}	
}

proc ::antolin::reportGui::callBackSubloadcase {} {

	if {[set ::antolin::reportGui::str_loadcase] == "Static loadcases" && [set ::antolin::reportGui::str_subloadcase] == "Quality feel"} {
		
		set inputCsv [file join $::antolin::reportGui::scriptDir input_csv Quality_Feel.csv];
		::inputTable::ReadInputCSV $inputCsv;
		::inputTable::Populate;
	} else {
		# delete rows 
		::inputTable::deleteTable;
	}
}


proc ::antolin::reportGui::executeReport {} {
		
	if {![info exists ::antolin::reportGui::animationFilePath] || $::antolin::reportGui::animationFilePath == ""} {
		tk_messageBox -message "Kindly select valid result file" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::animationFilePath]} {
		tk_messageBox -message "Kindly select valid result file" -icon error;
		return
	}
	
	if {![info exists ::antolin::reportGui::dataFilePath] || $::antolin::reportGui::dataFilePath == ""} {
		tk_messageBox -message "Kindly select valid TH file" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::dataFilePath]} {
		tk_messageBox -message "Kindly select valid TH file" -icon error;
		return
	}
	
	if {![info exists ::antolin::reportGui::outputDirPath] || $::antolin::reportGui::outputDirPath == ""} {
		tk_messageBox -message "Kindly select valid output directory" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::outputDirPath]} {
		tk_messageBox -message "Kindly select valid output directory" -icon error;
		return
	}
	
	#write output dir path to temp file.  it is required for python script
	set user_home $::env(HOME)
	set user_home_txt [file join $user_home reportAutomation.txt];
	set fo [open $user_home_txt w];
	puts $fo $::antolin::reportGui::outputDirPath;
	close $fo;
	
	#copy template to output directory
	set ppt_template [file join $::antolin::reportGui::scriptDir "reporting" "template.pptx"];
	catch {file copy -force $ppt_template $::antolin::reportGui::outputDirPath}
	
	if {[set ::antolin::reportGui::str_loadcase] == "Static loadcases" && [set ::antolin::reportGui::str_subloadcase] == "Quality feel"} {
		
		::inputTable::GetValue;
		
		#set hv_dataType "Displacement"
		set hv_dataType [set ::inputTable::arr_tableValues(HyperView_DataType)];
		#set hv_dataComp "Mag"
		set hv_dataComp [set ::inputTable::arr_tableValues(HyperView_DataComponent)];
		set hv_resultType "scalar"

		#set Xsubcase "nodout";
		set Xsubcase [set ::inputTable::arr_tableValues(HyperGraph_X-subcase)];
		#set XDataType "nodout"
		set XDataType [set ::inputTable::arr_tableValues(HyperGraph_X-DataType)];
		#set XRequest "1000000";
		set XRequest [set ::inputTable::arr_tableValues(HyperGraph_X-Request)];
		#set XComponent "resultant_displacement";
		set XComponent [set ::inputTable::arr_tableValues(HyperGraph_X-Component)];
		#set Ysubcase "rcforc";
		set Ysubcase [set ::inputTable::arr_tableValues(HyperGraph_Y-subcase)];
		#set YDataType "rcforc";
		set YDataType [set ::inputTable::arr_tableValues(HyperGraph_Y-DataType)];
		#set YRequest "110_IMPACTOR_TO_DT-Slave";
		set YRequest [set ::inputTable::arr_tableValues(HyperGraph_Y-Request)];
		#set YComponent "resultant_force";
		set YComponent [set ::inputTable::arr_tableValues(HyperGraph_Y-Component)];
		#set x_axesLabel "Displacement"
		set x_axesLabel [set ::inputTable::arr_tableValues(HyperGraph_x_axesLabel)];
		#set y_axesLabel "Force"
		set y_axesLabel [set ::inputTable::arr_tableValues(HyperGraph_y_axesLabel)];
		#set curveLabel "Force Vs Displacement"
		set curveLabel [set ::inputTable::arr_tableValues(HyperGraph_curveLabel)];
		#set ver_datumTarget 0.5;
		set ver_datumTarget [set ::inputTable::arr_tableValues(HyperGraph_ver_datumTarget)];
		#set sectionNodeId 1000000;
		set sectionNodeId [set ::inputTable::arr_tableValues(HyperView_sectionNodeId)];
		#set sectionAxes "xaxis"
		set sectionAxes [set ::inputTable::arr_tableValues(HyperView_sectionAxes)];
		#set sectionName "qualityFeel"
		set sectionName [set ::inputTable::arr_tableValues(HyperView_sectionName)];

		::qualityFeel::main $::antolin::reportGui::animationFilePath $::antolin::reportGui::animationFilePath $::antolin::reportGui::dataFilePath \
							$hv_dataType $hv_dataComp $hv_resultType $Xsubcase $XDataType $XRequest $XComponent $Ysubcase $YDataType $YRequest \
							$YComponent $x_axesLabel $y_axesLabel $curveLabel $ver_datumTarget $sectionNodeId $sectionAxes $sectionName;
							
	}
}

proc ::antolin::reportGui::captureImages { } {

	if {![info exists ::antolin::reportGui::outputDirPath]} {
		tk_messageBox -message  "Select output directory" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::outputDirPath]} {
		tk_messageBox -message  "Select valid output directory" -icon error;
		return
	}
		
	if {[set ::antolin::reportGui::str_loadcase] == "Static loadcases" && [set ::antolin::reportGui::str_subloadcase] == "Quality feel"} {
		
		set image_name "qualityFeel";
		set slide_Title "Quality Feel"
	}
	
	set ppt_template [file join $::antolin::reportGui::outputDirPath "template.pptx"];
	if {[info exists image_name] && [info exists slide_Title]} {
		::captureImages::Main $image_name $slide_Title $ppt_template $::antolin::reportGui::outputDirPath;
	}
}


proc ::antolin::reportGui::publishReport { } {

	if {[set ::antolin::reportGui::str_loadcase] == "Static loadcases" && [set ::antolin::reportGui::str_subloadcase] == "Quality feel"} {
		
		#execute the quality_feel.exe to generate the ppt
		set qualityFeel_exec  [file join $::antolin::reportGui::scriptDir reporting dist qualityFeel_ppt qualityFeel_ppt.exe];
		catch {exec $qualityFeel_exec} err
			
		tk_messageBox -message "Report complete" -icon info;
		
	}
}

::antolin::reportGui::mainGui
