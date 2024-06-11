
catch {namespace delete ::utils}

namespace eval ::utils {

}

proc ::utils::LoadModel {str_modfilpath str_inpsolver} {

	if {[string match -nocase $str_inpsolver "Nastran"] == 1} {
		#hm_answernext yes
		#*deletemodel 
		*createstringarray 12 "Nastran " "NastranMSC " "ANSA " "PATRAN " "SPC1_To_SPC " "HM_READ_PCL_GRUPEE_COMMENTS " "EXPAND_IDS_FOR_FORMULA_SETS " "ASSIGNPROP_BYHMCOMMENTS" "LOADCOLS_DISPLAY_SKIP " "VECTORCOLS_DISPLAY_SKIP " "SYSTCOLS_DISPLAY_SKIP " "CONTACTSURF_DISPLAY_SKIP "
		#set template "\#nastran\\nastran"
		#*feinputwithdata2 $template "$str_modfilpath" 0 0 0 0 0 1 12 1 0
		*feinputwithdata2 "\#nastran\\nastran" "$str_modfilpath" 0 0 0 0 0 1 12 1 0
		
	} elseif {[string match -nocase $str_inpsolver "OptiStruct"] == 1} {
		#hm_answernext yesOptiStruct
		#*deletemodel 
		*createstringarray 10 "OptiStruct " " " "ANSA " "PATRAN " "EXPAND_IDS_FOR_FORMULA_SETS " "ASSIGNPROP_BYHMCOMMENTS" "LOADCOLS_DISPLAY_SKIP " "VECTORCOLS_DISPLAY_SKIP " "SYSTCOLS_DISPLAY_SKIP " "CONTACTSURF_DISPLAY_SKIP "
		*feinputwithdata2 "\#optistruct\\optistruct" "$str_modfilpath" 0 0 0 0 0 1 10 1 0
		
	} elseif {[string match -nocase $str_inpsolver "Abaqus"] == 1} {
		#hm_answernext yes
		#*deletemodel 
		*feinputpreserveincludefiles
		*displayimporterrors 0
		*createstringarray 2 "Abaqus" "Standard3D"
		*feinputwithdata2 "#abaqus\\abaqus" "$str_modfilpath" 0 0 0 0 0 1 2 1 0 
	
	} elseif {[string match -nocase $str_inpsolver "LSDyna"] == 1} {
		#hm_answernext yes
		#*deletemodel 
		*createstringarray 19 "LsDyna" "Keyword971_R8.0" "READ_INITIAL_STRESS_SHELL" "READ_INITIAL_STRAIN_SHELL" "SKIP_INCLUDE_STAMP" "ACTIVATE_TRANSFORMATIONS" "CHECK_UNSUPPORTED_FIELDS_LINES " "EXTRANODES_DISPLAY_SKIP" "ACCELEROMETERS_DISPLAY_SKIP" "LOADCOLS_DISPLAY_SKIP" "RETRACTORS_DISPLAY_SKIP" "VECTORCOLS_DISPLAY_SKIP" "SYSTCOLS_DISPLAY_SKIP" "BLOCKS_DISPLAY_SKIP" "CROSSSECTION_DISPLAY_SKIP" "CONSTRAINEDRIGIDBODY_DISPLAY_SKIP" "RIGIDWALLS_DISPLAY_SKIP" "SLIPRINGS_DISPLAY_SKIP" "CONTACTSURF_DISPLAY_SKIP"
		*feinputwithdata2 "\#ls-dyna\\dynakey" "$str_modfilpath" 0 0 0 0 0 1 19 1 0
	}
		
}



proc ::utils::exportRadiossInclude {filepath} {

	*createstringarray 2 "HMBOMCOMMENTS_XML" "HMMATCOMMENTS_XML"
	set export_template [file join [hm_info -appinfo  ALTAIR_HOME] templates feoutput radioss radioss2018.blk];
	*feoutput_singleinclude 1 "imposeDisplacement" $export_template $filepath 1 0 2 1 2
	#*feoutput_singleinclude 1 "imposeDisplacement" "C:/Apps/Altair/2021/hwdesktop/templates/feoutput/radioss/radioss2018.blk" "E:/WorkingDir/Models/From_Sandeep/20231116_Intrusion_Data/V2251581700053209689_001/test1.rad" 1 0 2 1 2

}

proc ::utils::getRunningProcesses {} {
	
	set output [exec tasklist /fo csv]
	set lines [split $output "\n"]

	foreach line $lines {
		set columns [split $line ,];
		set processName [lindex $columns 0];
		set processID [lindex $columns 1];
		#puts "$processName  -----  $processID"
	}
}

proc ::utils::killProcess {} {
	exec taskkill /F /PID 16976
}

proc ::utils::SaveHMfile {hm_file} {

	*writefile $hm_file 1;
}



