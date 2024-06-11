
#procomp E:\\WorkingDir\\WIP\\Pam_Thickess_assignemnt\\package\\23Nov\\*.tcl


#usecase -1 :
# 1. Get each component Thickess
# 2. Assign component Thickess to all elements 

# usecase - 2: Element to component
# 1. Query element thickness
# 2. Create new component for each thickness and move same thickness element to it
# 3. Component name is - base component name _ T _ thicknes_value

catch {namespace delete ::antolin::pam_thickness}

namespace eval ::antolin::pam_thickness {

	variable username $::env(USERNAME)
	set ::antolin::pam_thickness::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::antolin::pam_thickness::scriptDir License_utils.tbc]]} {
		source [file join $::antolin::pam_thickness::scriptDir License_utils.tbc];
	} else {
		source [file join $::antolin::pam_thickness::scriptDir License_utils.tcl];
	}

	if {[file exists [file join $::antolin::pam_thickness::scriptDir Auto_email.tbc]]} {
		source [file join $::antolin::pam_thickness::scriptDir Auto_email.tbc];
	} else {
		source [file join $::antolin::pam_thickness::scriptDir Auto_email.tcl];
	}
	
}


proc ::antolin::pam_thickness::gui {} {

	catch {destroy .thicknessAssignment};
	set thicknessAssignmentMainFrm [toplevel .thicknessAssignment];
	wm geometry $thicknessAssignmentMainFrm +500+400;
	wm title $thicknessAssignmentMainFrm "Antolin";
	wm maxsize  $thicknessAssignmentMainFrm 350 170;
	wm minsize  $thicknessAssignmentMainFrm 350 170;
	wm transient .thicknessAssignment .
	
	
	set helpFrm [hwtk::menubutton $thicknessAssignmentMainFrm.mb -text "Help" -compound left]
	pack $helpFrm -side top -expand false -padx 4 -pady 4 -anchor nw;
	$helpFrm item new -caption "Thickness Assg Help" -command ::antolin::pam_thickness::LaunchHelp;

	set mainFrm1 [hwtk::frame $thicknessAssignmentMainFrm.mainFrm1 ];
	pack $mainFrm1 -side top -pady 4 -padx 4 -anchor nw;
	
	set label_mainFrm [hwtk::labelframe $mainFrm1.label_mainFrm -text "Pamcrash Thickess Assignment" -labelanchor nw -padding 4];
	pack $label_mainFrm -side top -expand false -padx 4 -pady 4 -anchor nw;
	
	set frm1 [hwtk::frame $label_mainFrm.frm1 ];
	pack $frm1 -side top -expand false -pady 4 -padx 4 -anchor nw;	
	
	set frm2 [hwtk::frame $label_mainFrm.frm2 ];
	pack $frm2 -side top -expand false -pady 4 -padx 4 -anchor nw;	
	
	set compToElem_labelFrm [hwtk::label $frm1.compToElem_labelFrm -text "Component to Element" -width 30];
	pack $compToElem_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set apply1_frm [hwtk::button $frm1.apply1_frm -text "Apply" -width 10 -command ::antolin::pam_thickness::assignComponentToElementThickness];
	pack $apply1_frm -side top -expand false -padx 10 -pady 4 -anchor se;
	
	set elemToComp_labelFrm [hwtk::label $frm2.elemToComp_labelFrm -text "Element to Component" -width 30];
	pack $elemToComp_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set apply2_frm [hwtk::button $frm2.apply2_frm -text "Apply" -width 10 -command ::antolin::pam_thickness::assignElementToComponentThickness];
	pack $apply2_frm -side top -expand false -padx 10 -pady 4 -anchor se;
	
	
}


proc ::antolin::pam_thickness::LaunchHelp {} {
	
	set help_doc [file join $::antolin::pam_thickness::scriptDir Pamcrash_Thickness_assignemnt_help.pdf];
	
	if {[file exists $help_doc]} {
		eval exec [auto_execok start] $help_doc
	} else {
		tk_messageBox -message "Report Automation help does not exists in installation directory.\
		Kindly confirm and try launching help" -icon info
	}

}


