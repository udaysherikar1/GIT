
catch {namespace delete ::loadcaseSetup}

namespace eval ::loadcaseSetup {
	
	variable str_outputuserporfile;
	variable nodeListFileName;
	variable str_inputfile;
	variable next_setid;
	variable curveId;
	variable input_solver;
	variable lst_filepath;
	variable count;
		
	#puts "::argv ----    $::argv"	
	
	set ::loadcaseSetup::scriptDir [file dirname [info script]];
	
	if {[set ::tcl_platform(platform)] == "unix"} {
		
		set index 3;
		
		set lst_filepath [lindex $::argv [expr $index+1]];
		set str_inputfile [lindex $::argv [expr $index+2]];
		set str_outputuserporfile [lindex $::argv [expr $index+3]];
		set curveId [lindex $::argv [expr $index+4]];
		set next_setid [lindex $::argv [expr $index+5]];
		set input_solver [lindex $::argv [expr $index+6]];
		set count [lindex $::argv [expr $index+7]];
		set nodeListFileName [lindex $::argv [expr $index+8]];
		
	} else {

		set lst_filepath [lindex $::argv 1];
		set str_inputfile [lindex $::argv 2];
		set str_outputuserporfile [lindex $::argv 3];
		set curveId [lindex $::argv 4];
		set next_setid [lindex $::argv 5];
		set input_solver [lindex $::argv 6];
		set count [lindex $::argv 7];
		set nodeListFileName [lindex $::argv 8];
	}
	
	
	set tempFile [file join $::loadcaseSetup::scriptDir test.txt];
	
	set fo [open $tempFile w];
	puts $fo "lst_filepath  -- $lst_filepath"
	puts $fo "str_inputfile  -- $str_inputfile"
	puts $fo "str_outputuserporfile  -- $str_outputuserporfile"
	puts $fo "curveId  -- $curveId"
	puts $fo "next_setid  -- $next_setid"
	puts $fo "input_solver  -- $input_solver"
	puts $fo "count  -- $count"
	puts $fo "nodeListFileName  -- $nodeListFileName"
	close $fo 
	
	
	
	#set lst_nodes [lindex $::argv 5];
	
	#puts "::argv  --- $::argv"
	#puts "---------------------------------------------------------------"
		
	set ::loadcaseSetup::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::loadcaseSetup::scriptDir Utils.tbc]]} {
		source [file join $::loadcaseSetup::scriptDir Utils.tbc];
	} else {
		source [file join $::loadcaseSetup::scriptDir Utils.tcl];
	}
	
	if {[file exists [file join $::loadcaseSetup::scriptDir write_impose_disp_card_radioss.tbc]]} {
		source [file join $::loadcaseSetup::scriptDir write_impose_disp_card_radioss.tbc];
	} else {
		source [file join $::loadcaseSetup::scriptDir write_impose_disp_card_radioss.tcl];
	}
	
}


proc ::loadcaseSetup::createInclude {} {

	*createinclude 0 "imposeDisplacement" "imposeDisplacement" 0;
	set includeid [lindex [hm_getincludes] end]
	*setcurrentinclude $includeid ""
}


proc ::loadcaseSetup::LoadRadiousProfile {} {

	set install_home [ hm_info -appinfo ALTAIR_HOME ] ;
	*enablemacromenu 1
	*templatefileset "$install_home/templates/feoutput/radioss/radioss2018.blk"
}

proc ::loadcaseSetup::LoadAbaqusProfile {} {
	set install_home [ hm_info -appinfo ALTAIR_HOME ] ;
	*enablemacromenu 1
	*templatefileset "$install_home/templates/feoutput/abaqus/standard.3d"
}

proc ::loadcaseSetup::LoadLsDyanProfile {} {
	set install_home [ hm_info -appinfo ALTAIR_HOME ] ;
	*enablemacromenu 1
	*templatefileset "$install_home/templates/feoutput/ls-dyna971/dyna.key"
}

