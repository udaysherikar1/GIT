#procomp E:\\WorkingDir\\WIPMic\\Imposed_Displacemen\\package\\*.tcl

catch {namespace delete ::Imposed_Displacement}

namespace eval ::Imposed_Displacement {
	
	set platform [set ::tcl_platform(platform)];
	if {$platform == "unix"} {
		variable username $::env(USER)
	} else {
		variable username $::env(USERNAME)
	}
	

	set ::Imposed_Displacement::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::Imposed_Displacement::scriptDir LoadCaseSetup.tbc]]} {
		#source [file join $::Imposed_Displacement::scriptDir LoadCaseSetup.tbc];
		set loadCaseSetup [file join $::Imposed_Displacement::scriptDir LoadCaseSetup.tbc];
	} else {
		#source [file join $::Imposed_Displacement::scriptDir LoadCaseSetup.tcl];
		set loadCaseSetup [file join $::Imposed_Displacement::scriptDir LoadCaseSetup.tcl];
	}
	
	if {[file exists [file join $::Imposed_Displacement::scriptDir Utils.tbc]]} {
		source [file join $::Imposed_Displacement::scriptDir Utils.tbc];
	} else {
		source [file join $::Imposed_Displacement::scriptDir Utils.tcl];
	}
	
	if {[file exists [file join $::Imposed_Displacement::scriptDir Check_running_processes.tbc]]} {
		source [file join $::Imposed_Displacement::scriptDir Check_running_processes.tbc];
	} else {
		source [file join $::Imposed_Displacement::scriptDir Check_running_processes.tcl];
	}
	
	if {[file exists [file join $::Imposed_Displacement::scriptDir License_utils.tbc]]} {
		source [file join $::Imposed_Displacement::scriptDir License_utils.tbc];
	} else {
		source [file join $::Imposed_Displacement::scriptDir License_utils.tcl];
	}
	
	if {[file exists [file join $::Imposed_Displacement::scriptDir Auto_email.tbc]]} {
		source [file join $::Imposed_Displacement::scriptDir Auto_email.tbc];
	} else {
		source [file join $::Imposed_Displacement::scriptDir Auto_email.tcl];
	}
	
}

proc ::Imposed_Displacement::UI {} {
	set str_filepath [list]
	set str_directpath [list]

	set impdispframe .impdispframe
	if {[winfo exist $impdispframe ] == 1 } {
		destroy $impdispframe
	}
	
	toplevel $impdispframe
	wm title $impdispframe "Create Imposed Displacement"
	wm minsize $impdispframe 1000 100
	
	set frm_directorypath [hwtk::frame $impdispframe.frm_directorypath ];
	pack $frm_directorypath -side top -anchor nw -padx 5 -pady 5 -fill x -expand 1;
	
		set frm_inpfilepath [hwtk::frame $frm_directorypath.frm_inpfilepath ];
		pack $frm_inpfilepath -side top -anchor nw  -padx 5 -pady 5 -fill x -expand 1;
		
			set lbl_inpfilepath [hwtk::label $frm_inpfilepath.lbl_inpfilepath -text "Input Model file path" -width 25]
			pack $lbl_inpfilepath -side left -anchor nw -padx 5;
			
			#set combox_inpuserprofile [hwtk::combobox $frm_inpfilepath.combox_inpuserprofile -values [list "Nastran" "OptiStruct" "Abaqus" "LsDyna"] -textvariable str_inputuserporfile ]
			set combox_inpuserprofile [hwtk::combobox $frm_inpfilepath.combox_inpuserprofile -values [list "Nastran"] -textvariable str_inputuserporfile ]
			pack $combox_inpuserprofile -side left -anchor nw -padx 5 -pady 0 ;
			$frm_inpfilepath.combox_inpuserprofile current 0
			
			set entry_inpfilepath [hwtk::openfileentry $frm_inpfilepath.entry_inpfilepath -textvariable str_filepath ]
			pack $entry_inpfilepath -side left -anchor ne -padx 5 -fill x -expand 1;
			
			set btn_loadmodel [hwtk::button $frm_inpfilepath.btn_loadmodel -text "Load Model" -command {::Imposed_Displacement::LoadModel $str_filepath $str_inputuserporfile } ]
			pack $btn_loadmodel  -side right -anchor nw -padx 0 ;
		
		set frm_inpdircpath [hwtk::frame $frm_directorypath.frm_inpdircpath ];
		pack $frm_inpdircpath -side top -anchor nw  -padx 5 -pady 5 -fill x -expand 1;
		
			set lbl_inpdirpath [hwtk::label $frm_inpdircpath.lbl_inpdirpath -text "Repository file path" -width 25]
			pack $lbl_inpdirpath -side left -anchor nw -padx 5;
			
			set entry_inpdirpath [hwtk::choosedirentry $frm_inpdircpath.entry_inpdirpath -textvariable str_directpath ]
			pack $entry_inpdirpath -side left -anchor ne -padx 5 -fill x -expand 1;
			
		set frm_outputuserprofile [hwtk::frame $frm_directorypath.frm_outputuserprofile ];
		pack $frm_outputuserprofile -side top -anchor nw  -padx 5 -pady 5 -fill x -expand 1;
		
			set lbl_outputuserprofile [hwtk::label $frm_outputuserprofile.lbl_outputuserprofile -text "Selection of User Profile" -width 25]
			pack $lbl_outputuserprofile -side left -anchor nw -padx 5;	
			
			#set combox_outputuserprofile [hwtk::combobox $frm_outputuserprofile.combox_outputuserprofile -values [list "Radioss" "Abaqus" "LsDyna" "Pamcrash"] -textvariable str_outputuserporfile ]
			set combox_outputuserprofile [hwtk::combobox $frm_outputuserprofile.combox_outputuserprofile -values [list "Radioss"] -textvariable str_outputuserporfile ]
			pack $combox_outputuserprofile -side left -anchor nw -padx 5 -pady 0 ;
			$frm_outputuserprofile.combox_outputuserprofile current 0
				
		set frm_nodeselc [hwtk::frame $frm_directorypath.frm_nodeselc];
		pack $frm_nodeselc -side top -anchor ne -padx 5 -pady 5 -fill x;
					
			set btn_nodesselc [hwtk::button $frm_nodeselc.btn_nodesselc -text "Apply" -command {::Imposed_Displacement::Api $str_filepath $str_directpath $str_inputuserporfile $str_outputuserporfile} ]
			pack $btn_nodesselc  -side right -anchor ne -padx 5;
		
}