# ----------------------------------------Component To Element-------------------------------------
proc ::antolin::pam_thickness::assignComponentToElementThickness {} {
	puts "clicked comp to elem"
	variable log_filepath;
	
	*createmark components 1 displayed;
	set lst_comps [hm_getmark comps 1];
	
	set fo [open $log_filepath a];
	
	puts $fo "#################################################################"
	puts $fo "Component To Element Thickess Assignemnt"
	puts $fo "#################################################################"
	
	#set dummy_thickness 99.0
	foreach compId $lst_comps {
		#unset array for each component
		#catch {array unset ::antolin::pam_thickness::arr_Comp_To_elem_thickness}
		
		set comp_thickness [hm_getvalue comp id=$compId dataname=thickness];
		*createmark element 1 "by comp" $compId;
		set lst_elems [hm_getmark element 1];
		
		#assign component thicknes to elements
		*setvalue element mark=1 1209=$comp_thickness;     #1209 is element thickness attribute number for pamcrash 
		#*setvalue comp id=$compId 416=$dummy_thickness;     #416 is component thickness attribute number for pamcrash 
		
		set ori_comp_name [hm_getvalue comp id=$compId dataname=name];
		
		# # if {[string match -nocase *PPT* $ori_comp_name]} {
			# # #check PPT keyword in component name 
			# # set index [string first PPT $ori_comp_name];
			# # set newCompName [string range $ori_comp_name 0 [expr $index -1]];
		# # } elseif {[string match -nocase *_T_* $ori_comp_name]} {
			# # #check _T_ keyword in component name 
			# # set index [string first _T_ $ori_comp_name];
			# # set newCompName [string range $ori_comp_name 0 [expr $index -1]];
		# # } else {
			# # #remove last 10 charaters from name and create new name
			# # set newCompName [string range $ori_comp_name 0 [expr [string length $ori_comp_name] -10]];
		# # }
		
		# # if {![hm_entityinfo exist comp $newCompName ]} {
			# # *createentity comps cardimage=PART_2D includeid=0 name=$newCompName;
			# # *createmark comp 1 -1;
			# # set newCompId [hm_getmark comp 1];
		# # } else {
			# # *createmark comp 1 "by name" $newCompName;
			# # set newCompId [hm_getmark comp 1];
		# # }
		
		# # eval *createmark elements 1 $lst_elems;
		# # *movemark elements 1 $newCompName;
			
	}
	
	
	eval *createmark element 1 "by comp" $lst_comps;
	set all_elems [hm_getmark element 1];
	
	puts $fo "Total no. updated components - [llength $lst_comps]"
	puts $fo "Total no. of updated elements - [llength $all_elems]"
	puts $fo "-------------------------------------------------------------"
		
	close $fo	
	
	#write python file to send email 
	::antolin::autoEmail::SendOutlookEmail $log_filepath;
	
	tk_messageBox -message "Process complete." -icon info;
}





# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



# ----------------------------------------Element To Component-------------------------------------
#this function query element thickness and store in array
proc ::antolin::pam_thickness::assignElementToComponentThickness {} {
	
	variable log_filepath;
	
	*createmark components 1 displayed;
	set lst_comps [hm_getmark comps 1];
	
	set fo [open $log_filepath a];
	
	puts $fo "#################################################################"
	puts $fo "Element To Component Thickess Assignemnt"
	puts $fo "#################################################################"
	
	set n_total_updated_elems 0;
	
	foreach compId $lst_comps {
		#unset array for each component
		catch {array unset ::antolin::pam_thickness::arr_elem_To_Comp_thickness}
		
		*createmark element 1 "by comp" $compId;
		set lst_elems [hm_getmark element 1];
		set lst_thickness [hm_getvalue elem mark=1 dataname=thickness];
		
		set n_total_updated_elems [expr $n_total_updated_elems + [llength $lst_elems]];
		
		foreach elemId $lst_elems thickness $lst_thickness {
			if {![info exists ::antolin::pam_thickness::arr_elem_To_Comp_thickness($thickness)]} {
				set ::antolin::pam_thickness::arr_elem_To_Comp_thickness($thickness) $elemId;
			} else {
				lappend ::antolin::pam_thickness::arr_elem_To_Comp_thickness($thickness) $elemId;
			}
		}
		#parray ::antolin::pam_thickness::arr_elem_To_Comp_thickness	
		# call function to create new comp and move same thickness value to it
		::antolin::pam_thickness::arrange_elems_In_Component $compId $fo [llength $lst_elems];		
	}
	
	#get newly created comp count 
	*createmark components 1 displayed;
	set all_comps [hm_getmark comps 1];
	set n_newComp [expr [llength $all_comps] - [llength $lst_comps]];
	
	puts $fo "Total no. updated components - [llength $lst_comps]"
	puts $fo "Total no. of updated elements - $n_total_updated_elems"
	puts $fo "Total no. of newly created components - $n_newComp"
	puts $fo "-------------------------------------------------------------"
	
	close $fo	
	
	#write python file to send email 
	::antolin::autoEmail::SendOutlookEmail $log_filepath;
	
	tk_messageBox -message "Process complete." -icon info;
}