proc ::loadcaseSetup::LoadPamcrash {} {
	set install_home [ hm_info -appinfo ALTAIR_HOME ] ;
	*enablemacromenu 1
	*templatefileset "$install_home/templates/feoutput/pamcrash2g/pam2g2016"
}

proc ::loadcaseSetup::CreateCurve {entityId str_curveName lst_x lst_y } {

    *xyplotcreatecurve "{0}" "" "" "" 1 "{0}" "" "" "" 1;
    *renamecollector curves "curve1" "$str_curveName";
    *xyplotcurvemodify "$str_curveName" "title" "$str_curveName" 0 1;
    *xyplotcurvemodify "$str_curveName" "markertype" "" 0 1;
    *xyplotcurvemodify "$str_curveName" "linetype" "" 1 1;
    *xyplotcurvemodify "$str_curveName" "width" "" 1 1;

    *xyplotmodifycurve "$str_curveName" "{[join $lst_x ,]}" "" "" "" 1 "{[join $lst_y ,]}" "" "" "" 1
    *plot;
	
	set n_curveid [hm_getvalue curve name="$str_curveName" dataname=id];
	*setvalue curves id=$n_curveid id={curves $entityId}
	
	#return $n_curveid
	
}

proc ::loadcaseSetup::CreateSet { entityId str_cardname n_nodeid} {

	*createentity sets cardimage=GRNOD name="$str_cardname"
	*setvalue sets name="$str_cardname" ids={nodes $n_nodeid}
		
	set n_setid [hm_getvalue sets name="$str_cardname" dataname=id];
	*setvalue sets id=$n_setid id={sets $entityId};
	
	#return $n_setid;
}

proc ::loadcaseSetup::CreateLoadColl_Radioss {n_setid n_curveid str_loadcollname str_axis} {

	#set n_setid [hm_getvalue sets name="$str_setname" dataname=id]
	#set n_curveid [hm_getvalue curve name="$str_curvename" dataname=id]
	
	*createentity loadcols cardimage=IMPDISP_Collector name="$str_loadcollname"
	*setvalue loadcols name="$str_loadcollname" STATUS=1 45={curves $n_curveid}
	*setvalue loadcols name="$str_loadcollname" STATUS=2 5108="$str_axis"
	*setvalue loadcols name="$str_loadcollname" STATUS=1 8056={sets $n_setid}
}


proc ::loadcaseSetup::CreateLoadColl_Abaqus {n_curveid str_loadcollname str_axis n_nodeid} {

	#set n_setid [hm_getvalue sets name="$str_setname" dataname=id]
	#set n_curveid [hm_getvalue curve name="$str_curvename" dataname=id]
	
	*createentity loadcols cardimage=HISTORY name="$str_loadcollname"
	hm_createmark nodes 1 $n_nodeid
	
	if {$str_axis == "X"} {
		*loadcreateonentity_curve nodes 1 3 1 0 -999999 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 0
	} elseif {$str_axis == "Y"} {
		*loadcreateonentity_curve nodes 1 3 1 -999999 0 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 0
	} elseif {$str_axis == "Z"} {
		*loadcreateonentity_curve nodes 1 3 1 -999999 -999999 0 -999999 -999999 -999999 0 0 0 $n_curveid 0
	}
	
	# *loadcreateonentity_curve nodes 1 3 1 0 -999999 -999999 -999999 -999999 -999999 0 0 0 0 0
	# *loadcreateonentity_curve nodes 1 3 1 0 -999999 -999999 -999999 -999999 -999999 0 0 0 0 0
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 1626=1
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 1679=1
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 1680={curves $n_curveid}
	
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 1639=1
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 1641={sets $n_setid}
}

