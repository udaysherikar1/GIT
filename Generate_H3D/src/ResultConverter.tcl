 #procomp E:\\WorkingDir\\WIP\\Mics\\2_h3dConvert\\package\27Oct\\*.tcl
catch {namespace delete ::antolin::hvtrans}

namespace eval ::antolin::hvtrans {
		
	variable username $::env(USERNAME)
	set ::antolin::hvtrans::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::antolin::hvtrans::scriptDir License_utils.tbc]]} {
		source [file join $::antolin::hvtrans::scriptDir License_utils.tbc];
	} else {
		source [file join $::antolin::hvtrans::scriptDir License_utils.tcl];
	}
	
	if {[file exists [file join $::antolin::hvtrans::scriptDir utils.tbc]]} {
		source [file join $::antolin::hvtrans::scriptDir utils.tbc];
	} else {
		source [file join $::antolin::hvtrans::scriptDir utils.tcl];
	}
	
	if {[file exists [file join $::antolin::hvtrans::scriptDir Auto_email.tbc]]} {
		source [file join $::antolin::hvtrans::scriptDir Auto_email.tbc];
	} else {
		source [file join $::antolin::hvtrans::scriptDir Auto_email.tcl];
	}
	
	# #load hwtk library for batch execution
	# lappend auto_path  {C:/Program Files/Altair/2021.1/hwdesktop/hw/tcl} 
	# package require hwtk

}

proc ::antolin::hvtrans::gui {} {

	catch {destroy .hvtrans};
	set h3dConvertMainFrm [toplevel .hvtrans];
	wm geometry $h3dConvertMainFrm +500+400;
	wm title $h3dConvertMainFrm "Antolin - H3D Convertor";
	wm maxsize  $h3dConvertMainFrm 700 300;
	wm minsize  $h3dConvertMainFrm 700 300;
	wm transient .hvtrans .
	
	set helpFrm [hwtk::menubutton $h3dConvertMainFrm.mb -text "Help" -compound left]
	pack $helpFrm -side top -expand false -padx 4 -pady 4 -anchor nw;
	$helpFrm item new -caption "Result Converter Help" -command ::antolin::hvtrans::LaunchHelp;
	
	set mainFrm1 [hwtk::frame $h3dConvertMainFrm.mainFrm1 ];
	pack $mainFrm1 -side top -pady 4 -padx 4 -anchor nw;
	
	set mainFrm2 [hwtk::frame $h3dConvertMainFrm.mainFrm2 ];
	pack $mainFrm2 -side top -pady 4 -padx 4 -anchor nw;
	
	set label_mainFrm [hwtk::labelframe $mainFrm1.label_mainFrm -text "Convert to H3D" -labelanchor nw -padding 4];
	pack $label_mainFrm -side top -expand false -padx 4 -pady 4 -anchor nw;
	
	set frm0 [hwtk::frame $label_mainFrm.frm0 ];
	pack $frm0 -side top -expand false -pady 4 -padx 4 -anchor nw;	
	
	set frm1 [hwtk::frame $label_mainFrm.frm1 ];
	pack $frm1 -side top -expand false -pady 4 -padx 4 -anchor nw;	
	
	set frm2 [hwtk::frame $label_mainFrm.frm2 ];
	pack $frm2 -side top -expand false -pady 4 -padx 4 -anchor nw;
	
	set frm3 [hwtk::frame $label_mainFrm.frm3 ];
	pack $frm3 -side top -expand false -pady 4 -padx 4 -anchor se;
	
	# variable pb_frm;
	# set pb_frm [hwtk::frame $label_mainFrm.pb_frm ];
	# pack $pb_frm -side top -expand true -fill both -pady 4 -padx 4 -anchor se;
	
	set frm_status [hwtk::frame $label_mainFrm.frm_status ];
	pack $frm_status -side top -expand false -pady 4 -padx 4 -anchor nw;
	
	set ::antolin::hvtrans::solverprofileList [list "LsDyna" ]
	set ::antolin::hvtrans::solverprofile [lindex $::antolin::hvtrans::solverprofileList 0]
	set solverLabel [hwtk::label $frm0.solverLabel -text "Profile"];
	pack $solverLabel -side left -expand true -pady 4 -padx 4;
	set dEntType [hwtk::editablecombobox $frm0.dEntType -state readonly -width 12 -values [set ::antolin::hvtrans::solverprofileList] \
					 -default $::antolin::hvtrans::solverprofile -textvariable ::antolin::hvtrans::solverprofile];
	pack $dEntType -side left -expand true -pady 4 -padx 4;
	
	set hwdir_labelFrm [hwtk::label $frm1.hwdir_labelFrm -text "HW Root Directory" -width 20];
	pack $hwdir_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set ::antolin::hvtrans::HWrootDirPath "C:/Program Files/Altair/2021.1"
	set hwdir_path_frm [hwtk::choosedirentry $frm1.hwdir_path_frm -width 110 -buttonpos left\
				-textvariable ::antolin::hvtrans::HWrootDirPath]
	pack $hwdir_path_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	set dir_labelFrm [hwtk::label $frm2.dir_labelFrm -text "Root Result Directory" -width 20];
	pack $dir_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set ::antolin::hvtrans::rootDirPath ""
	set dir_path_frm [hwtk::choosedirentry $frm2.dir_path_frm -width 110 -buttonpos left\
				-textvariable ::antolin::hvtrans::rootDirPath]
	pack $dir_path_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	set btnFrm [hwtk::frame $frm3.btnFrm ];
	pack $btnFrm -side top -pady 4 -padx 4 -anchor se;
	
	set apply1_frm [hwtk::button $btnFrm.apply1_frm -text "Convert" -width 10 -command ::antolin::hvtrans::exec_h3dConver];
	pack $apply1_frm -side top -expand false -padx 10 -pady 4 -anchor se;
		
	set note_label [hwtk::label $mainFrm2.note_label -text "Note : Generated log will be e-mailed to uday.sherikar@antolin.com"];
	pack $note_label -side left -expand true -pady 4 -padx 4 -anchor nw;
	
	# hwtk::progressbar $pb_frm.pb -mode indeterminate -value 0
	# pack $pb_frm.pb -side top -expand true -padx 10 -pady 4 -anchor sw;
	
	# variable statusLabel_frm;
	# set statusLabel_frm [hwtk::label $frm_status.statusLabel_frm -text "Status : "];
	# pack $statusLabel_frm -side left -expand true -pady 4 -padx 4 -anchor nw;
	
	# puts $statusLabel_frm
	
}