#function array elements in different components based on thickness value
proc ::antolin::pam_thickness::arrange_elems_In_Component {compId fo elem_count} {
	
	set comp_name [hm_getvalue comp id=$compId dataname=name];
	
	# puts $fo "Component id - $compId"
	# puts $fo "Component name - $comp_name"
	# puts $fo "No. of updated elements - $elem_count"
	# puts $fo "No. of newly created components - [llength [array name ::antolin::pam_thickness::arr_elem_To_Comp_thickness]]"
	# puts $fo "-------------------------------------------------------------"
		
	foreach n_thickness [array name ::antolin::pam_thickness::arr_elem_To_Comp_thickness] {
		
		#create comp with name
		set new_comp_name ${comp_name}_T_${n_thickness}
		if {![hm_entityinfo exist comp $new_comp_name ]} {
			*createentity comps cardimage=PART_2D includeid=0 name=$new_comp_name;
			*createmark comp 1 -1;
			set newCompId [hm_getmark comp 1];
		} else {
			*createmark comp 1 "by name" $new_comp_name;
			set newCompId [hm_getmark comp 1];
		}
		
		*attributeupdatedouble components $newCompId 416 18 2 0 $n_thickness
		
		#elements with same thickness
		set lst_elem [set ::antolin::pam_thickness::arr_elem_To_Comp_thickness($n_thickness)];
		
		#set element thickness to 0.0
		eval *createmark elements 1 $lst_elem;
		*setvalue element mark=1 1209=0.0;     #1209 is thickness attribute number for pamcrash 
		
		#organise elements to new components		
		eval *createmark elements 1 $lst_elem;
		*movemark elements 1 $new_comp_name;
	}
}
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


proc ::antolin::pam_thickness::GetLogPath {filepath} {
	
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
	set logpath [file join $data ${username}_pam_thickness_assignemnt_Log_${d_m_y}.txt];

	return $logpath
	
}


proc ::antolin::pam_thickness::main {} {
	
	variable log_filepath;
	
	set tempSolver [hm_info templatetype]
	if {$tempSolver != "pamcrash2g"} {
		tk_messageBox -message "Tool only support Pamcrash profile. " -icon error;
		return
	}
	
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
	
	set filePath [file join $::antolin::pam_thickness::scriptDir validity.txt]
	set ret [::antolin::license::checkPAValidity $filePath];
	
	
	if {$ret == 0} {
		
		set log_filepath [::antolin::pam_thickness::GetLogPath [file join $::antolin::pam_thickness::scriptDir log_config.txt]];

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
		
		#::antolin::pam_thickness::assignElementToComponentThickness;
		
		::antolin::pam_thickness::gui;
		
		
	} elseif {$ret == 1} {
		tk_messageBox -message "Automation validity is over. Kindly contact 'Antolin Design and Business Services Pvt Ltd'" -icon error;
		return;
	} else {
		tk_messageBox -message "Kindly check your internet connection and try again" -icon error;
		return;
	}
}

::antolin::pam_thickness::main