proc ::loadcaseSetup::CreateLoadColl_Pamcrash {n_nodeid n_curveid str_loadcollname str_axis} {

	#set n_curveid [hm_getvalue curve name="$str_curvename" dataname=id]
	*createentity loadcols cardimage="DIS3D" name="$str_loadcollname"
	*loadtype 3 2
	hm_createmark nodes 1 "$n_nodeid"
	if {$str_axis == "X"} { 
		*loadcreateonentity_curve nodes 1 3 2 0 -999999 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 1
	} elseif {$str_axis == "Y"} {
		*loadcreateonentity_curve nodes 1 3 2 -999999 0 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 1s
	} elseif {$str_axis == "Z"} {
		*loadcreateonentity_curve nodes 1 3 2 -999999 -999999 0 -999999 -999999 -999999 0 0 0 $n_curveid 1
	}
	# *loadcreateonentity_curve nodes 1 3 2 0 0 0 0 0 0 0 0 0 0 0
	# *setvalue loadcols name="$str_loadcollname" STATUS=2 195={curves $n_curveid}
	
}

proc ::loadcaseSetup::CreateLoadColl_LSDyna {n_nodeid n_curveid str_loadcollname str_axis} {

	#set n_curveid [hm_getvalue curve name="$str_curvename" dataname=id]
	*createentity loadcols name="$str_loadcollname"
	*loadtype 3 2
	hm_createmark nodes 1 "$n_nodeid"
	if {$str_axis == "X"} { 
		*loadcreateonentity_curve nodes 1 3 2 1 -999999 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 1
	} elseif {$str_axis == "Y"} { 
		*loadcreateonentity_curve nodes 1 3 2 -999999 1 -999999 -999999 -999999 -999999 0 0 0 $n_curveid 1
	} elseif {$str_axis == "Z"} { 
		*loadcreateonentity_curve nodes 1 3 2 -999999 -999999 1 -999999 -999999 -999999 0 0 0 $n_curveid 1
	}
	
}