proc ::antolin::hvtrans::LaunchHelp {} {

	set help_doc [file join $::antolin::hvtrans::scriptDir Result_converter_help.pdf];
	
	if {[file exists $help_doc]} {
		eval exec [auto_execok start] $help_doc
	} else {
		tk_messageBox -message "Report Automation help does not exists in installation directory.\
		Kindly confirm and try launching help" -icon info
	}
}

proc ::antolin::hvtrans::IncrementPb {value} {
	variable pb_frm
	#$pb_frm.pb configure -value $value;
	$pb_frm.pb start;
	
}


proc ::antolin::hvtrans::GetLogPath {filepath} {
	
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
	set logpath [file join $data ${username}_h3dConvertor_Log_${d_m_y}.txt]

	return $logpath
	
}


proc ::antolin::hvtrans::ReadDataTypesFromTxt {} {
	#read text file and write config file accordingly
	set dataTypeTextPath [file join $::antolin::hvtrans::scriptDir dataTypes.txt];
	set fp [open $dataTypeTextPath r]
	set file_data [read $fp]
	close $fp
	
	return $file_data;
	
}

proc ::antolin::hvtrans::WriteConfigFile {} {
	
	set dataTypes [::antolin::hvtrans::ReadDataTypesFromTxt];
	
	set extendedInfoList [list];
	
	set configFilePath [file join $::env(HOME) hvtrans.cfg]
	set fo [open $configFilePath w];
	puts $fo "BeginSubcase:1"
	puts $fo "\tBeginSimulation:(All)"
	
	foreach dataType $dataTypes {
	
		if {[string match -nocase "*Stress*" $dataType] } {
			puts $fo "\t\tStress|Lower|vonMises"
			puts $fo "\t\tStress|Mid|vonMises"
			puts $fo "\t\tStress|Upper|vonMises"
			
			lappend extendedInfoList {1 0 1 0};
			
		} else {
			puts $fo "\t\tEffective plastic strain"	
			
			lappend extendedInfoList {1 0 1 1};
		}
	
	}
	
	puts $fo "\tEndSimulation"
	puts $fo "EndSubcase"
	puts $fo "ExtendedInfo: \{$extendedInfoList\}"
	
	close $fo
	
	return $configFilePath
}