proc ::Imposed_Displacement::GetLogPath {filepath} {
	
	variable username
	
	set str_configFile $filepath
	set fp [open $str_configFile r]
	set file_data [read $fp]
	close $fp
	set data [join [split $file_data "\n"]]
	
	if {![file exists $data]} {
		catch {file mk dir $data}
	}
	
	set d_m_y [string map {/ "_"} [clock format [clock seconds] -format %d/%m/%Y]];
	set logpath [file join $data ${username}_Impose_Displacement_Log_${d_m_y}.txt];

	return $logpath
	
}

proc ::Imposed_Displacement::combine_results {str_inpdir} {

	#set str_inpdir {E:\WorkingDir\Models\From_Sandeep\20231116_Intrusion_Data\V2251581700053209689_001\impose_displacement}
	set lst_filepath [::Imposed_Displacement::Getfiles [file join [file normalize $str_inpdir] "impose_displacement"] ".rad"];
	
	set combined_set_curve_file [file join $str_inpdir "impose_displacement" combined_set_curve.rad];
	set combined_impose_displacement_file [file join $str_inpdir "impose_displacement" combined_impose_displacement.rad];
	
	set fo_s_c [open $combined_set_curve_file w];
	set fo_i_d [open $combined_impose_displacement_file w];
	
	foreach rad_file $lst_filepath {
		
		set fr [open $rad_file r];
		
		set file_context ""	
		if {[string match *impose_displacement_loadcol* $rad_file]} {
			#write loadcol file without any change
			set file_context [read $fr]
			puts $fo_i_d $file_context;
		}
		
		if {[string match *impose_displacement_set_curve* $rad_file]} {
			#read line by line to avoid writting #enddata and /END  cards
			while { [gets $fr data] >= 0 } {
				if {[string match "*#enddata*" $data] || [string match "*/END*" $data]} {
					continue
				}
				puts $fo_s_c $data;	
			}
		} 
		
		close $fr;
	}
	
	close $fo_i_d;
	close $fo_s_c;

}


proc ::Imposed_Displacement::LoadModel {str_modfilpath str_inpsolver} {

	::utils::LoadModel $str_modfilpath $str_inpsolver;

}


proc ::Imposed_Displacement::Getfiles {str_directpath str_extn} {

	set lst_resultfiles [glob -nocomplain -directory $str_directpath "*$str_extn"]
	if {[llength $lst_resultfiles] <= 0} {
		tk_messageBox -message "No files found in the folder directory" -title "Warning"	
	}
    
	return $lst_resultfiles
}

proc ::Imposed_Displacement::GetNodeList {} {

	 *createmarkpanel node 1 "Please select the nodes"
	 set lst_nodes [hm_getmark node 1]		
	 return $lst_nodes
}

proc ::Imposed_Displacement::WriteNodeList {str_inputfile filename nodeList} {

	if { [llength $nodeList] == 0} {
		return	
	}
		
	catch {[file mkdir [file join [file dir $str_inputfile] "impose_displacement" ]]}
	
	set textFilePath [file join [file dir $str_inputfile] "impose_displacement" ${filename}.txt];
	set fo [open $textFilePath w];
	puts $fo $nodeList;
	close $fo;
}
	