proc ::loadcaseSetup::CreateLoadCaseSetup {count lst_nodecoord lst_nodeid lst_intervals str_outputuserporfile} {
	
	variable str_inputfile;
	variable next_setid;
	variable curveId;
	
	set radioss_file [file join [file dir $str_inputfile] "impose_displacement" impose_displacement_loadcol_${count}.rad];
	
	array set arr_coord $lst_nodecoord;
	set lst_intervals [lsort -real $lst_intervals];
	
	
	#set n_setid $n_setid;
	set n_curveid_x $curveId;
	set n_curveid_y [expr $n_curveid_x+1];
	set n_curveid_z [expr $n_curveid_y+1];
	
	set line_count 1;
	set fo [open $radioss_file a+];
	foreach n_nodeid $lst_nodeid {
	
		set lst_xcoord [list ]
		set lst_ycoord [list ]
		set lst_zcoord [list ]
		
		foreach n_interval $lst_intervals {
			lappend lst_xcoord [expr [lindex $arr_coord($n_interval,$n_nodeid) 0] - [lindex $arr_coord([lindex $lst_intervals 0],$n_nodeid) 0]]
			lappend lst_ycoord [expr [lindex $arr_coord($n_interval,$n_nodeid) 1] - [lindex $arr_coord([lindex $lst_intervals 0],$n_nodeid) 1]]
			lappend lst_zcoord [expr [lindex $arr_coord($n_interval,$n_nodeid) 2] - [lindex $arr_coord([lindex $lst_intervals 0],$n_nodeid) 2]]
		}
				
		::loadcaseSetup::CreateCurve $n_curveid_x "ImposedDispCurv_X_[set n_nodeid]" "$lst_intervals" "$lst_xcoord";
		::loadcaseSetup::CreateCurve $n_curveid_y "ImposedDispCurv_Y_[set n_nodeid]" "$lst_intervals" "$lst_ycoord";
		::loadcaseSetup::CreateCurve $n_curveid_z "ImposedDispCurv_Z_[set n_nodeid]" "$lst_intervals" "$lst_zcoord";
		if {[string match -nocase $str_outputuserporfile "Radioss"] == "1" || [string match -nocase $str_outputuserporfile "Abaqus"] == "1"} {
			::loadcaseSetup::CreateSet $next_setid "ImposedDispSet_[set n_nodeid]" "$n_nodeid";
		}
				
		if {[string match -nocase $str_outputuserporfile "Radioss"] == "1" } {
		
			# ::loadcaseSetup::CreateLoadColl_Radioss $n_setid $n_curveid_x "ImposedDispLoadColl_X_[set n_nodeid]" "X"
			# ::loadcaseSetup::CreateLoadColl_Radioss $n_setid $n_curveid_y "ImposedDispLoadColl_Y_[set n_nodeid]" "Y"
			# ::loadcaseSetup::CreateLoadColl_Radioss $n_setid $n_curveid_z "ImposedDispLoadColl_Z_[set n_nodeid]" "Z"
			::imposedisp::write $fo $radioss_file $n_curveid_x $next_setid $n_nodeid "X" $line_count
			::imposedisp::write $fo $radioss_file $n_curveid_y $next_setid $n_nodeid "Y" $line_count
			::imposedisp::write $fo $radioss_file $n_curveid_z $next_setid $n_nodeid "Z" $line_count
			
			incr line_count
					
		} elseif {[string match -nocase $str_outputuserporfile "Abaqus"] == "1"} {
		
			::loadcaseSetup::CreateLoadColl_Abaqus $n_curveid_x "ImposedDispLoadColl_X_[set n_nodeid]" "X" "$n_nodeid"
			::loadcaseSetup::CreateLoadColl_Abaqus $n_curveid_y "ImposedDispLoadColl_Y_[set n_nodeid]" "Y" "$n_nodeid"
			::loadcaseSetup::CreateLoadColl_Abaqus $n_curveid_z "ImposedDispLoadColl_Z_[set n_nodeid]" "Z" "$n_nodeid"
			
		} elseif {[string match -nocase $str_outputuserporfile "Pamcrash"] == "1"} {
		
			::loadcaseSetup::CreateLoadColl_Pamcrash $n_nodeid  $n_curveid_x "ImposedDispLoadColl_X_[set n_nodeid]" "X"
			::loadcaseSetup::CreateLoadColl_Pamcrash $n_nodeid  $n_curveid_y "ImposedDispLoadColl_Y_[set n_nodeid]" "Y"
			::loadcaseSetup::CreateLoadColl_Pamcrash $n_nodeid  $n_curveid_z "ImposedDispLoadColl_Z_[set n_nodeid]" "Z"
		
		} elseif {[string match -nocase $str_outputuserporfile "LSDyna"] == "1"} {

			::loadcaseSetup::CreateLoadColl_LSDyna  $n_nodeid  $n_curveid_x "ImposedDispLoadColl_X_[set n_nodeid]" "X"
			::loadcaseSetup::CreateLoadColl_LSDyna  $n_nodeid  $n_curveid_y "ImposedDispLoadColl_Y_[set n_nodeid]" "Y"
			::loadcaseSetup::CreateLoadColl_LSDyna  $n_nodeid  $n_curveid_z "ImposedDispLoadColl_Z_[set n_nodeid]" "Z"
		}
		
		set next_setid [expr $next_setid+1];
		set n_curveid_x [expr $n_curveid_z+1];
		set n_curveid_y [expr $n_curveid_x+1];
		set n_curveid_z [expr $n_curveid_y+1];
		
	}
	
	close $fo
}


proc ::loadcaseSetup::ReadNodeData {str_file lst_nodes n_interval} {
		
	eval *createmark node 1 $lst_nodes
	set x_cordi [hm_getvalue node mark=1 dataname=x];
	set y_cordi [hm_getvalue node mark=1 dataname=y];
	set z_cordi [hm_getvalue node mark=1 dataname=z];
	array set arr_nodedata "";
	foreach nodeid $lst_nodes x $x_cordi y $y_cordi z $z_cordi {
		set arr_nodedata($n_interval,$nodeid) [list $x $y $z]
	}
	
	return [array get arr_nodedata]
}