proc ::antolin::hvtrans::exec_h3dConver {} {
		
	set hvTransPath [file join $::antolin::hvtrans::HWrootDirPath hwdesktop io result_readers bin win64 hvtrans.exe];
	if {![file exists $hvTransPath]} {
		tk_messageBox -message "Select valid HW Root directory" -icon error
		#$statusLabel_frm configure -text "Status : Select valid HW Root directory"
		return
	}
	
	#set sub_dirs [glob -nocomplain -directory $::antolin::hvtrans::rootDirPath -type d *];
	set sub_dirs [::antolin::utils::getNestedSubDirs $::antolin::hvtrans::rootDirPath]
	
	if {[llength $sub_dirs] == 0} {
		tk_messageBox -message "Select valid result directory" -icon error
		#$statusLabel_frm configure -text "Status : Select valid result directory"
		return
	}
	
	if {$::antolin::hvtrans::solverprofile == "LsDyna"} {
		set fileExt d3plot
	}
	
	#$statusLabel_frm configure -text "Status : Process started"
	
	set pb_increment [expr (100/[llength $sub_dirs])];
	#puts "pb_increment  --- $pb_increment"
	
	set configFilePath [::antolin::hvtrans::WriteConfigFile];
	set count 0
	foreach sub_dir $sub_dirs {
		
		#::antolin::hvtrans::IncrementPb [expr [$pb_frm.pb cget -value] + $pb_increment]
		set result_path [file join $sub_dir $fileExt];		
		if {![file exists $result_path]} {
			continue
		}
		
		set h3dFilePath [file join $sub_dir main.h3d];	
		catch {exec $hvTransPath -c $configFilePath $result_path $result_path -o $h3dFilePath}
				
		incr count
	}
	
	set log_filepath [::antolin::hvtrans::GetLogPath [file join $::antolin::hvtrans::scriptDir log_config.txt]];

	if {![file exists $log_filepath]} {
		set fo [open $log_filepath w];
		
		set org_name [exec whoami]
		puts $fo "\[[clock format [clock seconds] -format %D::%H:%M:%S]\] :  $org_name"
		puts $fo "-------------------------------------------------------------"
		puts $fo "-------------------------------------------------------------"
		
	} else {
		set fo [open $log_filepath a];
	}
	puts $fo "\[[clock format [clock seconds] -format %D::%H:%M:%S]\] no. of H3D converted : $count"
	close $fo
	
	#::antolin::hvtrans::IncrementPb 0
	catch {file delete -force $configFilePath}
	
	#$statusLabel_frm configure -text "Status : Process End"
	
	#write python file to send email 
	::antolin::autoEmail::SendOutlookEmail $log_filepath;
	
	tk_messageBox -message "Process complete." -icon info;
	
}

proc ::antolin::hvtrans::Launch_H3D_h3dConvertor {} {
	
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
	
	# # set ret2 [::antolin::checkOutlookInstallation];
	# # if {$ret2 == 1} {
		# # tk_messageBox -message "Microsoft Outlook is NOT installed on Laptop/Desktop. Kindly install it and try again" -icon error;
		# # return
	# # }
	
	set filePath [file join $::antolin::hvtrans::scriptDir validity.txt]
	set ret [::antolin::license::checkPAValidity $filePath];
	
	if {$ret == 0} {
		::antolin::hvtrans::gui;
	} elseif {$ret == 1} {
		tk_messageBox -message "Automation validity is over. Kindly contact 'Antolin Design and Business Services Pvt Ltd'" -icon error;
		return;
	} else {
		tk_messageBox -message "Kindly check your internet connection and try again" -icon error;
		return;
	}
}



::antolin::hvtrans::Launch_H3D_h3dConvertor