proc ::Imposed_Displacement::launch_multiple_sessions {hwExe lst_filepath str_inputfile str_outputuserporfile curveId n_setid input_solver i listTextName} {
	
	if {[set ::tcl_platform(platform)] == "unix"} {
		catch {exec $hwExe -batch -tcl $::Imposed_Displacement::loadCaseSetup [list $lst_filepath] $str_inputfile \
						$str_outputuserporfile $curveId $n_setid $input_solver $i $listTextName &};
	} else {
		catch {exec $hwExe -clientconfig hwfepre.dat -b -tcl $::Imposed_Displacement::loadCaseSetup $lst_filepath $str_inputfile \
						$str_outputuserporfile $curveId $n_setid $input_solver $i $listTextName &};
						
	}					
}


proc ::Imposed_Displacement::Api { str_inputfile str_inpdir str_inputfilesolver str_outputuserporfile } {
	
	variable log_filepath;
	
	set outputDir [file join [file dir $str_inputfile] "impose_displacement" ];
	if {[file exists $outputDir]} {
		
		set ans [tk_messageBox -message "Tool will re-write the \"impose_displacement\" directory in result folder.\
		Do you want to continue?" -type yesno];
		
		if {$ans == "no"} {
			return
		}		
		catch {[file delete -force $outputDir ]}
	}
	
	
	
	set all_hw_pid [::process::checkRunningProcess];
	
	if {[llength $all_hw_pid] > 1} {
		tk_messageBox -message "Keep only ONE HyperWorks session open and try again" -title "Impose Displacement" -icon error
		return 
	}
	
	#set lst_nodalcoord [list]
	set current_hw_pid [pid];
	
	wm iconify .impdispframe;
	
	if {[string match $str_inputfilesolver "Nastran"] == 1} {
		set input_solver "Nastran"
		set str_extn ".nas"
	} elseif {[string match -nocase $str_inputfilesolver "OptiStruct"] == 1} {
		set input_solver "OptiStruct"
		set str_extn ".fem"
	} elseif {[string match -nocase $str_inputfilesolver "Abaqus"] == 1} {
		set input_solver "Abaqus"
		set str_extn ".inp"
	} elseif {[string match -nocase $str_inputfilesolver "LsDyna"] == 1} {
		set input_solver "LsDyna"
		set str_extn ".key"
	}
	
	set lst_nodes [::Imposed_Displacement::GetNodeList];
	if {[llength $lst_nodes] == 0} {
		return
	}
	
	puts "Please wait, process started...!"
	
	puts "Start time ---> [clock format [clock seconds] -format %D::%H:%M:%S]"
	
	set lst_filepath [::Imposed_Displacement::Getfiles [file normalize $str_inpdir] $str_extn]
					
	#puts "execution end ---- [clock format [clock seconds] -format %D::%H:%M:%S]"
	
	if {[set ::tcl_platform(platform)] == "unix"} {
		#linux
		set hwExe [file join [hm_info -appinfo ALTAIR_HOME] scripts hm];
		#set hwExe [file join [hm_info -appinfo ALTAIR_HOME] scripts hmbatch];
	} else {
		#windows
		set hwExe [file join [hm_info -appinfo ALTAIR_HOME] hw bin win64 hw.exe];
	}
	
	
	set n_nodes [llength $lst_nodes];
	puts "no. of selected nodes ----   $n_nodes"
	# set range 5000;
	#set range 3000;
	set range 1000;
	# set range 5;
	set list_first 0;
	set list_last [expr $range - 1];
	set stopper 0;
	set curveId 1;
	set n_setid 1;
	set i 1;
	
	while {$n_nodes >= $stopper} {
		
		set list$i [lrange $lst_nodes $list_first $list_last];	
		::Imposed_Displacement::WriteNodeList $str_inputfile list$i [set list$i];
		if {[llength [set list$i]] > 0} {	
			::Imposed_Displacement::launch_multiple_sessions $hwExe $lst_filepath $str_inputfile $str_outputuserporfile $curveId $n_setid $input_solver $i list$i;
		}
		incr i 1;
		set stopper [expr $stopper + $range];
		#puts "stopper $i -- $stopper"
		set n_setid [expr $n_setid+$range];
		set curveId [expr $curveId+($range*3)];
		
		set list_first [expr $list_first+$range];
		set list_last [expr $list_last+$range];
		set list$i [lrange $lst_nodes $list_first $list_last];
		::Imposed_Displacement::WriteNodeList $str_inputfile list$i [set list$i];
		if {[llength [set list$i]] > 0} {	
			::Imposed_Displacement::launch_multiple_sessions $hwExe $lst_filepath $str_inputfile $str_outputuserporfile $curveId $n_setid $input_solver $i list$i;
		}
		incr i 1;
		set stopper [expr $stopper + $range];
		#puts "stopper $i -- $stopper"
		set n_setid [expr $n_setid+$range];
		set curveId [expr $curveId+($range*3)];
		
		set list_first [expr $list_first+$range];
		set list_last [expr $list_last+$range];
		set list$i [lrange $lst_nodes $list_first $list_last];
		::Imposed_Displacement::WriteNodeList $str_inputfile list$i [set list$i];
		if {[llength [set list$i]] > 0} {	
			::Imposed_Displacement::launch_multiple_sessions $hwExe $lst_filepath $str_inputfile $str_outputuserporfile $curveId $n_setid $input_solver $i list$i;
		}
		incr i 1;
		set stopper [expr $stopper + $range];
		#puts "stopper $i -- $stopper"
		set n_setid [expr $n_setid+$range];
		set curveId [expr $curveId+($range*3)];
		
		set list_first [expr $list_first+$range];
		set list_last [expr $list_last+$range];	
		after 15000;  #15 sec delay until all hw are launched 
		
		#loop will run until all hm sessions are closed, other than current session
		set all_hw_pid [::process::checkRunningProcess];
		while {[llength $all_hw_pid] > 1} {
			set all_hw_pid [::process::checkRunningProcess];
			after 15000;  #15 sec wait
		}			
	}
	::Imposed_Displacement::combine_results $str_inpdir
	
	set fo [open $log_filepath a];
	puts $fo "-----------------------------------------------------------------"
	puts $fo "No. of selected nodes -  $n_nodes"
	puts $fo "No. of result files -  [llength $lst_filepath]"
	puts $fo "Total nodes processed -  $n_nodes*[llength $lst_filepath] = [expr $n_nodes*[llength $lst_filepath]]"
	puts $fo "No. of sets created -  $n_nodes"
	puts $fo "No. of curves created -  [expr $n_nodes*3]"
	puts $fo "No. of imposed displacements cards -  [expr $n_nodes*3]"
	close $fo
	
	set platform [set ::tcl_platform(platform)];
	if {$platform != "unix"} {
		#write python file to send email 
		::antolin::autoEmail::SendOutlookEmail $log_filepath;
	}
	
	puts "Process completed."
	
	puts "End time ---> [clock format [clock seconds] -format %D::%H:%M:%S]"
	
	tk_messageBox -message "Process completed." -icon info
	
	
}