proc ::loadcaseSetup::readNodeTxtFile {str_inputfile nodeListFileName} {

	set textFilePath [file join [file dir $str_inputfile] "impose_displacement" ${nodeListFileName}.txt];
	
	set fo [open $textFilePath r];
	set lst_nodes [read $fo]
	close $fo
	
	return $lst_nodes;

}


proc ::loadcaseSetup::blockMessages { } {
   
	hm_commandfilestate 0;
	hm_blockmessages 1;
	hm_blockerrormessages 1;
	hm_blockredraw 1;
	*entityhighlighting 0;
	hwbrowsermanager view flush false;
  
}

proc ::loadcaseSetup::main { } {

	variable str_outputuserporfile;
	variable nodeListFileName;
	variable str_inputfile;
	variable input_solver;
	variable lst_filepath;
	variable count;
			
	::loadcaseSetup::blockMessages;
	
	set lst_nodes [::loadcaseSetup::readNodeTxtFile $str_inputfile $nodeListFileName];
		
	set lst_nodalcoord [list]
	set lst_intervals [list]
	
	foreach str_filepath [lsort -dictionary $lst_filepath] {
		
		hm_answernext yes
		*deletemodel 
		::utils::LoadModel $str_filepath $input_solver;
				
		set str_filerootname [file rootname [file tail $str_filepath]]
		set n_interval [string map [list "ms" "" "MS" ""] [lindex [split $str_filerootname "_"] end]]
		lappend lst_intervals $n_interval
		
		lappend lst_nodalcoord [::loadcaseSetup::ReadNodeData $str_filepath $lst_nodes $n_interval]
	}
	
	
	catch {[file mkdir [file join [file dir $str_inputfile] "impose_displacement" ]]}
	
	#set t [clock click];
	hm_answernext yes
	*deletemodel 
	::utils::LoadModel $str_inputfile $input_solver;
	::loadcaseSetup::createInclude;
	if {[string match -nocase $str_outputuserporfile "Radioss"] == "1"} {
	
		::loadcaseSetup::LoadRadiousProfile
		::loadcaseSetup::CreateLoadCaseSetup $count [join $lst_nodalcoord] $lst_nodes $lst_intervals $str_outputuserporfile;
	} elseif {[string match -nocase $str_outputuserporfile "Abaqus"] == "1"} {
	
		::loadcaseSetup::LoadAbaqusProfile;
		::loadcaseSetup::CreateLoadCaseSetup $count [join $lst_nodalcoord] $lst_nodes $lst_intervals $str_outputuserporfile;
	} elseif {[string match -nocase $str_outputuserporfile "LSDyna"] == "1"} {
	
		::loadcaseSetup::LoadLsDyanProfile;
		::loadcaseSetup::CreateLoadCaseSetup $count [join $lst_nodalcoord] $lst_nodes $lst_intervals $str_outputuserporfile;
	} elseif {[string match -nocase $str_outputuserporfile "Pamcrash"] == "1"} {
	
		::loadcaseSetup::LoadPamcrash;
		::loadcaseSetup::CreateLoadCaseSetup $count [join $lst_nodalcoord] $lst_nodes $lst_intervals $str_outputuserporfile;
	}
	
		
	set hm_file [file join [file dir $str_inputfile] "impose_displacement" impose_displacement_${count}.hm];
	#puts "hm_file -- $hm_file"
	::utils::SaveHMfile $hm_file;
	
	set rad_file [file join [file dir $str_inputfile] "impose_displacement" impose_displacement_set_curve_${count}.rad];
	#puts "rad_file -- $rad_file"
	::utils::exportRadiossInclude $rad_file
	
	*quit 1;
}


::loadcaseSetup::main