proc ::Imposed_Displacement::main {} {
	
	variable log_filepath;
	variable username
	
	set filePath [file join $:::Imposed_Displacement::scriptDir validity.txt];
	set ret [::antolin::license::checkPAValidity $filePath];
	
	if {$ret == 0} {
		
		set platform [set ::tcl_platform(platform)];
		
		if {$platform != "unix"} {
			#auto email block for windows 
			set feedback [tk_messageBox -message "Generated log will be e-mailed to 'uday.sherikar@antolin.com'. \nDo you agree?" -type yesno -icon info];
			if {$feedback == "no"} {
				return
			}
				
			set ret [::antolin::autoEmail::ChkPythonInstallation];
			if {$ret == 1} {
				tk_messageBox -message "Python is not intalled in your laptop/desktop. " -icon error;
				return
			}
			
			set ret1 [::antolin::autoEmail::check_py_win32com_library];
			if {$ret1 == 1} {
				tk_messageBox -message "Required python library is NOT available.  Execute 'pip install pywin32' in windows command prompt and try again" -icon error;
				return
			}
		}
		
				
		if {$platform == "unix"} {
			set d_m_y [string map {/ "_"} [clock format [clock seconds] -format %d/%m/%Y]];
			set log_filepath [file join $::Imposed_Displacement::scriptDir ${username}_Impose_Displacement_Log_${d_m_y}.txt];
	
		} else {
			set log_filepath [::Imposed_Displacement::GetLogPath [file join $::Imposed_Displacement::scriptDir log_config.txt]];
		}
		
		
		if {![file exists $log_filepath]} {
			set fo [open $log_filepath w];
			set org_name [exec whoami]
			puts $fo "\[[clock format [clock seconds] -format %D::%H:%M:%S]\] :  $org_name"
			puts $fo "-------------------------------------------------------------"
			puts $fo "-------------------------------------------------------------"
			
		} else {
			set fo [open $log_filepath a];
		}
		close $fo
				
		::Imposed_Displacement::UI;
		
	} else {
		tk_messageBox -message "Automation validity is over. Kindly contact 'Antolin Design and Business Services Pvt Ltd'" -icon error;
		return;
	}
	
};

::Imposed_Displacement::main

