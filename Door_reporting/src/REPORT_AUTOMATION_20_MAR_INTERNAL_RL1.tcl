# %  procomp C:\\HM_COMMAND\\ENC\\*.tcl
#https://2021.help.altair.com/2021/hwdesktop/hwd/topics/reference/tcl/poimodel_addselectionset.htm
#https://10.185.32.86:4443/pbsworks/jobs?sortColumn=jobId&sortDirection=DSC&pageNumber=1
#https://10.185.32.86:4443/pbsworks/login
# REN_4EVER_HT_ABS_RL1_LH_RT_CPU_SR_150N_F_1.odb,10000292
# C:\REPORT
# 73540423

# el 1000147 
# node 1000165
# C:\AREPTRIAL\FDT_WITH_DIW_NAME_MODIFIED
# 110_IMPACTOR_TO_DT
#  Translational_Displacement_Local-X
# Impactor_Local_displacement
# RETAINER_CLIPS_XXRET,METAL_CLIPS_XXRET,RIBWELDS_XXRET,


#proc ::GA_Report::ListGenerate {entityList mapEntityRow} 
#::GA_Report::sessionload $report_pagetype_list $::GA_Report::c3var $client_choice $product_choice 
#::GA_Report::load_page_extract
#::GA_Report::page_loader called by button after load page extract.
# calls the page masters.

# ########## REPORT ###############################3
# BUTTON CALLS
#::GA_Report::top_image_optional_to_do

# ::GA_Report::Generate_python_head
#::GA_Report::image_generate
# call image master page ::GA_Report::image_wr_master_page_2 
# call image master code page ::GA_Report::py_wr_master_page_2_master_code


# a-surface strain pam crash proper input file required, dyna slow performance. 

# F vs D - check pam crash and dyna performance.



# Unit systems- check all possibilities
# add energy curve page - added abaqus, pamcrash support pending -NEEDS INPUT FILES FOR THAT.

#top image add option to avoid


# ############################### REVISION 2 ###########################


# maybe , focus the stress on hotspot
# material read from input files - This will depend on performance on obsolete hardware
# enhance language translator.
# genesis integration.

# ######################################################################




if {[namespace exists ::GA_Report]} {
	namespace delete ::GA_Report
}

namespace eval ::GA_Report {
	set ::GA_Report::helpDoc [file join [file dirname [info script]] REPORT_AUTOMATION_USER_MANUAL_V_1_0.pdf];
}

namespace eval ::GA_Report {
    namespace export configure gettime server cleanup

    variable options
    if {![info exists options]} {
        array set options {
            -timeserver {}
            -port       37
            -protocol   tcp
            -timeout    10000
            -command    {}
            -loglevel   warning
        }
        if {![catch {package require udp}]} {
            set options(-protocol) udp
        } else {
            if {![catch {package require ceptcl}]} {
                set options(-protocol) udp
            }
        }
        #log::lvSuppressLE emergency 0
        #log::lvSuppressLE $options(-loglevel) 1
        #log::lvSuppress $options(-loglevel) 0
    }

    # Store conversions for other epochs. Currently only unix - but maybe
    # there are some others out there.
    variable epoch
    if {![info exists epoch]} {
        array set epoch {
            unix 2208988800
        }
    }

    # The id for the next token.
    variable uid
    if {![info exists uid]} {
        set uid 0
    }
}

########################################## GUI START #########################################
variable pArr
variable cbState 
set cbState(empty) 1
set cbState(unused) 1
set cbState(cleanAss) 1
set pArr(entityList) [list]
variable mapEntityRow [list]

proc ::GA_Report::GUI_Launch {} {

	variable pathSelection
	variable fileSelection
	variable nameSelection
	variable Load_type_report
	variable Impact_type_report
	variable i_exportText
	variable i_exportMVW

	variable pArr
	variable cbState
	variable mapEntityRow 

	set padX 10
	set padY 2

	#top window
	set ui(topWindow) [hwt::CreateWindow .mytoplevel \
		-windowtitle "Report Automation" \
		-noGeometrySaving \
		-post];
	
	set x [expr {([winfo screenwidth .]-[winfo width .mytoplevel])/2}]
	set y [expr {([winfo screenheight .]-[winfo height .mytoplevel])/2}]
	#wm geometry  .mytoplevel +$x+$y
	wm geometry  .mytoplevel +10+10
	wm resizable .mytoplevel 0 0
	wm transient .mytoplevel .
	wm deiconify .mytoplevel
	
	set ui(mainFrame) [frame $ui(topWindow).a ]
	pack $ui(mainFrame) -fill both -expand false -side top

	set ui(subFrame3) [frame $ui(mainFrame).b ]
	pack $ui(subFrame3) -fill both -expand true -pady 4

	set ui(subFrame2) [frame $ui(mainFrame).c ]
	pack $ui(subFrame2) -fill both -expand true -pady 4

	set ui(optionframe) [frame $ui(mainFrame).d ]
	pack $ui(optionframe) -fill both -expand true -pady 4

	set ui(optionframe1) [frame $ui(mainFrame).e ]
	pack $ui(optionframe1) -fill both -expand true -pady 4

	set ui(optionframe11) [frame $ui(mainFrame).f ]
	pack $ui(optionframe11) -fill both -expand true -pady 4

	set ui(optionframe21) [frame $ui(mainFrame).g ]
	pack $ui(optionframe21) -fill both -expand true -pady 4


	set ui(optionframe22) [frame $ui(mainFrame).g1 ]
	pack $ui(optionframe22) -fill both -expand true -pady 4
	
	
	set ui(subFrame10) [frame $ui(mainFrame).h ]
	pack $ui(subFrame10) -fill both -expand true -pady 4


	set ui(optionframe2) [frame $ui(mainFrame).i ]
	pack $ui(optionframe2) -fill both -expand true -pady 4


	set ui(optionframe3) [frame $ui(mainFrame).j ]
	pack $ui(optionframe3) -fill both -expand false -pady 4


	set ui(subFrame11) [frame $ui(mainFrame).k ]
	pack $ui(subFrame11) -fill both -expand true -pady 4

	set ui(optionframe4) [frame $ui(mainFrame).m ]
	pack $ui(optionframe4) -fill both -expand true -pady 4

	set ui(optionframe41) [frame $ui(mainFrame).n ]
	pack $ui(optionframe41) -fill both -expand true -pady 4

	set ui(optionframe5) [frame $ui(mainFrame).p ]
	pack $ui(optionframe5) -fill both -expand true -pady 4
	
	set ui(optionframe6) [frame $ui(mainFrame).r ]
	pack $ui(optionframe6) -fill both -expand true -pady 4
	
	set ui(optionframe7) [frame $ui(mainFrame).s ]
	pack $ui(optionframe7) -fill both -expand true -pady 4

	set ui(subFrame1) [frame $ui(mainFrame).q ]
	pack $ui(subFrame1) -fill both -expand true -pady 4


	#set ui(labelFrame003) [hwtk::labelframe $ui(mainFrame).labelFrame003 -text "Select solver"]
	#set c3var Abaqus_S
	set solver_names { Abaqus_S Abaqus_E LsDyna PamCrash Radioss Optistruct   }
	set ::GA_Report::c3var [lindex $solver_names 0]

	set c4var Renault
	set client_names { Renault Skoda VW Porsche Audi JLR Nissan Tata   }

	set c5var Doors
	set product_names { Doors Pillars Cockpit Headliner WR Generic   }

	#set c6var TON_mm_S_N_Mpa
	set unit_names { TON_mm_S_N_Mpa KG_mm_MS_KN_GPa KG_mm_S_Mn_KPa G_mm_s_-MN_Pa G_mm_MS_N_Mpa   }
	set ::GA_Report::c6var [lindex $unit_names 0]
	
	#label frame
	set ui(labelFrame002) [hwtk::labelframe $ui(subFrame2).labelFrame002 -text "Select the Result Directory"]
	pack $ui(labelFrame002)  -fill both   -expand true
	pack [button $ui(labelFrame002).rbe6 -text "1. Choose Directory"  -font {Helvetica 8 bold} -command {::GA_Report::File_open  }] -side left -expand true 
	pack [button $ui(labelFrame002).rbe61 -text "2. Extract Data"  -font {Helvetica 8 bold} -command {::GA_Report::File_load  }] -side left -expand true
	pack [button $ui(labelFrame002).rbe63 -text "3. Load Files to Format"  -font {Helvetica 8 bold} -command {::GA_Report::page_loader  }] -side left -expand true
	pack [button $ui(labelFrame002).rbe62 -text "4. Generate Misc Images"  -font {Helvetica 8 bold} -command {::GA_Report::top_image_optional_to_do  }] -side left -expand true
    

	set ui(labelFrame001) [hwtk::label $ui(subFrame2).labelFrame001 -text " Choose the result files"]
	pack $ui(labelFrame001)  -fill both   -expand true  -padx 4 -pady 1


	#set ui(labelFrame0021) [hwtk::label $ui(subFrame3).labelFrame0021 -text "        g               "  ]
	set ui(labelFrame003) [hwtk::label $ui(subFrame3).labelFrame003 -text "Solver"  ]
	set ui(labelFrame0031) [hwtk::combobox $ui(subFrame3).labelFrame0031 -textvariable ::GA_Report::c3var -width 15 -state readonly \
	-values $solver_names] 
	set ui(labelFrame004) [hwtk::label $ui(subFrame3).labelFrame004 -text "Client "  ]
	set ui(labelFrame0041) [hwtk::combobox $ui(subFrame3).labelFrame0041 -textvariable ::GA_Report::c4var -width 12 -state readonly \
	-values $client_names -state disabled] 
	set ui(labelFrame005) [hwtk::label $ui(subFrame3).labelFrame005 -text "Product"  ]
	set ui(labelFrame0051) [hwtk::combobox $ui(subFrame3).labelFrame0051 -textvariable ::GA_Report::c5var -width 12 -state readonly \
	-values $product_names -state disabled] 
	set ui(labelFrame006) [hwtk::label $ui(subFrame3).labelFrame006 -text "Units"  ]
	set ui(labelFrame0061) [hwtk::combobox $ui(subFrame3).labelFrame0061 -textvariable ::GA_Report::c6var -width 20 -state readonly -values $unit_names]


	pack $ui(labelFrame003) $ui(labelFrame0031) -side left  -expand false  -padx 4 -pady 0
	pack $ui(labelFrame004) $ui(labelFrame0041) -side left  -expand false  -padx 4 -pady 0
	pack $ui(labelFrame005) $ui(labelFrame0051) -side left -expand false  -padx 4 -pady 0
	pack $ui(labelFrame006) $ui(labelFrame0061) -side left -expand false  -padx 4 -pady 0


	set ::GA_Report::cbState(empty1) 0
	set ::GA_Report::cbState(empty2) 0
	set ::GA_Report::cbState(empty3) 0
	set ::GA_Report::cbState(empty4) 0
	set ::GA_Report::cbState(empty5) 0
	set ::GA_Report::cbState(empty6) 0
	set ::GA_Report::cbState(empty7) 0
	set ::GA_Report::cbState(empty8) 0
	set ::GA_Report::cbState(empty9) 0
	set ::GA_Report::cbState(empty10) 0
	set ::GA_Report::cbState(empty11) 0
	set ::GA_Report::cbState(empty12) 0
	# set ::GA_Report::cbState(empty13) 0
	set ::GA_Report::cbState(empty14) 0
	set ::GA_Report::cbState(empty15) 0
	set ::GA_Report::cbState(empty16) 0
	set ::GA_Report::cbState(empty17) 0
	set ::GA_Report::cbState(empty18) 0
	set ::GA_Report::cbState(empty19) 0
	set ::GA_Report::cbState(empty20) 0
	set ::GA_Report::cbState(empty21) 0
	set ::GA_Report::cbState(empty22) 0
	set ::GA_Report::cbState(empty23) 0
	set ::GA_Report::cbState(empty24) 0

	set ui(labelFrame006) [hwtk::label $ui(optionframe).labelFrame006 -text " Select page options " ]
	pack $ui(labelFrame006) -fill x   -expand false -side top -padx 4 -pady 2
	
	set ui(checkButton1)  [eval list [hwtk::checkbutton $ui(optionframe).ck1 -text "Load Master\t\t" -help "Generic page for loads , 3 window format with curve" -variable ::GA_Report::cbState(empty1)]];
	pack $ui(checkButton1) -side left -fill x -expand false -padx 4 -pady 2
	################################################################################################################

	#checkbutton: empty
	set ui(checkButton2)  [eval list [hwtk::checkbutton $ui(optionframe).ck2 -text "Impact Master\t\t" -help "Generic page for Impact , 2 window format without curve" -variable ::GA_Report::cbState(empty2)]];
	pack $ui(checkButton2) -side left -fill x -expand false -padx 4 -pady 2
	################################################################################################################

	#checkbutton: clean assembly hierarchy
	set ui(checkButton3)  [eval list [hwtk::checkbutton $ui(optionframe).ck3 -text "FD and Energy\t\t" -help "Page for Side Crash with corridor Data." -variable ::GA_Report::cbState(empty3)]];
	pack $ui(checkButton3) -side left -fill x -expand false -padx 4 -pady 2

	set ui(checkButton4)  [eval list [hwtk::checkbutton $ui(optionframe).ck4 -text "Stress Plot Parts\t\t" -help "Page for Partwise Stress reporting." -variable ::GA_Report::cbState(empty4)]];
	pack $ui(checkButton4) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton5)  [eval list [hwtk::checkbutton $ui(optionframe).ck5 -text "Strain Plot Parts\t\t" -help "Page for Partwise Strain reporting." -variable ::GA_Report::cbState(empty5)]];
	pack $ui(checkButton5) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton6)  [eval list [hwtk::checkbutton $ui(optionframe1).ck6 -text "A-Surface Strain\t\t" -help "Page for A-Surface Strain reporting." -variable ::GA_Report::cbState(empty6)]];
	pack $ui(checkButton6) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton7)  [eval list [hwtk::checkbutton $ui(optionframe1).ck7 -text "Local Impact\t\t" -help "Page for Parts similar to grills." -variable ::GA_Report::cbState(empty7)]];
	pack $ui(checkButton7) -side left -anchor sw -fill x -expand false -padx 4 -pady 1
	
	set ui(checkButton8)  [eval list [hwtk::checkbutton $ui(optionframe1).ck8 -text "Retainer Force\t\t" -help "Page with Retainer force labels and curves."\
	-variable ::GA_Report::cbState(empty8) -command ::GA_Report::callback_retainerForce]];
	pack $ui(checkButton8) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton9)  [eval list [hwtk::checkbutton $ui(optionframe1).ck9 -text "Screw Forces\t\t" -help "Page with Screw force labels and curves."\
	-variable ::GA_Report::cbState(empty9) -command ::GA_Report::callback_screwForce]];
	pack $ui(checkButton9) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton10)  [eval list [hwtk::checkbutton $ui(optionframe1).ck10 -text "Heat Stake forces\t\t" -help "Page with Heat Stake force labels and curves."\
	-variable ::GA_Report::cbState(empty10) -command ::GA_Report::callback_heatStakeForce]];
	pack $ui(checkButton10) -side left -fill x -expand false -padx 4 -pady 1
	
	#set ui(checkButton11)  [eval list [hwtk::checkbutton $ui(optionframe1).ck11 -text "Sun Exposure" -help "Page with Heat Stake force labels and curves." -variable ::GA_Report::cbState(empty11)]];
	#pack $ui(checkButton11) -side left -fill x -expand true -padx 1 -pady 1

	set ui(checkButton12)  [eval list [hwtk::checkbutton $ui(optionframe11).ck12 -text "Reserved\t\t" -help "Reserved for additional plots." \
	-variable ::GA_Report::cbState(empty12) -state disabled]];
	pack $ui(checkButton12) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton13)  [eval list [hwtk::checkbutton $ui(optionframe11).ck13 -text "SE Master\t\t" -help "Sunexposure master page." -variable ::GA_Report::cbState(empty11)]];
	pack $ui(checkButton13) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton14)  [eval list [hwtk::checkbutton $ui(optionframe11).ck14 -text "SE Assembly\t\t" -help "Sun exposure assembly." -variable ::GA_Report::cbState(empty14)]];
	pack $ui(checkButton14) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton15)  [eval list [hwtk::checkbutton $ui(optionframe11).ck15 -text "SE Parts\t\t" -help "Sunexposure for each parts." -variable ::GA_Report::cbState(empty15)]];
	pack $ui(checkButton15) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton16)  [eval list [hwtk::checkbutton $ui(optionframe11).ck16 -text "Reserved\t\t" -help "Reserved for additional plots." -variable ::GA_Report::cbState(empty16) -state disabled]];
	pack $ui(checkButton16) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton17)  [eval list [hwtk::checkbutton $ui(optionframe21).ck17 -text "Swap F-D\t\t" -help "Force Vs Displacement plots.Default is D-F" -variable ::GA_Report::cbState(empty17)]];
	pack $ui(checkButton17) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton18)  [eval list [hwtk::checkbutton $ui(optionframe21).ck18 -text "Swap Ang-Mom\t\t" -help "Angle vs Moment in plots. Default is M-A" -variable ::GA_Report::cbState(empty18)]];
	pack $ui(checkButton18) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton19)  [eval list [hwtk::checkbutton $ui(optionframe21).ck19 -text "WR-Master\t\t" -help "Window regulator- Animation and displacement plot." \
	-variable ::GA_Report::cbState(empty19) -state disabled]];
	pack $ui(checkButton19) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton20)  [eval list [hwtk::checkbutton $ui(optionframe21).ck20 -text "WR-BIW\t\t" -help "BIW animation and stress plots for Window Regulators." \
	-variable ::GA_Report::cbState(empty20) -state disabled]];
	pack $ui(checkButton20) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton21)  [eval list [hwtk::checkbutton $ui(optionframe21).ck21 -text "WR-Parts\t\t" -help "Parts Stress and ISO." \
	-variable ::GA_Report::cbState(empty21) -state disabled]];
	pack $ui(checkButton21) -side left -fill x -expand false -padx 4 -pady 1
	
	set ui(checkButton22)  [eval list [hwtk::checkbutton $ui(optionframe22).ck22 -text "LT Remove View\t\t" -help "Removes auto view." -variable ::GA_Report::cbState(empty22)]];
	pack $ui(checkButton22) -side left -fill x -expand false -padx 4 -pady 1
	
	set ui(checkButton23)  [eval list [hwtk::checkbutton $ui(optionframe22).ck23 -text "LT RF Plot\t\t" -help "Removes auto view." -variable ::GA_Report::cbState(empty23)]];
	pack $ui(checkButton23) -side left -fill x -expand false -padx 4 -pady 1

	set ui(checkButton24)  [eval list [hwtk::checkbutton $ui(optionframe22).ck24 -text "LT Signed Vonmises\t\t" -help "Signed Vonmises." -variable ::GA_Report::cbState(empty24)]];
	pack $ui(checkButton24) -side left -fill x -expand false -padx 4 -pady 1

                   
	#set ui(labelFrame0072) [hwtk::labelframe $ui(subFrame10).labelFrame0072 -text "Please type in Master nodes, BIW and RBE exclude strings "]
	#pack $ui(labelFrame0072) -fill both   -expand true 	

	set ui(labelFrame007) [hwtk::label $ui(optionframe2).labelFrame007 -text "Master Node Id (Optional) : "  ]
	set ui(labelFrame008) [hwtk::label $ui(optionframe2).labelFrame008 -text "Force,Energy (in N, mJ) : "  ]
	set ui(labelFrame009) [hwtk::label $ui(optionframe2).labelFrame009 -text "A-Surface ID : "  ]

	set ui(labelFrame0071) [entry $ui(optionframe2).labelFrame0071 -text "" -textvariable ::GA_Report::user_master_id -width 15]
	set ui(labelFrame0081) [entry $ui(optionframe2).labelFrame0081 -text "" -textvariable ::GA_Report::force_energy_string -width 15]
	set ui(labelFrame0091) [entry $ui(optionframe2).labelFrame0091 -text "" -textvariable ::GA_Report::user_rbe_string -width 15]

	pack $ui(labelFrame007) $ui(labelFrame0071) $ui(labelFrame008) $ui(labelFrame0081) $ui(labelFrame009) $ui(labelFrame0091)  -side left

	set ui(labelFrame010) [hwtk::label $ui(optionframe3).labelFrame010 -text "Retainer Strings ( Use Comma , in between strings and at the end )"  ]
	set ui(labelFrame011) [hwtk::label $ui(optionframe3).labelFrame011 -text "HT Strings ( Use Comma , in between strings and at the end )"  ]
	set ui(labelFrame012) [hwtk::label $ui(optionframe3).labelFrame012 -text "Screw Strings ( Use Comma , in between strings and at the end )"  ]

	set ui(labelFrame00101) [entry $ui(optionframe3).labelFrame00101 -text "" -textvariable ::GA_Report::retainer_strings -width 100 -state disabled]
	set ui(labelFrame00111) [entry $ui(optionframe3).labelFrame00111 -text "" -textvariable ::GA_Report::ht_strings -width 100 -state disabled]
	set ui(labelFrame00121) [entry $ui(optionframe3).labelFrame00121 -text "" -textvariable ::GA_Report::screw_strings -width 100 -state disabled]

	pack $ui(labelFrame010)  -fill both   -expand false -side top -padx 4 -pady 2
	pack $ui(labelFrame00101) -fill both   -expand false -side top -padx 4 -pady 2
	pack $ui(labelFrame011)  -fill both   -expand false -side top -padx 4 -pady 2
	pack $ui(labelFrame00111)  -fill both   -expand false -side top -padx 4 -pady 2
	pack $ui(labelFrame012) -fill both   -expand false -side top -padx 4 -pady 2
	pack $ui(labelFrame00121) -fill both   -expand false -side top -padx 4 -pady 2
	
	variable retainerStrings [set ui(labelFrame00101)]
	variable heatStackStrings [set ui(labelFrame00111)]
	variable screwString [set ui(labelFrame00121)]

	#set ui(labelFrame0073) [hwtk::labelframe $ui(subFrame11).labelFrame0073 -text "Please Part exclude sub Strings "]
	#pack $ui(labelFrame0073) -fill both   -expand true 


	#set ui(labelFrame020) [hwtk::label $ui(optionframe4).labelFrame020 -text "Part wise Strain and stress Strings ( Use Comma , in between strings and at the end )" ]



	set ui(labelFrame00201) [entry $ui(optionframe4).labelFrame00201 -text "" -textvariable ::GA_Report::strain_stress_strings -width 100 ]

	#pack $ui(labelFrame020) $ui(labelFrame00201) $ui(labelFrame021) $ui(labelFrame00211) $ui(labelFrame022) $ui(labelFrame00221) -side left

	#pack $ui(labelFrame020) 
	#pack $ui(labelFrame00201) 


	set ui(labelFrame021) [hwtk::label $ui(optionframe41).labelFrame021 -text "Contact Name (F-D)"  ]
	set ui(labelFrame00211) [entry $ui(optionframe41).labelFrame00211 -text "" -textvariable ::GA_Report::contact_pair_name -width 20]

	set ui(labelFrame0211) [hwtk::label $ui(optionframe41).labelFrame0211 -text "Tool Element ID"  ]
	set ui(labelFrame002111) [entry $ui(optionframe41).labelFrame002111 -text "" -textvariable ::GA_Report::tool_element_id -width 20]
	
	set ui(labelFrame0212) [hwtk::label $ui(optionframe41).labelFrame0212 -text "Supplier Name"  ]
	set ui(labelFrame002112) [entry $ui(optionframe41).labelFrame002112 -text "" -textvariable ::GA_Report::supplier_name -width 20]

	pack $ui(labelFrame021) -side left
	pack $ui(labelFrame00211) -side left
	pack $ui(labelFrame0211) -side left
	pack $ui(labelFrame002111) -side left
	pack $ui(labelFrame0212) -side left
	pack $ui(labelFrame002112) -side left
	#$ui(labelFrame00211) $ui(labelFrame0211) $ui(labelFrame002111) $ui(labelFrame0212) $ui(labelFrame002112) -side left 

	set ui(labelFrame0310) [hwtk::label $ui(optionframe5).labelFrame0310 -text "Local Impact Name"  ]
	set ui(labelFrame0320) [entry $ui(optionframe5).labelFrame0320 -text "" -textvariable ::GA_Report::grill_comp_name -width 20]
	set ui(labelFrame0410) [hwtk::label $ui(optionframe5).labelFrame0410 -text "Master Report Dir"  ]
	set ui(labelFrame0420) [entry $ui(optionframe5).labelFrame0420 -text "" -textvariable ::GA_Report::report_folder_path -width 20]
	set ui(labelFrame0510) [hwtk::label $ui(optionframe5).labelFrame0510 -text "Work Order No" -relief solid  ] 
	set ui(labelFrame0520) [entry $ui(optionframe5).labelFrame0520 -text "" -textvariable ::GA_Report::work_order_number -width 20]

	pack $ui(labelFrame0310) $ui(labelFrame0320) $ui(labelFrame0510) $ui(labelFrame0520) $ui(labelFrame0410) $ui(labelFrame0420)  -side left

	set ui(labelFrame03100) [hwtk::label $ui(optionframe6).labelFrame03100 -text "  Admin"  -state disabled]
	set ui(labelFrame03200) [entry $ui(optionframe6).labelFrame03200 -text "" -textvariable ::GA_Report::admin_pass -width 30 -state disabled]
	set ui(labelFrame03201) [entry $ui(optionframe6).labelFrame03201 -text "" -textvariable ::GA_Report::decrypt_path -width 30 -state disabled]
	
	pack [button $ui(labelFrame03100).rbe14 -text "convert"  -command {::GA_Report::convert_files  } -state disabled] -side left -expand true 
	pack [button $ui(labelFrame03100).rbe15 -text "calculate"  -command {::GA_Report::calculate_files  } -state disabled] -side left -expand true
	
	pack $ui(labelFrame03100)  -fill both   -expand true -side left
	
	pack  $ui(labelFrame03200) $ui(labelFrame03201)  -side left
	
	
	#set ui(labelFrame03202) [hwtk::labelframe $ui(optionframe7).labelFrame03202 -text "Admin Panel"]
	
	set ui(labelFrame001011) [hwtk::labelframe $ui(subFrame1).labelFrame001011 -text "Choose actions"]
	pack $ui(labelFrame001011)  -fill both   -expand true -side top
	pack [button $ui(labelFrame001011).rbe10 -text "Publish Report" -font {Helvetica 8 bold} -command {::GA_Report::Generate_python_head  }] -side left -expand false -padx 8
	
	#pack [button $ui(labelFrame001011).rbe11 -text "Genesis(F)"  -font {Helvetica 8 bold} -command { destroy .mytoplevel  }] -side left -expand true 
	#pack [button $ui(labelFrame001011).rbe12 -text "Close"  -font {Helvetica 8 bold} -command { destroy .mytoplevel  }] -side left -expand true 
	pack [button $ui(labelFrame001011).rbe13 -text "        Help        " -font {Helvetica 8 bold} -command {::GA_Report::Help_open  } -justify center] -side right -expand false -padx 8 

	# -----------------------------------------------------------------
	#show a select list
	# -----------------------------------------------------------------

	set ::GA_Report::report_folder_path {C:\REPORT}

	#set entityList {Solids Surfs Lines Points Elems Connectors Systems Loads Vectors Equations Tags Groups}

}

proc ::GA_Report::callback_retainerForce { } {
	variable retainerStrings 
			
	if {$::GA_Report::cbState(empty8) == 1} {
		$retainerStrings configure -state normal;
	} else {
		$retainerStrings configure -state disabled;
	}
}

proc ::GA_Report::callback_screwForce { } {
	variable screwString
	
	if {$::GA_Report::cbState(empty9) == 1} {
		$screwString configure -state normal;
	} else {
		$screwString configure -state disabled;
	}
}

proc ::GA_Report::callback_heatStakeForce { } {
	variable heatStackStrings
	
	if {$::GA_Report::cbState(empty10) == 1} {
		$heatStackStrings configure -state normal;
	} else {
		$heatStackStrings configure -state disabled;
	}
}

proc ::GA_Report::convert_files {} {

	if { $::GA_Report::admin_pass == "ap"} { 
 
		set log_list_name_only [glob -nocomplain -directory $::GA_Report::decrypt_path *.txt] 
		#puts $log_list_name_only
 
	} else {
		tk_messageBox -message "You are not an Admin it seems ,  contact roopesh.puthalath@grupoantolin.com" -type yesno
	
	}

	set b_slash {/}
	set f_slash {\\}
	set text_extension {.txt}
	set log_extension {log_file_}
	set decode_string "report_"
	

	foreach log_file_path $log_list_name_only  {
	
		set corrected_path [ regsub "$b_slash" $log_file_path "$f_slash" ]
		set text_file_name [file tail $corrected_path]
		
		set rest_of_path [ string trim $corrected_path "$text_file_name" ]
		
		
		set just_name [ string trim $text_file_name "$text_extension" ]
		#puts $just_name
		
		set time_only [ string trim $just_name "$log_extension" ]
		#puts $time_only
		
		set timestr [clock format $time_only -format "%y-%m-%d %H:%M:%S"]
		#puts $timestr 
		
		
		set decoded_file_path $rest_of_path$decode_string$time_only$text_extension
		set decoded_file_current [open "$decoded_file_path" w]
	
	
		#### # "##
		set enc_file_val [open $corrected_path]
		set enc_filevalues [read $enc_file_val]
		set enc_file_length [llength $enc_filevalues]
		

		set part_list_split [list]
		set load_list_split [list]

		set i 0
		set count_status 100
		
		while {$i <= [expr $enc_file_length -1]}  {

			set each_line [lindex $enc_filevalues $i]
			set decode_line [::GA_Report::decode $each_line]
			puts $decoded_file_current $decode_line

			incr i
			
		}
		#set page_saving [ expr { ( ($count_page -1) * 15 )   } ]
		#puts $decoded_file_current " savings_with_15min [format { %7g} $page_saving ] "
		
		close $decoded_file_current;
		close $enc_file_val;
		set count_page 0
	
	}

}

# proc ::GA_Report::convert_files_copy {} {

	# if { $::GA_Report::admin_pass == "ap"} { 
 
	# set log_list_name_only [glob -nocomplain -directory $::GA_Report::decrypt_path *.txt] 
	# #puts $log_list_name_only
 
	# } else {
	
	# tk_messageBox -message "You are not an Admin it seems ,  contact roopesh.puthalath@grupoantolin.com" -type yesno
	
	# }

	# set b_slash {/}
	# set f_slash {\\}
	# set text_extension {.txt}
	# set log_extension {log_file_}
	# set decode_string "report_"
	

	# foreach log_file_path $log_list_name_only  {
	
	
	# set corrected_path [ regsub "$b_slash" $log_file_path "$f_slash" ]
	# set text_file_name [file tail $corrected_path]
	
	# set rest_of_path [ string trim $corrected_path "$text_file_name" ]
	
	
	# set just_name [ string trim $text_file_name "$text_extension" ]
	# #puts $just_name
	
	# set time_only [ string trim $just_name "$log_extension" ]
	# #puts $time_only
	
	# set timestr [clock format $time_only -format "%y-%m-%d %H:%M:%S"]
	# #puts $timestr 
	
	
	# set decoded_file_path $rest_of_path$decode_string$time_only$text_extension
	# set decoded_file_current [open "$decoded_file_path" w]
	
	
# #### # "##
		# set enc_file_val [open $corrected_path]
		# set enc_filevalues [read $enc_file_val]
		# set enc_file_length [llength $enc_filevalues]
		

		# set part_list_split [list]
		# set load_list_split [list]

		# set i 0
		# set count_status 100
		
		# while {$i <= [expr $enc_file_length -1]}  {

			# set each_line [lindex $enc_filevalues $i]
			# set decode_line [::GA_Report::decode $each_line]
			# puts $decoded_file_current $decode_line
			
			# set start_val  [ lindex $decode_line 0 ]
			
			# if { $i > 0 } {
				# if { ($start_val == "internal" ) || ($start_val == "supplier" ) } {
			
					# if { $count_status < 400 } {
						# set count_page $i
						# set count_status 500
					# }
			
				# }
			
			# }
				# if { $i == 0 } {
			
				# set tag1 [ lindex $decode_line 0 ]
				# set tag2 [ lindex $decode_line 1 ]
			
				# set time1 [ lindex $decode_line 2 ]
				# set time2 [ lindex $decode_line 3 ]
				# set time3 [ lindex $decode_line 4 ]
				# set time4 [ lindex $decode_line 5 ]
			
				# set total_time [ expr { ( $time2 - $time1 ) + ( $time4 - $time3 ) } ]
			
				# puts $decoded_file_current " Automation_wallclock $total_time "
			
				# }
			
			
			
			
			# #puts $decode_line
			
			# # need to get the time converted and printed in each file last line
			# # need to calculate total time for each page 
			# # need to add more time for curve plots 
			# # would be ideal if the files generated are suited for node-red
			
			
			
			
			
			# incr i
			
			# }
		# set page_saving [ expr { ( ($count_page -1) * 15 )   } ]
		# puts $decoded_file_current " savings_with_15min [format { %7g} $page_saving ] "
		
		# close $decoded_file_current;
		# close $enc_file_val;
		# set count_page 0
	
	# }



# }



########################################## GUI END #########################################	
# proc ::GA_Report::close_all {} {

# destroy .mytoplevel

# }
proc ::GA_Report::Security {} {


	set security [exec ping 10.30.241.59 -4]
	set recieved [lindex $security 45]


	if { $recieved == "4,"} {
		puts "security cleared"
		set security_tocken 100
	} else {

		puts "you are not authorised to use the software"
		tk_messageBox -message "You are not authorized to use the software" -type yesno

		#intentional error creation 

		*roopeshputhalath
	}

}


proc ::GA_Report::File_open {} {

	variable mapEntityRow 
    set ::GA_Report::mat_counter 1

    set ::GA_Report::file_open_start_time [clock seconds]
	set ::GA_Report::log_file_list [list]
	set ::GA_Report::top_image_counter 10
	
	
	if { $::GA_Report::supplier_function_activate > 5 } {
		if { $::GA_Report::supplier_name == ""} {
			tk_messageBox -message "You need to enter the Supplier Name to use the automation " -type yesno
			#set ::GA_Report::supplier_name "blank"
		}
	}

	if {($::GA_Report::work_order_number == "") || ($::GA_Report::supplier_name == "") } {
		tk_messageBox -message "you need to enter a Valid CAE workorder ID and Supplier name to use the automation, if you dont have one. Please contact your TCL ,A valid work order may read like this  , PURP-101 , PURP-2101101 etc " -type yesno
	} else {

		#global k2
		#global rbe6 
		#.mytoplevel.a.c.labelFrame002.rbe6 configure -background green
		global dir_Name
		set files_List [list]
		set ilist 0
		set slash_char "/"
		set dir_Name [tk_chooseDirectory -initialdir ~ -title "Choose a directory"]
		
		if {![file exists $dir_Name]} {
			tk_messageBox -message "Please select valid result directory" -icon error
			return
		}
		
		if { $::GA_Report::c3var == "LsDyna" } {
		
		    set ::GA_Report::dyna_d3plot_list [list]
			set ::GA_Report::dyna_folder_list [list]
			set slash_d3plot {/d3plot}
			
			set file_d3plot "d3plot"
			set dyna_dir_list [glob -directory $dir_Name -type d * ]
		
			foreach dyna_file $dyna_dir_list {
	
				set d3plot_line [concat $dyna_file$file_d3plot]
				lappend ::GA_Report::dyna_d3plot_list $d3plot_line
				
				set folder_name_split [split $dyna_file  /]
				set length_of_filepath [ llength $folder_name_split ]
				set end_elem [ expr { $length_of_filepath - 1  }]
				set current_folder_name [ lindex $folder_name_split $end_elem ]
				
				lappend ::GA_Report::dyna_folder_list $current_folder_name$slash_d3plot
			}
		}
		
		set dir_Name_slash [concat $dir_Name$slash_char]
		set ::GA_Report::dir_slash $dir_Name_slash
		set ::GA_Report::dir_noslash $dir_Name
		puts $dir_Name_slash
				
        set ::GA_Report::dir_for_parts_list $::GA_Report::dir_noslash

		set files_list_name_only [list]

		if { $::GA_Report::c3var == "Abaqus_S" } { set files_list_name_only [glob -nocomplain -directory $dir_Name *.odb] }
		if { $::GA_Report::c3var == "PamCrash" } { set files_list_name_only [glob -nocomplain -directory $dir_Name *.erfh5] }
		if { $::GA_Report::c3var == "LsDyna" } { 
		
			#foreach result_data $dyna_dir_list { lappend files_list_name_only [glob -nocomplain -directory $result_data d3plot] }
		
		}

		if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
			
			set ::GA_Report::force_unit "N" 
			set ::GA_Report::length_unit "mm"
			set ::GA_Report::Force_label "Force (N)"
			set ::GA_Report::Displacement_label "Displacement(mm)"
			set ::GA_Report::time_unit "S" 
			set ::GA_Report::stress_unit "MPa"
			set ::GA_Report::force_multiplier 1
			set ::GA_Report::report_stress_multiplier 1
			
		}

		if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
			
			set ::GA_Report::force_unit "N" 
			set ::GA_Report::length_unit "mm"
			set ::GA_Report::Force_label "Force (N)"
			set ::GA_Report::Displacement_label "Displacement(mm)"
			set ::GA_Report::time_unit "mS"
			set ::GA_Report::stress_unit "MPa"
			set ::GA_Report::force_multiplier 1000
			set ::GA_Report::report_stress_multiplier 1000
			
		}

		if { $::GA_Report::c3var == "LsDyna" } { 
			set file_name_proper_sort $::GA_Report::dyna_folder_list
		} else { 


			set result_files_count [llength $files_list_name_only]

			while { $ilist < $result_files_count }  {

				set current_output [ lindex $files_list_name_only $ilist ]
				set current_output_full_name [ concat $dir_Name_slash$current_output ]
				lappend files_List $current_output_full_name

				incr ilist
			}
			
			global pg_count
			set pg_count [llength $files_List]
			set f_Num 0

			global names_only_List
			set i2 0
			set names_only_List [list]

			#puts [lindex $files_List 0]
			set ze [file tail [lindex $files_List 0]]

			global split_list

			while {$i2 < $pg_count}  {

					lappend names_only_list [file tail [lindex $files_List $i2]]
					set split_single [lindex $names_only_list $i2]
					lappend split_list [split $split_single  _]
					incr i2
			}


			#puts " Number of Result files"
			#puts "$pg_count"

			for {set i5 0} {$i5 < $pg_count} {incr i5} {
				# --------------file path set start------------------
				set file_num_name [lindex $files_List $i5]
				set filename1 $file_num_name
				# --------------file parh set end--------------------

				# ---------------file name set start-----------------
				set cur_file_name [lindex $split_list $i5]
				set cur_client_name [lindex $cur_file_name 0]
				set cur_proj_name [lindex $cur_file_name 1]
				set cur_prod_name [lindex $cur_file_name 2]
				set cur_solver_name [lindex $cur_file_name 3]
				set cur_stage_name [lindex $cur_file_name 4]
				set cur_side_name [lindex $cur_file_name 5]
				set cur_temp_name [lindex $cur_file_name 6]
				set cur_area_name [lindex $cur_file_name 7]
				set cur_load_name [lindex $cur_file_name 8]
				set cur_load_value_name [lindex $cur_file_name 9]
				set cur_function_name [lindex $cur_file_name 10]
				set cur_number_name [lindex $cur_file_name 11]

				set sort1_list [lsort -index 7 [lsort -index 8 [lsort -index 11 $split_list]]]
			}
						
			if {![info exists sort1_list]} {
				tk_messageBox -message "Selected directory doesn't contain correct result files, kindly confirm and select valid directory" -icon error
				return
			}

			#puts "sort1 list is"
			#puts $sort1_list


			set file_name_proper_sort [list]

			set i3 0
			while {$i3 < $pg_count}  {

				set sort_single [lindex $sort1_list $i3]
				set join_sort_single [ join $sort_single "_" ]
				set proper_name [ string map {_. .} $join_sort_single ]
				lappend file_name_proper_sort $proper_name

				set file_path_item [concat $dir_Name_slash$proper_name]
				lappend file_path_proper_sort $file_path_item

				incr i3
			}

			#puts "file name proper sort"
			#puts $file_name_proper_sort


			#puts "file path proper sort"
			#puts $file_path_proper_sort


			set ::GA_Report::sorted_list $file_path_proper_sort
		}

		set padX 10
		set padY 2

		set frame_update .mytoplevel.a.c.labelFrame001
		set ui(selectList) [hwtk::selectlist $frame_update.selectList -stripes 1 -selectmode multiple -selectcommand "::GA_Report::OnSelect %W %S %c"]

		$ui(selectList) columnadd entities -text Entities
		pack $ui(selectList) -side left -fill both -expand true -padx $padX -pady $padY

		set gRowCount 0
		foreach entity $file_name_proper_sort {
			$ui(selectList) rowadd row$gRowCount -values [list entities "$entity"]
			lappend mapEntityRow "row$gRowCount $entity"
			incr gRowCount
		}

		# workorder if terminates
		
		.mytoplevel.a.c.labelFrame002.rbe6 configure -background green
	}
	

}


# proc ::GA_Report::Page_type_001 {} {

	# global split_list
	# set com_001 {slide = prs.slides.add_slide(prs.slide_layouts[6])}
	# puts $outStr $com_001
	# puts $outStr "print('start')"



# }

proc ::GA_Report::OnSelect {W S c} {
	variable pArr
	puts "$W $S $c" 
	set pArr(entityList) $S

}


proc ::GA_Report::File_load {args} {

	variable pArr
	variable cbState
	variable mapEntityRow 
	
	set pageOptionSelection 0;
	foreach pageOption [array names ::GA_Report::cbState] {
		if {[set ::GA_Report::cbState($pageOption)] == 1} {
			set pageOptionSelection 1;
		}
	}
	
	if {![info exists pArr(entityList)] || [llength $pArr(entityList)] == 0} {
		tk_messageBox -message "Please select valid input result(s)" -icon error
		return
	}
	
	if {$pageOptionSelection == 0} {
		tk_messageBox -message "Please select valid page option(s)" -icon error
		return
	}
	
	::GA_Report::ListGenerate $pArr(entityList) $mapEntityRow
	
	.mytoplevel.a.c.labelFrame002.rbe61 configure -background green
	#hwt::PopdownWorkingWindow
}


proc ::GA_Report::sessionload { report_pagetype_list_passed sol_choice } {

    set ::GA_Report::partwise_stress [list]

	hwi GetSessionHandle master_session 
	master_session SetUnitsProfile DEFAULT	
	master_session SetUserVariable SHOWUNITSDIALOG 0
	master_session GetProjectHandle master_project
	
	master_session GetMessageLogHandle msgLog;
    msgLog DisableAutopost;


	# ##################### DEFINE PAGE STRUCTURE START ##############################


	set hyperview_list [list]
	set pg_count [llength $report_pagetype_list_passed]
	#puts " page count"
	#puts $pg_count

	set hyperview_page_count 0
	set un_score _

	foreach page_input $report_pagetype_list_passed {

		if { $page_input == "loadmaster" } {                                           

			set page_id_master ldidmaster_4
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member


			set page_id_slave id_ldbiwslave_1
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_slave$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "impactmaster" } {                                           

			set page_id_master immaster_1
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member


			set page_id_slave id_imbiwslave_1
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_slave$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "fdenergy" } {                                           

			set page_id_master fdmaster_1
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "retainerforce" } {                                           

			set page_id_master retainermaster_3
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "screwforce" } {                                           

			set page_id_master screwmaster_3
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "htforce" } {                                           

			set page_id_master htforcemaster_3
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "sunexposure" } {                                           

			set page_id_master sunexpsoure_9
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}
		
		if { $page_input == "sunexposure_assembly" } {                                           

			set page_id_master sunexpsoure_assembly
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}
		
		if { $page_input == "sunexposure_parts" } {                                           

			set page_id_master sunexpsoure_parts
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "asurfacestrain" } {                                           

			set page_id_master asurfacestrain_10
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

        if { $page_input == "wrmaster" } {                                           

			set page_id_master wr_master
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "wrbiw" } {                                           

			set page_id_master wr_biw
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}

		if { $page_input == "wrparts" } {                                           

			set page_id_master wr_parts
			incr hyperview_page_count
			set page_number_add_member [concat $page_id_master$un_score$hyperview_page_count]
			lappend hyperview_list $page_number_add_member

		}


	}	

	#puts $hyperview_list
	set ::GA_Report::select_page_list $hyperview_list

	# ##################### DEFINE PAGE STRUCTURE END ##############################

	::GA_Report::load_page_extract

}

proc ::GA_Report::load_page_extract { } {

    hwt::PopupWorkingWindow "Loading Results..Processing Files...."

	if { $::GA_Report::cbState(empty1) == 1} { 
		set ::GA_Report::load_master_list [list]
		set line1 "LOC_NUM ,FILE_NAME ,TEMP, AREA ,LOAD , TOOL ,FORCE, LIMIT, X, Y ,Z, TOOL_MAX, TRIM_MAX ,PERM_TRIM ,BIW_MAX" 
		lappend ::GA_Report::load_master_list $line1	
		#set ::GA_Report::x_list [list]
		#set ::GA_Report::y_list [list]
		#set ::GA_Report::z_list [list]

	} 
	
	if { $::GA_Report::cbState(empty2) == 1} { 
		set ::GA_Report::impact_master_list [list]
		set line1 "LOC_NUM, FILE_NAME ,TEMP, AREA ,LOAD , TOOL, FORCE, LIMIT, X ,Y ,Z ,TRIM_MAX ,PERM_TRIM ,BIW_MAX" 
		lappend ::GA_Report::impact_master_list $line1	
	}

	if { $::GA_Report::cbState(empty2) == 1} { 
		set ::GA_Report::sunexposure_master_list [list]
		set line1 "FILENAME, AREA , LOAD_CASE_DESCRIPTION , LOADING_TARGET , UNLOADING_TARGET ,LOADING_DISPLACEMENT ,UNLOADING_DISPLACEMENT, LOADING_DISPLACEMENT_X , UNLOADING_DISPLACEMENT_X , LOADING_DISPLACEMENT_Y , UNLOADING_DISPLACEMENT_Y,LOADING_DISPLACEMENT_Z ,UNLOADING_DISPLACEMENT_Z" 
		lappend ::GA_Report::sunexposure_master_list $line1	
	}
	
	set total_files_count [llength $::GA_Report::selected_files_list]


	set list_of_parts_seperated_all [list]
	set list_of_parts_seperated_listed [list] 
	set result_itr 1
	set underscore "_"
	set page_Num 1
	set pg_hand_base pg
	set pg_hand_itr 1

	set win_hand_base win
	set win_hand_itr 1

	set anim_hand_base anim
	set anim_hand_itr 1

	set plot_hand_base plot
	set plot_hand_itr 1

	set id_hand_base id
	set id_hand_itr 1

	set mod_hand_base mod
	set mod_hand_itr 1

	set res_hand_base res
	set res_hand_itr 1

	set cont_hand_base cont
	set cont_hand_itr 1


	set numsim_hand_base numsim
	set numsim_hand_itr 1

	set numind_hand_base numind
	set numind_hand_itr 1

	set lgd_hand_base lgd
	set lgd_hand_itr 1

	set cur_hand_base cur
	set cur_hand_itr 1

	set note_hand_base note
	set note_hand_itr 1

	set xaxis_hand_base xaxis
	set xaxis_hand_itr 1

	set yaxis_hand_base yaxis
	set yaxis_hand_itr 1



	set page_number 1
	set image_name pageplot
	set image_name_counter 1
	set format .gif

	#   sel hand defenitions	

	set mask_sel_hand_base mask_sel
	set mask_sel_hand_itr 1

	set unmask_sel_hand_base unmask_sel
	set unmask_sel_hand_itr 1

	set full_sel_hand_base full_sel
	set full_sel_hand_itr 1

	set elem_sel_hand_base elem_sel
	set elem_sel_hand_itr 1
	#
	set t 1
	set result_wise_list [list]

	#puts "upto for loop done"

	set for_sel_base for_sel
	set for_sel_hand_itr 1

	set for_qu_base for_qu
	set for_qu_hand_itr 1

	set for_result_base for_result
	set for_result_hand_itr 1

	set for_coun_base for_coun
	set for_coun_hand_itr 1

	set for_itr_base for_itr
	set for_itr_hand_itr 1


	set solver_choice $::GA_Report::c3var
	#set client_choice $::GA_Report::c4var
	#set product_choice $::GA_Report::c5var

	set top_image_counter 1
	set ::GA_Report::top_image_file_list [list]

	if { $::GA_Report::c3var == "Abaqus_S" } {			
					
	   if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id

		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"

		#puts "solver is abaqus -setting values"
		set ::GA_Report::solver_extension ".odb"
		set ::GA_Report::plot_disp_datatype "Displacement"
		
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
		set ::GA_Report::strain_datatype "PE-Global-Plastic strain components IP"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "vonMises"
		
		set ::GA_Report::curve_disp_datatype "Displacement"
		set ::GA_Report::curve_force_datatype "CF-Point loads"
		
		set ::GA_Report::x_curve_comp "MAG"
		set ::GA_Report::y_curve_comp "MAG"
		set ::GA_Report::x_curve_request $::GA_Report::n_master_id
		set ::GA_Report::y_curve_request $::GA_Report::n_master_id

		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		#set ::GA_Report::x_joint_request_type "E$retainer_type_elem"
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		#set ::GA_Report::y_joint_request_type "E$retainer_type_elem"
		set ::GA_Report::y_joint_component_type "Value"		
					
	}

	if { $::GA_Report::c3var == "PamCrash" } {


	   if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"

		#puts "solver is Pamcrash -setting values"

		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 
						
						
		#contour_handle_$page_num_current$win_counter SetDataComponent "vonMises"
		#contour_handle_$page_num_current$win_counter SetDataType "SXYZ/3D/Stress"

		set ::GA_Report::stress_datatype "ESTRESS"
		set ::GA_Report::strain_datatype "Plastic_Strain"
		
		set ::GA_Report::stress_datacomp "Maximum equivalent stress in shell element"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::y_curve_comp "Contact_Force-Magnitude"
		set ::GA_Report::x_curve_request "Impactor_Displacement"
		set ::GA_Report::y_curve_request "IMPACTOR_TRIM_CONTACT"
						
						   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		#set ::GA_Report::x_joint_request_type "E$retainer_type_elem"
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		#set ::GA_Report::y_joint_request_type "E$retainer_type_elem"
		set ::GA_Report::y_joint_component_type "Value"
										
	}

	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "nodout"
		set ::GA_Report::curve_force_datatype "rcforce"
											
		set y_c_r "$::GA_Report::contact_pair_name"
		set ycr_add "-Slave"			
						
		set ::GA_Report::x_curve_comp "resultant_displacement"
		set ::GA_Report::y_curve_comp "resultant_force"
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$y_c_r$ycr_add"
											   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::x_joint_component_type	"Time"
		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::y_joint_component_type "Value"

	}

	set output_file_list [list]
	# ############################for each loop starts######################################

	foreach filename_calculate $::GA_Report::selected_files_list {

		set top_image_entry $top_image_counter
		append top_image_entry " "
		append top_image_entry $filename_calculate
		lappend ::GA_Report::top_image_file_list $top_image_entry
		incr top_image_counter

		set temp_file_path [concat $::GA_Report::dir_slash$filename_calculate ]
		#puts $temp_file_path

		set loop_pg_hand [concat $pg_hand_base$pg_hand_itr]
		master_project GetPageHandle $loop_pg_hand $page_Num 
		$loop_pg_hand SetLayout 0
		# --------------page set end-------------------------

		# --------------win handle set start-----------------
		set loop_win_hand [concat $win_hand_base$win_hand_itr]
		lappend list_of_window_handle $loop_win_hand 
		$loop_pg_hand GetWindowHandle $loop_win_hand 1
		set loop_anim_hand [concat $anim_hand_base$anim_hand_itr]
		$loop_win_hand GetClientHandle $loop_anim_hand
		# --------------win handle set end----------------- 

		# --------------id and mod handle set start----------------- 
		set loop_id_hand_name [concat $id_hand_base$id_hand_itr]
		set loop_id_val [$loop_anim_hand AddModel $temp_file_path]
		set loop_id_list [list $loop_id_hand_name $loop_id_val ]
		set loop_mod_hand [concat $mod_hand_base$mod_hand_itr]

		$loop_anim_hand GetModelHandle $loop_mod_hand [lindex $loop_id_list  1]
		$loop_mod_hand SetResult $temp_file_path
		# --------------id and mod handle set end----------------- 
		#puts "id and mod handle done"

		set loop_res_hand [concat $res_hand_base$res_hand_itr]
		set loop_cont_hand [concat $cont_hand_base$cont_hand_itr]

		$loop_mod_hand  GetResultCtrlHandle $loop_res_hand
		$loop_res_hand GetContourCtrlHandle $loop_cont_hand

		set numsim_hand_name [concat $numsim_hand_base$numsim_hand_itr]
		set numsim_id_val [$loop_res_hand GetNumberOfSimulations 1]
		set loop_numsim_list [list $numsim_hand_name $numsim_id_val ]

		set numind_hand_name [concat $numind_hand_base$numind_hand_itr]
		set numind_id_val [expr {[lindex $loop_numsim_list 1]-1}]
		set loop_numind_list [list $numind_hand_name $numind_id_val ]
		$loop_res_hand SetCurrentSimulation [lindex $loop_numind_list 1]

		# puts "upto res handle done"

		set loop_lgd_hand [concat $lgd_hand_base$lgd_hand_itr]

		set loop_mask_sel_hand [concat $mask_sel_hand_base$mask_sel_hand_itr]
		set selection_set_id [$loop_mod_hand AddSelectionSet element]

		$loop_mod_hand GetSelectionSetHandle $loop_mask_sel_hand $selection_set_id
		$loop_mask_sel_hand SetLabel "OurElementSelectionSet"
		$loop_mask_sel_hand SetVisibility true
		$loop_mask_sel_hand SetSelectMode displayed
		$loop_mask_sel_hand Add "dimension 1"
		
		#######COMMENTED OUT BELOW ONE LINE TO EXCLUDE DYNA 1D ELEMENT NODES- ORPHAN NODES GET INTO RETAINER LIST###########
		$loop_mask_sel_hand Add "dimension 0"
		
		#puts "get id vals"
		set temp1 [$loop_mask_sel_hand GetList]
		set ::GA_Report::one_d_element_list $temp1
		
		$loop_mask_sel_hand Subtract "dimension 0"
		
		set temp2 [$loop_mask_sel_hand GetList]
		set ::GA_Report::one_d_element_list_retainer $temp2
		
		$loop_mask_sel_hand Add "dimension 0"
		

		$loop_mod_hand Mask [$loop_mask_sel_hand GetID]
        
		#$loop_mask_sel_hand clear

		# ------------------notes hide code above - implementation pending ----------------

		$loop_cont_hand GetLegendHandle $loop_lgd_hand
		$loop_cont_hand SetEnableState true

		$loop_lgd_hand SetType user 
		$loop_lgd_hand SetPosition upperleft
		$loop_lgd_hand SetNumericFormat "fixed"
		$loop_lgd_hand SetNumericPrecision 5
		$loop_lgd_hand SetReverseEnable false
		$loop_lgd_hand SetNumberOfColors 7 
		$loop_lgd_hand SetColor 0 "192 192 192" 
		$loop_lgd_hand SetColor 1 "2 203 218" 
		$loop_lgd_hand SetColor 2 "46 255 118" 
		$loop_lgd_hand SetColor 3 "129 255   0" 
		$loop_lgd_hand SetColor 4 "248 229   0" 
		$loop_lgd_hand SetColor 5 "255  88   0" 
		$loop_lgd_hand SetColor 6 "255   0   0" 
		$loop_lgd_hand SetColor 7 "192 192 192" 
		$loop_lgd_hand OverrideValue 0 0.000

		#$loop_cont_hand SetDataType "Displacement"
		#$loop_cont_hand SetDataComponent Mag
		#$loop_anim_hand SetDisplayOptions contour true
		#$loop_anim_hand SetDisplayOptions "legend" "true"
		#$loop_anim_hand Draw


		$loop_cont_hand SetDataType "$::GA_Report::stress_datatype"
		$loop_cont_hand SetDataComponent $::GA_Report::stress_datacomp
		$loop_cont_hand SetLayer Max
		$loop_cont_hand SetAverageMode advanced
		$loop_anim_hand SetDisplayOptions contour true
		$loop_anim_hand SetDisplayOptions "legend" "true"
		$loop_anim_hand Draw


		# ##########	# modify second selection set and get list of comps displayed.

		#$loop_mask_sel_hand Clear
		#this was done to clear the selection error
		set type "component"
		set selection_set_id2 [$loop_mod_hand AddSelectionSet component]
		set loop_unmask_sel_hand [concat $unmask_sel_hand_base$unmask_sel_hand_itr]
		$loop_mod_hand GetSelectionSetHandle $loop_unmask_sel_hand $selection_set_id2

		$loop_unmask_sel_hand SetSelectMode displayed;
		$loop_unmask_sel_hand Add all;
		set compList_2d_3d [$loop_unmask_sel_hand GetList]
		#puts "only selected list of 2d 3d"
		#puts $compList_2d_3d

		#puts $compList_2d_3d 	
		$loop_unmask_sel_hand Clear


		$loop_anim_hand Draw
		#hwt::PopupWorkingWindow "loading the elements..."

		set selection_set_elem [$loop_mod_hand AddSelectionSet element]
		set loop_elem_sel_hand [concat $elem_sel_hand_base$elem_sel_hand_itr]
		$loop_mod_hand GetSelectionSetHandle $loop_elem_sel_hand $selection_set_elem

		$loop_elem_sel_hand SetSelectMode displayed;
		$loop_elem_sel_hand Add all;
		set elemList_2d_3d [$loop_elem_sel_hand GetList]
		#puts "elem list done"
		#puts $elemList_2d_3d

		$loop_elem_sel_hand Clear

		#hwt::PopdownWorkingWindow
		set selection_set_id3 [$loop_mod_hand AddSelectionSet component]
		set loop_full_sel_hand [concat $full_sel_hand_base$full_sel_hand_itr]
		$loop_mod_hand GetSelectionSetHandle $loop_full_sel_hand $selection_set_id3


		$loop_full_sel_hand SetSelectMode all;
		$loop_full_sel_hand Add all;
		set compList_all [$loop_full_sel_hand GetList]
		#puts "all list"
		#puts $compList_all

		$loop_full_sel_hand Clear
		#set one_d_list {}
		#foreach item $compList_all {
		#if {$item ni $compList_2d_3d} {         lappend one_d_list $item     }
		#}
		#puts " The one D list is"
		#puts $one_d_list
		#puts " The one D list is"
		foreach elem $compList_all {set x($elem) 1}
		#puts "x set done"
		foreach elem $compList_2d_3d {unset x($elem)}
		set one_d_comp_list [array names x]
		#puts $one_d_comp_list


		# ###############

		# #####################################	#loop for seperating comps starts ###################	
		$loop_mod_hand UnMaskAll

		set finisher [llength $elemList_2d_3d]
		set first_elem [ lindex $elemList_2d_3d 0]
		#puts "first elem"
		#puts $first_elem
		#puts "finisher length"
		#puts $finisher

		set format ".txt"
		set formatcsv ".csv"
		set slash_100 "/"
		set dir_name_for_parts $::GA_Report::dir_for_parts_list
		set partwiseFolder "/part"

		# create folders start
		
		if { $::GA_Report::c3var == "LsDyna" } {
			set cut_string {d3plot} 
			set slash_cut {/}
			
			set s1 $filename_calculate
			set s1 [ string trim $s1 "$cut_string" ]
			set s1 [ string trim $s1 "$slash_cut" ]
			set s2 [ string trim $s1 "$::GA_Report::solver_extension" ]
		
		} else { 
			set s1 $filename_calculate
		}
		
		if { $::GA_Report::c3var == "PamCrash" } {
			set s2 [ string map {".erfh5" ""} $s1 ]
		}
		
		if { $::GA_Report::c3var == "Abaqus_S" } {
			set s2 [ string trim $s1 "$::GA_Report::solver_extension" ]
		}
		
		#puts "s2 is $s2"
        set ::GA_Report::data_folder "DATA"

		set folder_path "$dir_name_for_parts$slash_100$::GA_Report::data_folder$slash_100$s2"
		file mkdir $folder_path

		set connected_part_loop_id 1

		# ##########################loop for each connected part##################

		for {set i 0} {$i < $finisher} {incr i} {


			$loop_mod_hand Mask [$loop_mask_sel_hand GetID]

			set for_loop_sel_hand [concat $for_sel_base$for_sel_hand_itr]
			set for_loop_qu_hand [concat $for_qu_base$for_qu_hand_itr]
			set for_loop_res_hand [concat $for_result_base$for_result_hand_itr]
			set for_loop_coun_hand [concat $for_coun_base$for_coun_hand_itr]
			set for_loop_itr_hand [concat $for_itr_base$for_itr_hand_itr]

			$loop_mod_hand GetResultCtrlHandle $for_loop_res_hand
			$for_loop_res_hand GetContourCtrlHandle $for_loop_coun_hand

			set selection_set_id_element [$loop_mod_hand AddSelectionSet element]
			$loop_mod_hand GetSelectionSetHandle $for_loop_sel_hand $selection_set_id_element

			$for_loop_sel_hand SetLabel "OurElementSelectionSet"
			$for_loop_sel_hand SetVisibility true
			$for_loop_sel_hand SetSelectMode displayed
			$for_loop_sel_hand Add "id $first_elem"
			$for_loop_sel_hand Add "Attached"
			set attached_list [$for_loop_sel_hand GetList]

			set dComp [$for_loop_coun_hand GetDataComponent]

			$for_loop_coun_hand SetDataComponent $dComp;

			set layer [$for_loop_coun_hand GetLayer]
			$for_loop_coun_hand SetLayer $layer

			set dType [$for_loop_coun_hand GetDataType]
			$for_loop_coun_hand SetDataType $dType

			$loop_mod_hand GetQueryCtrlHandle $for_loop_qu_hand
			$for_loop_qu_hand SetDataSourceProperty contour datacomps "$dComp"
			$for_loop_qu_hand SetSelectionSet $selection_set_id_element
			$for_loop_qu_hand SetQuery "component.name";
			$for_loop_qu_hand GetIteratorHandle $for_loop_itr_hand


			set data_comp_name [$for_loop_itr_hand GetDataList]

			# #########################GET PART WISE STRESS AND STRAIN START ###############	

			set partwise "partwisevalues"
			set loadcasenum loadcase
			set loadcase_itr 1
			set q_itr 1
			set iterator_for_parts iterator_part
			set itr_part_inc 1
			set subcase_num [$for_loop_res_hand GetSubcaseList]
			#puts $subcase_num

			#  #################each subcase result write start######################	
			# #########################GET PART WISE STRESS AND STRAIN start ###############	

			# #########################GET PART WISE STRESS AND STRAIN END ###############	

			#puts $attached_list
			lappend $data_comp_name
			lappend result_wise_list $attached_list
			lappend result_wise_list "xxxyyy"

			$loop_mod_hand Mask [$for_loop_sel_hand GetID]

			#puts "attached removal from 2d 3d start"

			foreach elem2 $elemList_2d_3d {set y($elem2) 1}
			foreach elem2 $attached_list {unset y($elem2)}
			set exclude_elem_list [array names y]

			#puts "attached removal from 2d 3d finish"
			set elemList_2d_3d $exclude_elem_list

			set first_elem [ lindex $elemList_2d_3d 0]

			set stopper [llength $attached_list]
			#puts $stopper
			if { $stopper == 0 } { set finisher 0}

			$for_loop_sel_hand Clear
			#puts $result_wise_list

			set patch_exclude 0

			set part_wise_filename "$dir_name_for_parts$slash_100$::GA_Report::data_folder$slash_100$s2$slash_100$data_comp_name$i$formatcsv"
			#puts $part_wise_filename
			set total_exclude_part 0

			set content [lsearch -all -inline $data_comp_name *FAKE*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *fake*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *BIW*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *biw*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *SEAL*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *seal*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *NULL*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *null*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *SHEET*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *sheet*]
			set exclude_part [ llength $content ]
			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

			set content [lsearch -all -inline $data_comp_name *PATCH*]
			set p_exclude_part [ llength $content ]
			if { $p_exclude_part > 0 } { set patch_exclude 100  }


			set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]


			if { $total_exclude_part > 0 } {

				#puts "part is excluded"
			} else { 

				if { ($patch_exclude == 100) && ( $stopper > 60 ) } { 

					set list_$s2$data_comp_name [list]
					set outStr1 [open $part_wise_filename w+];
					#puts $part_wise_filename
					puts $outStr1 $attached_list
					close $outStr1

					foreach element_id_in $attached_list {	lappend list_$s2$data_comp_name $element_id_in 	}
					lappend list_of_parts_seperated_listed list_$s2$data_comp_name

					set part_$s2$underscore$data_comp_name $attached_list
					lappend list_of_parts_seperated_all part_$s2$underscore$data_comp_name

				} 

				if { $stopper > 50 } {
					set list_$s2$data_comp_name [list]
					set outStr1 [open $part_wise_filename w+];
					#puts $part_wise_filename
					puts $outStr1 $attached_list
					close $outStr1

					foreach element_id_in $attached_list {	lappend list_$s2$data_comp_name $element_id_in 	}
					lappend list_of_parts_seperated_listed list_$s2$data_comp_name

					set part_$s2$underscore$data_comp_name $attached_list
					lappend list_of_parts_seperated_all part_$s2$underscore$data_comp_name
				}


			}

			set exclude_part 0
			set patch_exclude 0
			#$loop_mod_hand UnMaskAll
			incr for_sel_hand_itr
			incr for_qu_hand_itr

			incr for_result_hand_itr 
			incr for_coun_hand_itr 
			incr for_itr_hand_itr 

			unset attached_list

		}
        
		$loop_mask_sel_hand Clear

		# ########################### PUT THE VALUES IN APPROPRIATE LIST START #################
		set disp_max [$loop_lgd_hand GetValue 9]
		lappend list_of_rep_disp_max $disp_max

		$loop_anim_hand Draw
		$loop_pg_hand Draw
		# ###########################  PUT THE VALUES IN APPROPRIATE LIST END #################

		incr numsim_hand_itr
		incr numind_hand_itr
		incr lgd_hand_itr
		incr cont_hand_itr
		incr res_hand_itr
		incr id_hand_itr
		incr mod_hand_itr
		incr anim_hand_itr
		incr win_hand_itr

		incr image_name_counter
		incr page_number
		incr xaxis_hand_itr
		incr yaxis_hand_itr

		incr cur_hand_itr
		incr note_hand_itr
		incr pg_hand_itr
		incr page_Num 

		incr plot_hand_itr
		#    sel hand increments.	

		incr mask_sel_hand_itr
		incr unmask_sel_hand_itr
		incr full_sel_hand_itr
		incr elem_sel_hand_itr

		incr result_itr
		$loop_mod_hand UnMaskAll
		master_project AddPage

		#puts " file name is $filename_calculate	"

		lappend output_file_list $s2

	}
	
	set condensed_stress "condensed_stress_"
	set stress_head "Stress_"
	set all_comp_head "all_component_list_"
	set strain_head "Strain_"
	set disp_head "Disp_"
	set sorted "sort_"
	set max_comp_stress_head "Comp_Stress_"
	set max_comp_strain_head "Comp_Strain_"
	set max_comp_disp_head "Comp_Disp_"
	set stress_compute [list]
	set output_stress_list [list]
	set output_strain_list [list]
	set output_disp_list [list]
	set stress_sort_list [list]
	set strain_sort_list [list]
	set disp_sort_list [list]

	set t [::post::GetT];
    set slash_char "/"
	set dirName $::GA_Report::dir_for_parts_list$slash_char$::GA_Report::data_folder
    #set dirName [master_session GetSystemVariable "CURRENTWORKINGDIR"]

	set filename_count 0
	for {set i 1} {$i <= [master_project GetNumberOfPages]} {incr i} {
		set t [::post::GetT];
		master_project GetPageHandle pgh$t $i

		## Getting the window handle and no of windows in each page
		for {set j 1} {$j <= [pgh$t GetNumberOfWindows]} {incr j} {
			# hwi OpenStack;
			pgh$t GetWindowHandle wh$t $j

			## Making sure the client is Animation and that the window is not empty
			if {[wh$t GetClientType] != "Animation" } {
				::hw::ShowMessage "Animation Client is not loaded on pg${i}win${j}, continuing with the next one"
				# hwi CloseStack;
				continue;
			}
			if {[wh$t IsEmpty] == "true" } {
				::hw::ShowMessage "pg${i}win${j} is empty, continuing with the next one"
				#hwi CloseStack;
				continue;
			}
			wh$t GetClientHandle posth$t

			## Getting active model handle along with result and contour handles
			posth$t GetModelHandle mh$t [posth$t GetActiveModel]
			mh$t GetResultCtrlHandle resh$t
			resh$t GetContourCtrlHandle ch$t
			if { ![ch$t GetEnableState] } {
				#::post::Message "No contour plot available";
				::hw::ShowMessage "No contour plot available in pg${i}win${j}, continuing with the next one"
				#hwi CloseStack;
				continue;
			}

			## Setting datatype, datacomponent and the layer
			set dType [ch$t GetDataType]
			ch$t SetDataType $dType
			set dComp [ch$t GetDataComponent]
			ch$t SetDataComponent $dComp;
			set layer [ch$t GetLayer]
			ch$t SetLayer $layer

			## Adding the displayed components into selection set
			set type "component"
			set esID [mh$t AddSelectionSet component];
			mh$t GetSelectionSetHandle sh$t $esID;
			#set compList [sh$t GetList]
			sh$t SetSelectMode displayed;
			sh$t Add all;
			#set size [sh$t GetSize]
			set subcase_iterator 1
			## open csv file here
			set query_output_name [ lindex $output_file_list $filename_count]

			#set fileName [file join "$dirName" "querypg${i}win${j}.csv"]
			set fileName [file join "$dirName" "$stress_head$query_output_name$formatcsv"]
			set sorted_file_name [file join "$dirName" "$sorted$stress_head$query_output_name$formatcsv"]
			set fp [open "$fileName" w]

			set all_comp_file [file join "$dirName" "$query_output_name$formatcsv"]
			set all_comp_list_file [open "$all_comp_file" w]


			set fp_sorted [open "$sorted_file_name" w]
			puts $fp_sorted "LOAD_CASE, INCREMENT, COMPONENT_ID, COMPONENT_NAME, MAXIMUM_ID, MAXIMUM_VALUE"


			set old_datacomp_name "old"

			## Finding the subcase list and going over each subcase to set the desired query items
			set subcase_num [resh$t GetSubcaseList]
			set commas ","

			foreach subcase $subcase_num {


				resh$t SetCurrentSubcase $subcase
				set simu_num [resh$t GetNumberOfSimulations $subcase]

				for {set k 0} {$k < $simu_num} {incr k} {
					set simu_label ""
					set simu_label [resh$t GetSimulationLabel $subcase $k]
					resh$t SetCurrentSimulation $k
					mh$t GetQueryCtrlHandle qh$t
					qh$t SetDataSourceProperty contour datatype "$dType"
					qh$t SetDataSourceProperty contour datacomps "$dComp"
					qh$t SetDataSourceProperty contourt layer "$layer"
					qh$t SetSelectionSet $esID;
					qh$t SetQuery "misc.load misc.sim component.id component.name contour.maxid contour.max";
					qh$t GetIteratorHandle ih$t;
					set data ""

					set datacomp_counter 1

					for { ih$t First }  { [ih$t Valid] } { ih$t Next } {
						set data [ih$t GetDataList]

						set line_comp "";
						set line "";
						set total_exclude_part 0
						foreach item $data {
							set list_value "[string trim $item "{}"], ";
							append line $list_value;
						}

                       if { $::GA_Report::c3var == "Abaqus_S" } {

							set current_Data_comp_name [lindex $line 8]
							if { ($k == 1) && ( $subcase_iterator == 1) } {
								append line_comp $current_Data_comp_name
								append line_comp " "
								set current_Data_comp_ids [lindex $line 7]
								append line_comp $current_Data_comp_ids
								puts $all_comp_list_file $line_comp

							}
                       }
					   
					   if { $::GA_Report::c3var == "PamCrash" } {

							set current_Data_comp_name [lindex $line 6]
							set blank_Data_comp_ids [lindex $line 5]
							
							if { $blank_Data_comp_ids > 0 } {
							
								if { ($k == 1) && ( $subcase_iterator == 1) } {

									append line_comp $current_Data_comp_name
									append line_comp " "
									set current_Data_comp_ids [lindex $line 5]
									#puts "$current_Data_comp_name ---$current_Data_comp_ids"
									
									#if { $current_Data_comp_ids < 1 } { puts " id is less than 0 for $current_Data_comp_name" }
									#if { $current_Data_comp_ids == "" } { puts " id is no space for $current_Data_comp_name" }
									#if { $current_Data_comp_ids == " " } { puts " id is space for $current_Data_comp_name" }
									append line_comp $current_Data_comp_ids
									
									set number_of_comma [ llength [regexp -all -inline $commas $line_comp] ]
									
									if { $number_of_comma > 1 } { 
									
										puts $all_comp_list_file $line_comp 
									
									}
								}

							}
                       }
					   
					   if { $::GA_Report::c3var == "LsDyna" } {

							set current_Data_comp_name [lindex $line 6]
							set blank_Data_comp_ids [lindex $line 5]
						
							if { $blank_Data_comp_ids > 0 } {
							
								if { ( $current_Data_comp_name == "Orphan-Node" ) || ( $current_Data_comp_name == "Orphan-Node 1" ) } { 
							
										#puts "orphan node comp"
									
								} else {								
									if { ($k == 1) && ( $subcase_iterator == 1) } {

										append line_comp $current_Data_comp_name
										append line_comp " "
										set current_Data_comp_ids [lindex $line 5]
										append line_comp $current_Data_comp_ids
										puts $all_comp_list_file $line_comp

									}
								}
							}

						}
					   
						#puts " dataval is $current_Data_comp_name"
						set content [lsearch -all -inline $current_Data_comp_name *FAKE*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *fake*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *BIW*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *biw*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *SEAL*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *seal*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *NULL*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *null*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *SHEET*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *sheet*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *WEAK*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }] 

						set content [lsearch -all -inline $current_Data_comp_name *XXTOOL*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *XXLOC*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *XXRET*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *CouplingComp*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *XXDH*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						set content [lsearch -all -inline $current_Data_comp_name *Orphan*]
						set exclude_part [ llength $content ]
						set total_exclude_part [ expr { $exclude_part + $total_exclude_part }]

						if { $total_exclude_part > 0 } {
							#puts "part is excluded"

						} else { 

							append line $subcase_iterator	
							append line "_"						
							append line $query_output_name;


							lappend output_stress_list $line

							puts $fp $line

						}

						incr datacomp_counter

					}
					ih$t ReleaseHandle;
					qh$t ReleaseHandle;
				}
				incr subcase_iterator 
			}
			close $fp;
			
			if { $::GA_Report::c3var == "Abaqus_S" } {
				set stress_sort_list [ lsort -index 11 [lsort -index 7 [lsort -index 5 [lsort -index 10 $output_stress_list]]]]
			}
			
			if { $::GA_Report::c3var == "PamCrash" } {
				set stress_sort_list [ lsort -index 9 [lsort -index 6 [lsort -index 4 [lsort -index 8 $output_stress_list]]]]
			}
			if { $::GA_Report::c3var == "LsDyna" } {
				set stress_sort_list [ lsort -index 9 [lsort -index 6 [lsort -index 4 [lsort -index 8 $output_stress_list]]]]
			}
			
			
			foreach list_val $stress_sort_list { 	
				puts $fp_sorted $list_val 		
			}
			close $fp_sorted;
			
			close $all_comp_list_file

			# ########################################DEFINE THE CONCISE STRESS LIST START ########################


			#set query_output_name [ lindex $output_file_list $filename_count]

			set fileName [file join "$dirName" "$max_comp_stress_head$query_output_name$formatcsv"]
			set fp [open "$fileName" w]
			puts $fp "LOAD_CASE, INCREMENT, COMPONENT_ID, COMPONENT_NAME, MAXIMUM_ID, MAXIMUM_VALUE"


			#set line "";
			set sort_stress_counter 1
			set each_comp_max_list [list]

			set condensed_$s2$underscore$data_comp_name [list]
			foreach sort_stress_list_item $stress_sort_list {
				set line ""; 

				if { $sort_stress_counter == 1 } { 
					
					if { $::GA_Report::c3var == "Abaqus_S" } {
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 2]			
						set max_stress_time_id [ lindex $sort_stress_list_item 6]
						set max_stress_comp_id [ lindex $sort_stress_list_item 7]
						set max_stress_comp_name [ lindex $sort_stress_list_item 8]
						set max_stress_elem_id [ lindex $sort_stress_list_item 9]
						set max_stress_elem_value [ lindex $sort_stress_list_item 10]
						set max_subcase_value [ lindex $sort_stress_list_item 11]
                    }
				   
				   if { $::GA_Report::c3var == "PamCrash" } {
				
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
						set max_stress_time_id [ lindex $sort_stress_list_item 4]
						set max_stress_comp_id [ lindex $sort_stress_list_item 5]
						set max_stress_comp_name [ lindex $sort_stress_list_item 6]
						set max_stress_elem_id [ lindex $sort_stress_list_item 7]
						set max_stress_elem_value [ lindex $sort_stress_list_item 8]
						set max_subcase_value [ lindex $sort_stress_list_item 9]					
					}
				
					if { $::GA_Report::c3var == "LsDyna" } {
				
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
						set max_stress_time_id [ lindex $sort_stress_list_item 4]
						set max_stress_comp_id [ lindex $sort_stress_list_item 5]
						set max_stress_comp_name [ lindex $sort_stress_list_item 6]
						set max_stress_elem_id [ lindex $sort_stress_list_item 7]
						set max_stress_elem_value [ lindex $sort_stress_list_item 8]
						set max_subcase_value [ lindex $sort_stress_list_item 9]

					}
				}



                if { $::GA_Report::c3var == "Abaqus_S" } {
					set cur_stress_load_step_name [ lindex $sort_stress_list_item 0]
					set cur_stress_increment_id [ lindex $sort_stress_list_item 2]			
					set cur_stress_time_id [ lindex $sort_stress_list_item 6]
					set cur_stress_comp_id [ lindex $sort_stress_list_item 7]
					set cur_stress_comp_name [ lindex $sort_stress_list_item 8]
					set cur_stress_elem_id [ lindex $sort_stress_list_item 9]
					set cur_stress_elem_value [ lindex $sort_stress_list_item 10]
					set cur_subcase_value [ lindex $sort_stress_list_item 11]
                }
				
				if { $::GA_Report::c3var == "PamCrash" } {
					set cur_stress_load_step_name [ lindex $sort_stress_list_item 0]
					set cur_stress_increment_id [ lindex $sort_stress_list_item 1]			
					set cur_stress_time_id [ lindex $sort_stress_list_item 4]
					set cur_stress_comp_id [ lindex $sort_stress_list_item 5]
					set cur_stress_comp_name [ lindex $sort_stress_list_item 6]
					set cur_stress_elem_id [ lindex $sort_stress_list_item 7]
					set cur_stress_elem_value [ lindex $sort_stress_list_item 8]
					set cur_subcase_value [ lindex $sort_stress_list_item 9]
				}

				if { $::GA_Report::c3var == "LsDyna" } {
					set cur_stress_load_step_name [ lindex $sort_stress_list_item 0]
					set cur_stress_increment_id [ lindex $sort_stress_list_item 1]			
					set cur_stress_time_id [ lindex $sort_stress_list_item 4]
					set cur_stress_comp_id [ lindex $sort_stress_list_item 5]
					set cur_stress_comp_name [ lindex $sort_stress_list_item 6]
					set cur_stress_elem_id [ lindex $sort_stress_list_item 7]
					set cur_stress_elem_value [ lindex $sort_stress_list_item 8]
					set cur_subcase_value [ lindex $sort_stress_list_item 9]
				}

				if { $cur_stress_comp_id == $max_stress_comp_id } { 

					set max_stress_comp_id $cur_stress_comp_id

					if { $cur_stress_elem_value > $max_stress_elem_value } { 
                       if { $::GA_Report::c3var == "Abaqus_S" } {
							set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
							set max_stress_increment_id [ lindex $sort_stress_list_item 2]			
							set max_stress_time_id [ lindex $sort_stress_list_item 6]
							set max_stress_comp_id [ lindex $sort_stress_list_item 7]
							set max_stress_comp_name [ lindex $sort_stress_list_item 8]
							set max_stress_elem_id [ lindex $sort_stress_list_item 9]
							set max_stress_elem_value [ lindex $sort_stress_list_item 10]
							set max_subcase_value [ lindex $sort_stress_list_item 11]        
						}
						
						if { $::GA_Report::c3var == "PamCrash" } {
							set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
							set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
							set max_stress_time_id [ lindex $sort_stress_list_item 4]
							set max_stress_comp_id [ lindex $sort_stress_list_item 5]
							set max_stress_comp_name [ lindex $sort_stress_list_item 6]
							set max_stress_elem_id [ lindex $sort_stress_list_item 7]
							set max_stress_elem_value [ lindex $sort_stress_list_item 8]
							set max_subcase_value [ lindex $sort_stress_list_item 9]
                        }
						
						if { $::GA_Report::c3var == "LsDyna" } {
							set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
							set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
							set max_stress_time_id [ lindex $sort_stress_list_item 4]
							set max_stress_comp_id [ lindex $sort_stress_list_item 5]
							set max_stress_comp_name [ lindex $sort_stress_list_item 6]
							set max_stress_elem_id [ lindex $sort_stress_list_item 7]
							set max_stress_elem_value [ lindex $sort_stress_list_item 8]
							set max_subcase_value [ lindex $sort_stress_list_item 9] 
                        }
					}

				} else {

					append line  $max_stress_load_step_name
					append line  $max_stress_increment_id
					append line  $max_stress_time_id
					append line  $max_stress_comp_id
					append line  $max_stress_comp_name
					append line  $max_stress_elem_id
					append line  $max_stress_elem_value

					set edited_comp_name $max_stress_comp_name

					regsub -all -line {^.*\y(\w+\_T_).*$} $edited_comp_name {\1} edited_comp_name 
					set edited_comp_name [ string trim $edited_comp_name "_T_" ]				 

					append line  $edited_comp_name
					append line  ","
					append line  $max_subcase_value

					lappend stress_compute $line

					puts $fp $line

					set line "";
						
					if { $::GA_Report::c3var == "Abaqus_S" } {
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 2]			
						set max_stress_time_id [ lindex $sort_stress_list_item 6]
						set max_stress_comp_id [ lindex $sort_stress_list_item 7]
						set max_stress_comp_name [ lindex $sort_stress_list_item 8]
						set max_stress_elem_id [ lindex $sort_stress_list_item 9]
						set max_stress_elem_value [ lindex $sort_stress_list_item 10]
						set max_subcase_value [ lindex $sort_stress_list_item 11]

					}
					
					if { $::GA_Report::c3var == "PamCrash" } {			
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
						set max_stress_time_id [ lindex $sort_stress_list_item 4]
						set max_stress_comp_id [ lindex $sort_stress_list_item 5]
						set max_stress_comp_name [ lindex $sort_stress_list_item 6]
						set max_stress_elem_id [ lindex $sort_stress_list_item 7]
						set max_stress_elem_value [ lindex $sort_stress_list_item 8]
						set max_subcase_value [ lindex $sort_stress_list_item 9]
						
                    }
					
					if { $::GA_Report::c3var == "LsDyna" } {
					
						set max_stress_load_step_name [ lindex $sort_stress_list_item 0]
						set max_stress_increment_id [ lindex $sort_stress_list_item 1]			
						set max_stress_time_id [ lindex $sort_stress_list_item 4]
						set max_stress_comp_id [ lindex $sort_stress_list_item 5]
						set max_stress_comp_name [ lindex $sort_stress_list_item 6]
						set max_stress_elem_id [ lindex $sort_stress_list_item 7]
						set max_stress_elem_value [ lindex $sort_stress_list_item 8]
						set max_subcase_value [ lindex $sort_stress_list_item 9]					
					
                    }	

				}
				incr sort_stress_counter 
			}
			close $fp;

			#set fileName [file join "$dirName" "$max_comp_stress_head$query_output_name$formatcsv"]
			set fileName [file join "$dirName" "$condensed_stress$query_output_name$formatcsv"]
			set fp [open "$fileName" w]
			puts $fp "LOAD_CASE, INCREMENT, COMPONENT_ID, COMPONENT_NAME, MAXIMUM_ID, MAXIMUM_VALUE ,COMPONENT_NAME, LOAD_STEP_ITERATION"
			set line "";
			set sort_stress_counter 1

			foreach line_value_01  $stress_compute {  

				#set replaced_string "[string trim $line_value_01 "{}"], ";
				set replaced_string [ string map {"," " "} $line_value_01 ]
				#set replaced_string [regsub "," $line_value_01 " "]         
				lappend stress_compute_01 $replaced_string

			}
				#puts $stress_compute	
				#puts $stress_compute_01


                if { $::GA_Report::c3var == "Abaqus_S" } {
					set stress_compute_list [ lsort -index 7 [lsort -index 6 [lsort -index 5 $stress_compute_01]]]
				
				}
				
				if { $::GA_Report::c3var == "PamCrash" } {	
					set stress_compute_list [ lsort -index 6 [lsort -index 5 [lsort -index 4 $stress_compute_01]]]
				}
				
				if { $::GA_Report::c3var == "LsDyna" } {			
					set stress_compute_list [ lsort -index 6 [lsort -index 5 [lsort -index 4 $stress_compute_01]]]
				}

				foreach line_val  $stress_compute_list {
					set line "";

					if { $sort_stress_counter == 1 } {	
						if { $::GA_Report::c3var == "Abaqus_S" } {					
							set max_stress_load_step_name [ lindex $line_val 0]
							set max_stress_increment_id [ lindex $line_val 1]			
							set max_stress_comp_id [ lindex $line_val 2]
							set max_stress_comp_name [ lindex $line_val 3]
							set max_stress_elem_id [ lindex $line_val 4]
							set max_stress_elem_value [ lindex $line_val 5]
							set max_stress_part_name [ lindex $line_val 6]
							set max_subcase_value [ lindex $line_val 7]

						}
						
						
						if { $::GA_Report::c3var == "PamCrash" } {
							#puts $line_val
							
							set max_stress_load_step_name [ lindex $line_val 0]
							set max_stress_increment_id [ lindex $line_val 1]			
							set max_stress_comp_id [ lindex $line_val 2]
							set max_stress_comp_name [ lindex $line_val 3]
							set max_stress_elem_id [ lindex $line_val 4]
							set max_stress_elem_value [ lindex $line_val 5]
							set max_stress_part_name [ lindex $line_val 6]
							set max_subcase_value [ lindex $line_val 7]		
						}


						if { $::GA_Report::c3var == "LsDyna" } {
							#puts $line_val
							
							set max_stress_load_step_name [ lindex $line_val 0]
							set max_stress_increment_id [ lindex $line_val 1]			
							set max_stress_comp_id [ lindex $line_val 2]
							set max_stress_comp_name [ lindex $line_val 3]
							set max_stress_elem_id [ lindex $line_val 4]
							set max_stress_elem_value [ lindex $line_val 5]
							set max_stress_part_name [ lindex $line_val 6]
							set max_subcase_value [ lindex $line_val 7]
	
						}
					}

					set cur_stress_load_step_name [ lindex $line_val 0]
					set cur_stress_increment_id [ lindex $line_val 1]			
					set cur_stress_comp_id [ lindex $line_val 2]
					set cur_stress_comp_name [ lindex $line_val 3]
					set cur_stress_elem_id [ lindex $line_val 4]
					set cur_stress_elem_value [ lindex $line_val 5]
					set curr_stress_part_name [ lindex $line_val 6]
					set cur_subcase_value [ lindex $line_val 7]

					if { $curr_stress_part_name == $max_stress_part_name  } { 

						set max_stress_part_name $curr_stress_part_name

						if { $cur_stress_elem_value > $max_stress_elem_value } {
							set max_stress_load_step_name [ lindex $line_val 0]
							set max_stress_increment_id [ lindex $line_val 1]			
							set max_stress_comp_id [ lindex $line_val 2]
							set max_stress_comp_name [ lindex $line_val 3]
							set max_stress_elem_id [ lindex $line_val 4]
							set max_stress_elem_value [ lindex $line_val 5]
							set max_stress_part_name [ lindex $line_val 6]
							set max_subcase_value [ lindex $line_val 7]  

						}

					} else {

						append line  $max_stress_load_step_name
						append line ","
						append line  $max_stress_increment_id
						append line ","
						append line  $max_stress_comp_id
						append line ","
						append line  $max_stress_comp_name
						append line ","
						append line  $max_stress_elem_id
						append line ","
						append line  $max_stress_elem_value
						append line ","	    
						append line  $max_stress_part_name
						append line ","
						append line  $max_subcase_value


						puts $fp $line

						set line "";
						set max_stress_load_step_name [ lindex $line_val 0]
						set max_stress_increment_id [ lindex $line_val 1]			
						set max_stress_comp_id [ lindex $line_val 2]
						set max_stress_comp_name [ lindex $line_val 3]
						set max_stress_elem_id [ lindex $line_val 4]
						set max_stress_elem_value [ lindex $line_val 5]
						set max_stress_part_name [ lindex $line_val 6]
						set max_subcase_value [ lindex $line_val 7]
					}

					incr sort_stress_counter 
				}

				close $fp;

				unset stress_compute
				unset line

				# start the reporting.
				# make the biw only list for extra plots.
				# get the A surface list
				# for each part - find intersection of A surface list. This will form the A surface list.


				# #######################################DEFINE THE CONCISE STRESS LIST END #############################						  

				unset stress_compute_01
				unset stress_compute_list
				unset output_stress_list
				unset stress_sort_list

				::hw::ShowMessage "CSV File written successfully. It is located at: $fileName"
				# hwi CloseStack;
				incr filename_count
		}
		#hwi CloseStack;

	}
	hwt::PopdownWorkingWindow
}	

# ----------------------------------------------- RESULT FILES PROCESSING FUNCTIONS-----------------------------------------------------

proc ::GA_Report::load_page_master { op_file_name op_file_path page_num_current } {

	#master_session SetUserVariable SHOWUNITSDIALOG 0
     
	#puts $op_file_path
	#after 10000
	if { $::GA_Report::tool_element_id == "" } { 
		set ::GA_Report::tool_element_id 10001 
	}
       
	# start with file name for handle and pagenum so that handles are unique and can be called later,
	# define session out of loop and project also

	#puts $op_file_name
	set op_file $op_file_name

	if { $::GA_Report::c3var == "Abaqus_S"  } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}

	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}
		   
	#puts "master node is $::GA_Report::user_master_id"

	set solver_choice $::GA_Report::c3var
	#set client_choice $::GA_Report::c4var
	#set product_choice $::GA_Report::c5var
		
	if { $::GA_Report::c3var == "Abaqus_S" } {

		set op_file_curve $op_file_path

		if { $::GA_Report::user_master_id >= 1 } { 
			set master_node_id $::GA_Report::user_master_id
		} else {
			set master_node_id 1001
		}
		
		set n_master_id N$master_node_id

		#puts "solver is abaqus -setting values"
		set ::GA_Report::solver_extension ".odb"
		set ::GA_Report::plot_disp_datatype "Displacement"
		
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
		set ::GA_Report::strain_datatype "PE-Global-Plastic strain components IP"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "vonMises"
		
		set ::GA_Report::curve_disp_datatype "Displacement"
		
		if { $::GA_Report::cbState(empty23) == 1} {
			set ::GA_Report::curve_force_datatype "RF-Reaction force"
			set ::GA_Report::x_curve_comp "Time"
		} else {
			set ::GA_Report::curve_force_datatype "CF-Point loads"
		}
		
		set ::GA_Report::x_curve_comp "MAG"
		set ::GA_Report::y_curve_comp "MAG"
		set ::GA_Report::x_curve_request $n_master_id
		set ::GA_Report::y_curve_request $n_master_id

	}

	if { $::GA_Report::c3var == "PamCrash" } {

		set op_file_curve $op_file_path
		
		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "ESTRESS"
		set ::GA_Report::strain_datatype "EPLE/2D"
		
		set ::GA_Report::stress_datacomp "Maximum equivalent stress in shell element"
		set ::GA_Report::strain_datacomp "Scalar value"
			
		set ::GA_Report::curve_disp_datatype "Node (Time History)"						
		#set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		set ::GA_Report::curve_force_datatype "Section (Time History)"
		
		#set ::GA_Report::x_curve_request "IMPACTOR_TRIM_CONTACT"
		set ::GA_Report::x_curve_request  "IMPACTOR_CONTACT_SECTION" 
		#set ::GA_Report::x_curve_comp "Contact_Force-Magnitude"
		set ::GA_Report::x_curve_comp "SECF-Section force X"
		
		# ###############################THNODE NAME IS CONFLICTING , THIS MAY NEED TO BE STANDARDIZED OR ADDED TO GUI"
		# set ::GA_Report::y_curve_request "Verschiebung Pruefkoerper"
		#set ::GA_Report::y_curve_request "Impactor_Displacement"
		set ::GA_Report::y_curve_request "$::GA_Report::contact_pair_name"		
		#set ::GA_Report::y_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::y_curve_comp "Translational_Displacement_Local-X"
		
	}

	if { $::GA_Report::c3var == "LsDyna" } {

		
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"

		# ################################### NEED TO UPDATE FROM HERE #####################################

		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"

		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 

		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "nodout"
		set ::GA_Report::curve_force_datatype "rcforc"
		
		set ::GA_Report::fd_enrgy_y_curve_datatype $::GA_Report::curve_force_datatype 
	
		set y_c_r "$::GA_Report::contact_pair_name"
		set ycr_add "-Slave"
				
		#set ::GA_Report::x_curve_comp "resultant_displacement"
		#set ::GA_Report::y_curve_comp "resultant_force"
		
		set ::GA_Report::x_curve_comp  "resultant_force"
		set ::GA_Report::y_curve_comp "resultant_displacement"
		
		#set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		#set ::GA_Report::y_curve_request "$y_c_r$ycr_add"
		
		set ::GA_Report::x_curve_request  "$y_c_r$ycr_add"
		set ::GA_Report::y_curve_request "$::GA_Report::master_node_id"
		
		set ::GA_Report::fd_enrgy_y_curve_request $::GA_Report::x_curve_request 
		set ::GA_Report::fd_enrgy_y_curve_comp $::GA_Report::x_curve_comp 
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"

		# ################################### NEED TO UPDATE FROM HERE #####################################
	
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
	
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
		set op_file_curve_y  $op_file_curve_x
		
		#puts "x file is $op_file_curve_x"
		#puts "y file is $op_file_curve_y"
		

	}

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {

		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps

	# WRAPPER USED TO ACTIVATE READER OPTIONS
	hwc config readeroptions "ABAQUS Model Input Reader" "Model Organization" = "By Property"

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	#puts $op_file_cur
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 4

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	# this is just getting the second step label
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 2 ]
	#puts " second step label is $second_step_label"
	set third_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 3 ]
	#puts " third step label is $third_step_label"
	set fourth_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 4 ]
	#puts " fourth step label is $fourth_step_label"
	set fifth_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 5 ]
	#puts " fifth step label is $fifth_step_label"
	set sixth_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 6 ]
	#puts " sixth step label is $sixth_step_label"


	set subcase_num [result_handle_$page_num_current$win_counter GetSubcaseList]
	set scid_even [result_handle_$page_num_current$win_counter AddSubcase];
	result_handle_$page_num_current$win_counter GetSubcaseHandle subcase_handle_load_$page_num_current$win_counter $scid_even

	foreach sub1 $subcase_num {

		set simu_num [result_handle_$page_num_current$win_counter GetNumberOfSimulations $sub1]
		set max [expr $simu_num - 1]

		for {set i 0} {$i < $simu_num} {incr i} {
			subcase_handle_load_$page_num_current$win_counter AppendSimulation $sub1 $i

		}
	}

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 3]
	set last_step [ expr { $numsim_id_val - 1} ]

	if { $::GA_Report::c3var == "PamCrash" } {
		result_handle_$page_num_current$win_counter SetCurrentSubcase 1
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	}
		
	if { $::GA_Report::c3var == "Abaqus_S" } {

		result_handle_$page_num_current$win_counter SetCurrentSubcase 3
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
		
	}
		
		
	if { $::GA_Report::c3var == "LsDyna" } {

		result_handle_$page_num_current$win_counter SetCurrentSubcase 1
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	}

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 2
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000 

	hwc result scalar legend values entitylabel=false

	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id
	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	result_handle_$page_num_current$win_counter SetCurrentSimulation 1

	set measure_page [ expr { $page_num_current - 1 } ]

	anim_handle_$page_num_current$win_counter GetMeasureHandle measure_handle$page_num_current$win_counter 1
	measure_handle$page_num_current$win_counter SetLabel node_master_measure
	measure_handle$page_num_current$win_counter SetType Position
	measure_handle$page_num_current$win_counter CreateItem
	measure_handle$page_num_current$win_counter AddNode "1 $::GA_Report::master_node_id"

	master_project SetActivePage $measure_page

	#anim_handle_$measure_page$win_counter Draw
	master_project SetActivePage $page_num_current
	anim_handle_$page_num_current$win_counter Draw

	set master_coord_list [ measure_handle$page_num_current$win_counter GetValueList ]
	set all_val_coord [ lindex $master_coord_list 0 ]

	set x_val_coord [ lindex $all_val_coord 0 ]
	set y_val_coord [ lindex $all_val_coord 1 ]
	set z_val_coord [ lindex $all_val_coord 2 ]

	set radius 5

	set selection_set_id_tool [ model_handle_$page_num_current$win_counter AddSelectionSet element]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_tool_$page_num_current$win_counter $selection_set_id_tool
	selection_handle_tool_$page_num_current$win_counter SetVisibility true
	selection_handle_tool_$page_num_current$win_counter SetSelectMode displayed
	selection_handle_tool_$page_num_current$win_counter Add "sphere $x_val_coord $y_val_coord $z_val_coord $radius"

	set elements_of_sphere [selection_handle_tool_$page_num_current$win_counter GetList]
	selection_handle_tool_$page_num_current$win_counter Clear

	if { $::GA_Report::cbState(empty22) == 1} { 

		set selection_set_id_impactor [ model_handle_$page_num_current$win_counter AddSelectionSet element]
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_impactor_$page_num_current$win_counter $selection_set_id_impactor
		selection_handle_impactor_$page_num_current$win_counter SetVisibility true
		selection_handle_impactor_$page_num_current$win_counter SetSelectMode displayed
		selection_handle_impactor_$page_num_current$win_counter Add "id $::GA_Report::tool_element_id"
		selection_handle_impactor_$page_num_current$win_counter Add "Attached"
		selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 1"
		selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 0"
		set impactor_attached_list [ selection_handle_impactor_$page_num_current$win_counter GetList]

		set elements_of_tool [list]
		set elements_of_trim [list]

	}

	if { $::GA_Report::cbState(empty22) == 1} { 


		foreach elem_tool $elements_of_sphere {
		
			set exist_elem [lsearch -all -inline $impactor_attached_list *$elem_tool*]
					
			if { $exist_elem > 0 } {
				lappend elements_of_tool $elem_tool
			} else {
				lappend elements_of_trim $elem_tool
			}
		}

		#puts $elements_of_trim   

		set pointer_element_of_trim [ lindex $elements_of_trim 0 ]
		#puts "pointer element is $pointer_element_of_trim"

		unset elements_of_tool
		unset elements_of_trim
		
		selection_handle_impactor_$page_num_current$win_counter Clear
	}
	
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	
	if { $::GA_Report::cbState(empty22) == 1} { 
		
		anim_handle_$page_num_current$win_counter GetBestViewHandle bestview_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter AddBestView]
		
		bestview_handle_$page_num_current$win_counter SetEntity element $pointer_element_of_trim
		bestview_handle_$page_num_current$win_counter  SetViewMode contour
		bestview_handle_$page_num_current$win_counter SetFocusRegionSize 100
		bestview_handle_$page_num_current$win_counter SetGlobalVisibility hidden
		bestview_handle_$page_num_current$win_counter SetNoteShowSpotID false
		bestview_handle_$page_num_current$win_counter ActivateView	
	}

	anim_handle_$page_num_current$win_counter Draw
	anim_handle_$page_num_current$win_counter RemoveBestView 1
	anim_handle_$page_num_current$win_counter Draw

	# mask the 0ne d elements 
	set selection_set_one_d_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_one_d_$page_num_current$win_counter $selection_set_one_d_id
	selection_handle_one_d_$page_num_current$win_counter Add "dimension 1"
	selection_handle_one_d_$page_num_current$win_counter Add "dimension 0"
	model_handle_$page_num_current$win_counter Mask [selection_handle_one_d_$page_num_current$win_counter GetID]
	selection_handle_one_d_$page_num_current$win_counter Clear

	if { $::GA_Report::c3var == "LsDyna" } {
	
		result_handle_$page_num_current$win_counter SetCurrentSubcase 1
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	
	}


	hwc result scalar legend title font="{Noto Sans} 12 bold roman"
	hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
	hwc result scalar legend values minimum=false
	hwc result scalar legend values entitylabel=false
	set model_info_string {annotation note "Model Info" display text= "{for (i = 0; i != numpts(window.modeltitlelist); ++i) }\n{window.loadcaselist[i]} : {window.simulationsteplist[i]} : {window.framelist[i]}\n{endloop}"}
	hwc $model_info_string


	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### CURVE WINDOW START ######################################################

	#::GA_Report::disp_force

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter SetClientType plot
	win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter
	plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
	curve_handle_$page_num_current$win_counter GetVectorHandle x_vector_handle_$page_num_current$win_counter x
	curve_handle_$page_num_current$win_counter GetVectorHandle y_vector_handle_$page_num_current$win_counter y

	curve_handle_$page_num_current$win_counter SetName "STEP_1"

	x_vector_handle_$page_num_current$win_counter SetType file
	y_vector_handle_$page_num_current$win_counter SetType file


	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::disp_force == 1 } {
		
			if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
							
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "time"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "length"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "mass"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "time"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "length"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "mass"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
			}
							
			if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "time"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "length"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "mass"			
				x_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "time"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "length"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"
				
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnitType "mass"			
				y_vector_handle_$page_num_current$win_counter SetMetaData HWUnit "none"	
				
			}
		
			x_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve_y
			master_session SetUnitsProfile DEFAULT	
			master_session SetUserVariable SHOWUNITSDIALOG 0
			y_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve_x
			master_session SetUnitsProfile DEFAULT	
			master_session SetUserVariable SHOWUNITSDIALOG 0
			
			x_vector_handle_$page_num_current$win_counter  SetSubcase nodout
			y_vector_handle_$page_num_current$win_counter  SetSubcase rcforc
			
		} else {
			x_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve_x 
			master_session SetUnitsProfile DEFAULT	
			master_session SetUserVariable SHOWUNITSDIALOG 0
			y_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve_y
			master_session SetUnitsProfile DEFAULT	
			master_session SetUserVariable SHOWUNITSDIALOG 0
			
			x_vector_handle_$page_num_current$win_counter  SetSubcase rcforc
			y_vector_handle_$page_num_current$win_counter  SetSubcase nodout
			
		}

	} else {
		
		x_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve 
		master_session SetUnitsProfile DEFAULT	
		master_session SetUserVariable SHOWUNITSDIALOG 0
		y_vector_handle_$page_num_current$win_counter SetFilename $op_file_curve
		master_session SetUnitsProfile DEFAULT	
		master_session SetUserVariable SHOWUNITSDIALOG 0
		
	}

	if { ($::GA_Report::c3var == "Abaqus_S") || ( $::GA_Report::c3var == "PamCrash") } {

       if { $::GA_Report::disp_force == 1 } {
			x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_disp_datatype"
			y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
	   
	   } else {
		   x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
		   y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_disp_datatype"
	   }

   }
	   
	if { $::GA_Report::c3var == "LsDyna" } { 
	   
		if { $::GA_Report::disp_force == 1 } {
		   x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_disp_datatype"
		   y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
	   
	   } else {
			x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
			y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_disp_datatype"
	   }

   }  

	if { $::GA_Report::c3var == "Abaqus_S" } {

		
		if { $::GA_Report::cbState(empty23) == 1} { 				
						
			set ::GA_Report::x_curve_comp "Time"
			set ::GA_Report::Displacement_label "Load Steps"
		}
		
		x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::x_curve_request"
		x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::x_curve_comp"

		if { $::GA_Report::cbState(empty23) == 1} { 				
						
			set ::GA_Report::x_curve_comp "MAG"
			set ::GA_Report::Displacement_label "Load Steps"
						
		}
		y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::x_curve_request"
		y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::x_curve_comp"
	}
		
	if { $::GA_Report::c3var == "PamCrash" } {
		
		if { $::GA_Report::disp_force == 1 } {
			x_vector_handle_$page_num_current$win_counter SetRequest  "$::GA_Report::y_curve_request"
			x_vector_handle_$page_num_current$win_counter SetComponent   "$::GA_Report::y_curve_comp"
			y_vector_handle_$page_num_current$win_counter SetRequest  "$::GA_Report::x_curve_request"
			y_vector_handle_$page_num_current$win_counter SetComponent  "$::GA_Report::x_curve_comp"

		} else {
			x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::x_curve_request"
			x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::x_curve_comp"
			y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::y_curve_request"
			y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::y_curve_comp"
		
		}
		
	}

	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::disp_force == 1 } {
			x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::y_curve_request"
			x_vector_handle_$page_num_current$win_counter SetComponent  "$::GA_Report::y_curve_comp"
			y_vector_handle_$page_num_current$win_counter SetRequest  "$::GA_Report::x_curve_request"
			y_vector_handle_$page_num_current$win_counter SetComponent  "$::GA_Report::x_curve_comp"
		} else {
			x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::x_curve_request"
			x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::x_curve_comp"
			y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::y_curve_request"
			y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::y_curve_comp"

		}
	}

	#puts "curve loaded"
	plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
	plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
	
	if { $::GA_Report::disp_force == 1 } {
		y_axis_handle_$page_num_current$win_counter SetLabel $::GA_Report::Force_label
		x_axis_handle_$page_num_current$win_counter SetLabel $::GA_Report::Displacement_label
	} else {
		y_axis_handle_$page_num_current$win_counter SetLabel $::GA_Report::Displacement_label
		x_axis_handle_$page_num_current$win_counter SetLabel $::GA_Report::Force_label
	}
		
	if { ( $::GA_Report::disp_force == 1 ) && ( $::GA_Report::force_multiplier == 1000 ) } {
		y_vector_handle_$page_num_current$win_counter SetScaleFactor $::GA_Report::force_multiplier
	}

	if { ( $::GA_Report::disp_force != 1 ) && ( $::GA_Report::force_multiplier == 1000 ) } {
		x_vector_handle_$page_num_current$win_counter SetScaleFactor $::GA_Report::force_multiplier
	}


	plot_handle_$page_num_current$win_counter GetNoteHandle note_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddNote ]
	set curve_pointer_end w2c1.y
	set curve_pointer [concat p$page_num_current$curve_pointer_end]

	set curve_pointer_endx w2c1.x
	set curve_pointerx [concat p$page_num_current$curve_pointer_endx]


	#note_handle_$page_num_current$win_counter SetText "{max($curve_pointerx)}"

	if { $::GA_Report::disp_force == 1 } {
		
		note_handle_$page_num_current$win_counter SetText "maximum Displacement is {max($curve_pointerx),%.2f }$::GA_Report::length_unit \n at force {max($curve_pointer),%.2f } $::GA_Report::force_unit"
		note_handle_$page_num_current$win_counter SetAttachment "curve"
		note_handle_$page_num_current$win_counter SetAttachToPointIndex indexofmax(c1.y)
		#note_handle_$page_num_current$win_counter SetAttachToCurveIndex indexofmax(c1.y)
		#note_handle_$page_num_current$win_counter SetAttachToCurveIndex max($curve_pointer)
		#note_handle_$page_num_current$win_counter SetPosition 0 0
	
	} else { 
		note_handle_$page_num_current$win_counter SetText "maximum Displacement is {max($curve_pointer),%.2f  }$::GA_Report::length_unit \n at force {max($curve_pointerx),%.2f  } $::GA_Report::force_unit"
		note_handle_$page_num_current$win_counter SetAttachment "curve"
		note_handle_$page_num_current$win_counter SetAttachToPointIndex indexofmax(c1.y)
		#note_handle_$page_num_current$win_counter SetAttachToCurveIndex max($curve_pointer)
		#note_handle_22 SetAttachToPointIndex indexofmax(c1.y)
		#note_handle_$page_num_current$win_counter SetPosition 0 0
		
	}
		
	set load_limit "load_limit"
	set limit_query [::GA_Report::py_heading_ask $op_file_cur $load_limit ]
		
	if { $::GA_Report::disp_force == 1 } {
		note_handle_$page_num_current$win_counter SetPosition $limit_query 0
		plot_handle_$page_num_current$win_counter AddVerticalDatum
		plot_handle_$page_num_current$win_counter GetVerticalDatumHandle datum_handle_$page_num_current$win_counter 1
		datum_handle_$page_num_current$win_counter SetLabel "limit $limit_query mm"
		datum_handle_$page_num_current$win_counter SetPosition $limit_query
		datum_handle_$page_num_current$win_counter SetLineStyle 2	
	} else {  
		note_handle_$page_num_current$win_counter SetPosition 0 $limit_query
		plot_handle_$page_num_current$win_counter AddHorizontalDatum
		plot_handle_$page_num_current$win_counter GetHorizontalDatumHandle datum_handle_$page_num_current$win_counter 1
		datum_handle_$page_num_current$win_counter SetLabel "limit $limit_query mm"
		datum_handle_$page_num_current$win_counter SetPosition $limit_query
		datum_handle_$page_num_current$win_counter SetLineStyle 2
	}
		
	plot_handle_$page_num_current$win_counter Recalculate
	plot_handle_$page_num_current$win_counter Autoscale
	plot_handle_$page_num_current$win_counter Draw

	if { $::GA_Report::c3var == "Abaqus_S" } {

		plot_handle_$page_num_current$win_counter GetCurveHandle curve2_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]

		curve2_handle_$page_num_current$win_counter GetVectorHandle x2_vector_handle_$page_num_current$win_counter x
		curve2_handle_$page_num_current$win_counter GetVectorHandle y2_vector_handle_$page_num_current$win_counter y

		curve2_handle_$page_num_current$win_counter SetName "STEP_2"
		#set subcase_num [resh$t GetSubcaseList]

		x2_vector_handle_$page_num_current$win_counter SetType file
		y2_vector_handle_$page_num_current$win_counter SetType file

		x2_vector_handle_$page_num_current$win_counter SetFilename $op_file_path 
		y2_vector_handle_$page_num_current$win_counter SetFilename $op_file_path

		#posth$t GetModelHandle mh$t [posth$t GetActiveModel]
		#mh$t GetResultCtrlHandle resh$t

		#set subcase_num [resh$t GetSubcaseList]
		set curve_subcase_list [ x2_vector_handle_$page_num_current$win_counter GetSubcase ]
		
		set length_of_cases [ llength $curve_subcase_list ]

		#puts "subcase list is $curve_subcase_list"
		#puts "length of cases $length_of_cases"

		# ################## here subcase id retrival is pending ###################	
		
		if { $second_step_label =="" } {
		
		
		} else {

			x2_vector_handle_$page_num_current$win_counter SetSubcase "$second_step_label"
			y2_vector_handle_$page_num_current$win_counter SetSubcase "$second_step_label"

			if { $::GA_Report::disp_force == 1 } {
				x2_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
				y2_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
			
			} else {
			
				x2_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
				y2_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
			}
			
			x2_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			x2_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			
			y2_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			y2_vector_handle_$page_num_current$win_counter SetComponent "MAG"
		
		
			if { $::GA_Report::cbState(empty23) == 1} {
				#plot_handle_$page_num_current$win_counter Draw
				x2_vector_handle_$page_num_current$win_counter SetComponent "Time"
				x2_vector_handle_$page_num_current$win_counter SetOffset 1
				#hwc xy curve edit range="p:2 w:2 i:2" xoffset=1	
			}
		}
		#added if condition terminates here - for sigle step simulations.
   
   
		# set Third_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 3 ]

		if { $third_step_label =="" } {


		} else {

			plot_handle_$page_num_current$win_counter GetCurveHandle curve3_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
			curve3_handle_$page_num_current$win_counter GetVectorHandle x3_vector_handle_$page_num_current$win_counter x
			curve3_handle_$page_num_current$win_counter GetVectorHandle y3_vector_handle_$page_num_current$win_counter y

			curve3_handle_$page_num_current$win_counter SetName "STEP_3"
			
			x3_vector_handle_$page_num_current$win_counter SetType file
			y3_vector_handle_$page_num_current$win_counter SetType file

			x3_vector_handle_$page_num_current$win_counter SetFilename $op_file_path 
			y3_vector_handle_$page_num_current$win_counter SetFilename $op_file_path

			
			x3_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"
			y3_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"

			if { $::GA_Report::disp_force == 1 } {
				x3_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
				y3_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"

			} else {
				x3_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
				y3_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
			}
			x3_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			x3_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			y3_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			y3_vector_handle_$page_num_current$win_counter SetComponent "MAG"

				if { $::GA_Report::cbState(empty23) == 1} {
					#plot_handle_$page_num_current$win_counter Draw
					x3_vector_handle_$page_num_current$win_counter SetComponent "Time"
					x3_vector_handle_$page_num_current$win_counter SetOffset 2
					#hwc xy curve edit range="p:2 w:2 i:3" xoffset=2	
				}
		}


		if { $fourth_step_label =="" } {
		
		
		} else {


			plot_handle_$page_num_current$win_counter GetCurveHandle curve4_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
			curve4_handle_$page_num_current$win_counter GetVectorHandle x4_vector_handle_$page_num_current$win_counter x
			curve4_handle_$page_num_current$win_counter GetVectorHandle y4_vector_handle_$page_num_current$win_counter y

			curve4_handle_$page_num_current$win_counter SetName "STEP_4"

			x4_vector_handle_$page_num_current$win_counter SetType file
			y4_vector_handle_$page_num_current$win_counter SetType file

			x4_vector_handle_$page_num_current$win_counter SetFilename $op_file_path 
			y4_vector_handle_$page_num_current$win_counter SetFilename $op_file_path


			x4_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"
			y4_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"

			if { $::GA_Report::disp_force == 1 } {
				x4_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
				y4_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
			} else {
				x4_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
				y4_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"

			}

			x4_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			x4_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			
			y4_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			y4_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			if { $::GA_Report::cbState(empty23) == 1} {
				#plot_handle_$page_num_current$win_counter Draw
				x4_vector_handle_$page_num_current$win_counter SetComponent "Time"
				x4_vector_handle_$page_num_current$win_counter SetOffset 3
				#hwc xy curve edit range="p:2 w:2 i:4" xoffset=3
			}
		}

		if { $fifth_step_label =="" } {
		
		} else {
		
			plot_handle_$page_num_current$win_counter GetCurveHandle curve5_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
			curve5_handle_$page_num_current$win_counter GetVectorHandle x5_vector_handle_$page_num_current$win_counter x
			curve5_handle_$page_num_current$win_counter GetVectorHandle y5_vector_handle_$page_num_current$win_counter y

			curve5_handle_$page_num_current$win_counter SetName "STEP_5"
			
			x5_vector_handle_$page_num_current$win_counter SetType file
			y5_vector_handle_$page_num_current$win_counter SetType file

			x5_vector_handle_$page_num_current$win_counter SetFilename $op_file_path 
			y5_vector_handle_$page_num_current$win_counter SetFilename $op_file_path

			
			x5_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"
			y5_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"

			if { $::GA_Report::disp_force == 1 } {
		
				x5_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
				y5_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"

			} else {
				x5_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
				y5_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
			}
			
			x5_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			x5_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			
			y5_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			y5_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			if { $::GA_Report::cbState(empty23) == 1} {
				#plot_handle_$page_num_current$win_counter Draw
				x5_vector_handle_$page_num_current$win_counter SetComponent "Time"
				x5_vector_handle_$page_num_current$win_counter SetOffset 4
				#hwc xy curve edit range="p:2 w:2 i:5" xoffset=4
				
				
			}
		}

  
		if { $sixth_step_label =="" } {
		
		
		} else {

			plot_handle_$page_num_current$win_counter GetCurveHandle curve6_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
			curve6_handle_$page_num_current$win_counter GetVectorHandle x6_vector_handle_$page_num_current$win_counter x
			curve6_handle_$page_num_current$win_counter GetVectorHandle y6_vector_handle_$page_num_current$win_counter y

			curve6_handle_$page_num_current$win_counter SetName "STEP_6"
			
			x6_vector_handle_$page_num_current$win_counter SetType file
			y6_vector_handle_$page_num_current$win_counter SetType file

			x6_vector_handle_$page_num_current$win_counter SetFilename $op_file_path 
			y6_vector_handle_$page_num_current$win_counter SetFilename $op_file_path

			
			x6_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"
			y6_vector_handle_$page_num_current$win_counter SetSubcase "$third_step_label"

		
			if { $::GA_Report::disp_force == 1 } {
				x6_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
				y6_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
			} else {
				x6_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::curve_force_datatype"
				y6_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
		
			}

			x6_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			x6_vector_handle_$page_num_current$win_counter SetComponent "MAG"
			
			y6_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::n_master_id"
			y6_vector_handle_$page_num_current$win_counter SetComponent "MAG"

			if { $::GA_Report::cbState(empty23) == 1} {
				#plot_handle_$page_num_current$win_counter Draw
				x6_vector_handle_$page_num_current$win_counter SetComponent "Time"
				x2_vector_handle_$page_num_current$win_counter SetOffset 5
				#hwc xy curve edit range="p:2 w:2 i:6" xoffset=5
			}
		}
	}


	plot_handle_$page_num_current$win_counter GetLegendHandle iLegend_handle_$page_num_current$win_counter
	#iLegend_handle_$page_num_current$win_counter SetRasterPosition 2 , 99

	#plot_handle_$page_num_current$win_counter SetLegendLocation "left"
	plot_handle_$page_num_current$win_counter Recalculate
	plot_handle_$page_num_current$win_counter Autoscale
	plot_handle_$page_num_current$win_counter Draw


	#puts "curve window is done"



	# ########################################### CURVE WINDOW END ######################################################

	incr win_counter


	# ###########################################SECTION WINDOW START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path

	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter
		
		
	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#lappend ::GA_Report::x_list $x_of_base
	#lappend ::GA_Report::y_list $y_of_base
	#lappend ::GA_Report::z_list $z_of_base


	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features

	#anim_handle_$page_num_current$win_counter GetBestViewHandle bestview_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter AddBestView]
	#bestview_handle_$page_num_current$win_counter SetEntity element $pointer_element_of_trim
	#bestview_handle_$page_num_current$win_counter  SetViewMode contour
	#bestview_handle_$page_num_current$win_counter SetFocusRegionSize 100
	#bestview_handle_$page_num_current$win_counter SetGlobalVisibility hidden
	#bestview_handle_$page_num_current$win_counter SetNoteShowSpotID false
	#bestview_handle_$page_num_current$win_counter ActivateView
	#anim_handle_$page_num_current$win_counter Draw
	#anim_handle_$page_num_current$win_counter RemoveBestView 1
	#anim_handle_$page_num_current$win_counter Draw


	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation back

	section_cur_handle_$page_num_current$win_counter SetBaseNode $::GA_Report::master_node_id
	#section_cur_handle_$page_num_current$win_counter SetOrientation  "XAxis" " 1 0 0 "
	section_cur_handle_$page_num_current$win_counter SetOrientationMethod  "XAxis"

	section_cur_handle_$page_num_current$win_counter SetDeformMode true 
	section_cur_handle_$page_num_current$win_counter SetClipElements "True"
	section_cur_handle_$page_num_current$win_counter SetDisplayOption “gridtext” true
	section_cur_handle_$page_num_current$win_counter SetVisibility "True"
	section_cur_handle_$page_num_current$win_counter SetDisplayOption “gridtext” false
	section_cur_handle_$page_num_current$win_counter SetDisplayOption “gridlines” false

	anim_handle_$page_num_current$win_counter Draw

	#puts "one load page done - moving to biw"


	# ###########################################SECTION WINDOW END ######################################################		
	incr section_id 

	master_project AddPage
	set win_counter 1
	incr page_num_current

	# #########################################START BIW PLOTS ##############################################################

	master_project SetActivePage $page_num_current
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	#puts $op_file_cur
	page_handle$op_file_cur$page_num_current  SetLayout 1

	for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {
		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
		#puts $op_file_path


		anim_handle_$page_num_current$win_counter Draw
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		anim_handle_$page_num_current$win_counter Draw
		#puts "one file loaded"
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		model_handle_$page_num_current$win_counter SetResult $op_file_path
		#puts "result loaded"
		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter

		if { $win_counter == 2 } { 
			result_handle_$page_num_current$win_counter SetCurrentSubcase 2 
		}

		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true

		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 2
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		hwc result scalar legend values entitylabel=false

		hwc result scalar legend title font="{Noto Sans} 12 bold roman"
		hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
		hwc result scalar legend values minimum=false
		#hwc annotation note "Model Info" display text= "{for (i = 0; i != numpts(window.modeltitlelist); ++i) }\n{window.loadcaselist[i]} : {window.simulationsteplist[i]} : {window.framelist[i]}\n{endloop}"

		hwc annotation note "Model Info" display visibility=false
		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
		contour_handle_$page_num_current$win_counter SetDataComponent Mag
		#contour_handle_$page_num_current$win_counter SetLayer Max
		#contour_handle_$page_num_current$win_counter SetAverageMode simple

		anim_handle_$page_num_current$win_counter Draw

		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed


		foreach comp_biw_part $biw_only_comps_id { 	
			selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" 
		}

		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
		model_handle_$page_num_current$win_counter ReverseMask
		selection_handle_$page_num_current$win_counter Clear

		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

		selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
		if { $win_counter == 2 } {	
		
			model_handle_$page_num_current$win_counter UnMaskAll 
			anim_handle_$page_num_current$win_counter Draw
			selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
			selection_handle_comp_$page_num_current$win_counter SetSelectMode SetSelectMode all 

			set selection_set_one_d_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_one_d_$page_num_current$win_counter $selection_set_one_d_id
			selection_handle_one_d_$page_num_current$win_counter Add "dimension 1"
			selection_handle_one_d_$page_num_current$win_counter Add "dimension 0"
			model_handle_$page_num_current$win_counter Mask [selection_handle_one_d_$page_num_current$win_counter GetID]
			selection_handle_one_d_$page_num_current$win_counter Clear

		}

		selection_handle_comp_$page_num_current$win_counter Add all
			

		if { $win_counter == 2 } { 
			
			#model_handle_$page_num_current$win_counter UnMaskAll 
			set selection_set_id_comp_extra [ model_handle_$page_num_current$win_counter AddSelectionSet element]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_extra_$page_num_current$win_counter $selection_set_id_comp_extra
			selection_handle_extra_$page_num_current$win_counter Add "id $::GA_Report::tool_element_id"
			selection_handle_extra_$page_num_current$win_counter Add "Attached"
			model_handle_$page_num_current$win_counter Mask [selection_handle_extra_$page_num_current$win_counter GetID]
			selection_handle_extra_$page_num_current$win_counter Clear
			anim_handle_$page_num_current$win_counter Draw
			
		}
		legend_handle$page_num_current$win_counter SetType dynamic
		contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]
		model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]
		
		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
		anim_handle_$page_num_current$win_counter Draw


	}

	# ######################################### END BIW PLOTS ##############################################################	
	master_project AddPage
}

proc ::GA_Report::retainerforce_page { op_file_name op_file_path page_num_current } {

	master_session SetUserVariable SHOWUNITSDIALOG 0
	master_session SetUnitsProfile DEFAULT
	set retainer_strings_list [ list ]
	append retainer_strings_list "XXRET,"
	append retainer_strings_list $::GA_Report::retainer_strings
	set final_retainer_strings_list [ string map {"," " "} $retainer_strings_list ]

	foreach ret_cut_string $final_retainer_strings_list {
				
		master_session SetUserVariable SHOWUNITSDIALOG 0
		#puts $::GA_Report::retainer_strings
		#puts "retainer force selected"
		set retainer_element_list_01 [list]
		set retainer_element_name_list_01 [list]
		set retainer_list_$op_file_name [list]
		#puts $op_file_name
		set op_file $op_file_name
		
		if { $::GA_Report::c3var == "Abaqus_S" } {
			set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
			set op_file_path_curve $op_file_path
		}
				
		if { $::GA_Report::c3var == "PamCrash" } {
			set op_file_cur [ string map {".erfh5" ""} $op_file ]
			set op_file_path_curve $op_file_path
		}
				
		if { $::GA_Report::c3var == "LsDyna" } { 
				
			set op_file_cur $op_file
			set substring "d3plot"
			set variable $op_file_cur
			
			if {[string first $substring $variable] != -1} {
				set cut_string {d3plot} 
				set cut_slash {/} 
				set op_file_cur [ string trim $op_file_cur "$cut_string" ]
				set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
			
			} 
			set op_file_path_curve [ string map {"d3plot" "binout0000"} $op_file_path ]		
		}
		
		set t [::post::GetT];
		variable SecListIndex {}
		set win_counter 1
		set section_id 1

		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 3

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]

		#puts "one file loaded"

		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		set anim_counter $win_counter

		model_handle_$page_num_current$win_counter SetResult $op_file_path
		#puts "result loaded"

		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_control_handle_$page_num_current$win_counter
		set retainer_selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
		result_control_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_handle_$page_num_current$win_counter $retainer_selection_set_id


		model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter
		query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id

		#puts "retainer selection set is $retainer_selection_set_id"

		set data_component [ contour_handle_$page_num_current$win_counter GetDataComponent ]
		contour_handle_$page_num_current$win_counter SetDataComponent $data_component
		set layer [ contour_handle_$page_num_current$win_counter GetLayer ]
		contour_handle_$page_num_current$win_counter SetLayer $layer
		set data_type [ contour_handle_$page_num_current$win_counter GetDataType ]
		contour_handle_$page_num_current$win_counter SetDataType $data_type

		#### ADDED UNIQUE BELOW TO FLUSH OUT DUPLICATES
		#set $::GA_Report::one_d_element_list  [ lsort -unique $::GA_Report::one_d_element_list ]

		foreach one_d_element $::GA_Report::one_d_element_list_retainer {
			#puts "one d element $one_d_element"
			selection_set_handle_$page_num_current$win_counter SetSelectMode displayed
			selection_set_handle_$page_num_current$win_counter Add "id $one_d_element"
			query_handle_$page_num_current$win_counter SetDataSourceProperty contour datacomps "$data_component"
			query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id
			query_handle_$page_num_current$win_counter SetQuery "component.name"
			query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter$one_d_element
			set one_d_element_component [ iterator_handle_$page_num_current$win_counter$one_d_element GetDataList ]
			#puts "one d comp is $one_d_element_component"

			set exist [lsearch -all -inline $one_d_element_component *$ret_cut_string*]
			if { $exist > 0 } {  lappend retainer_element_list_01 $one_d_element }
			if { $exist > 0 } {  lappend retainer_element_name_list_01 $one_d_element_component }
			
			selection_set_handle_$page_num_current$win_counter Subtract "id $one_d_element"

		}

		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#

		#puts "retainer list is"
		#puts $retainer_element_list_01
		#puts "retainer name list is"
		#puts $retainer_element_name_list_01
		
		set retainer_length [ llength $retainer_element_list_01]

		selection_set_handle_$page_num_current$win_counter Clear

		# model style apply 

		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter SetColorMode model
		model_handle_$page_num_current$win_counter SetColor White
		model_handle_$page_num_current$win_counter SetPolygonMode transparent
		anim_handle_$page_num_current$win_counter Draw

		# ADD THR AXIAL AND SHEAR CURVE WINDOW START	


		incr win_counter
				
				
		for {set win_counter 2 } {$win_counter <= 3} {incr win_counter} {
			master_project SetActivePage $page_num_current
			page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
			#win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
			win_of$page_num_current$win_counter SetClientType plot
			win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter

			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter




			set x_counter 1
			set y_counter 2

			set retainer_pamcrash_name_counter 0
			set retainer_pamcrash_shear1_name_counter 0
			set retainer_pamcrash_shear2_name_counter 0
			set under_score "_"

			foreach retainer_type_elem $retainer_element_list_01 {
			
				if { $win_counter == 2 } {
					plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
					curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
					curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

					curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
					
					
					x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file

					#plot_handle_$page_num_current$win_counter Draw
					x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
					
					if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"		
								
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"		
					}
							
					if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
	
					}
	
					y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
					if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
									
					}
							
					if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
	
					}
					#plot_handle_$page_num_current$win_counter Draw

					if { $::GA_Report::c3var == "LsDyna" } { 
							
						#master_session SetUserVariable SHOWUNITSDIALOG 0
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"

						y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "axial"
		
					}
							
					if { $::GA_Report::c3var == "Abaqus_S" } {
							
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"
		
					}
							
							
					if { $::GA_Report::c3var == "PamCrash" } {
							
						set pam_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_name_counter ]
						set pam_request $pam_request_comp_name$under_score$retainer_type_elem
						#puts "PAM REQUEST IS $pam_request"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_request"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-X axis"
		
					}

					#puts "curve axial loaded"



					incr retainer_pamcrash_name_counter


				}

				if { $win_counter == 3 } {

					#master_session SetUserVariable SHOWUNITSDIALOG 0
					#puts "bind 1"
					#x component plotted.
					plot_handle_$page_num_current$win_counter GetCurveHandle x_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
					x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
					x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

					#puts "bind 1"

					#plot_handle_$page_num_current$win_counter Draw
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
									
					#plot_handle_$page_num_current$win_counter Draw


					if { $::GA_Report::c3var == "Abaqus_S" } {

                            #x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"	
							
					}
							
							
					if { $::GA_Report::c3var == "PamCrash" } {
    
						set pam_shear1_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear1_name_counter ]
						set pam_shear1_request $pam_shear1_request_comp_name$under_score$retainer_type_elem

						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear1_request"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Y axis"
	
					}
	
					if { $::GA_Report::c3var == "LsDyna" } { 
								
						#master_session SetUserVariable SHOWUNITSDIALOG 0
						#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
						
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"
						
						
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_t"
	
					}
					#puts "bind 2"
					if { ($::GA_Report::c3var == "Abaqus_S") || ($::GA_Report::c3var == "PamCrash") || ($::GA_Report::c3var == "LsDyna") } {

						#master_session SetUserVariable SHOWUNITSDIALOG 0
						x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False

						#y component plotted.
						plot_handle_$page_num_current$win_counter GetCurveHandle y_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
						y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
						y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file

						#plot_handle_$page_num_current$win_counter Draw
						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 

						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
						
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						#plot_handle_$page_num_current$win_counter Draw

						if { $::GA_Report::c3var == "Abaqus_S" } {
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"

						}

						if { $::GA_Report::c3var == "PamCrash" } {
							
							set pam_shear2_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear2_name_counter ]
							set pam_shear2_request $pam_shear2_request_comp_name$under_score$retainer_type_elem
							
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear2_request"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Z axis"
							
						}

						#puts "bind 3"
			
						if { $::GA_Report::c3var == "LsDyna" } { 
							
							#master_session SetUserVariable SHOWUNITSDIALOG 0
							#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"

							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_s"

						}


						y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False
						y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName y$retainer_type_elem

						#puts "bind 4"

						# #####################################################################################################################################
						# shear calculation follows.

						plot_handle_$page_num_current$win_counter GetCurveHandle xy_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
						xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
						xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

						xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem

						#set x_counter 1
						#set y_counter 2
						#puts "bind 5"

						set p_val p
						set w_val w
						set c_val c
						set x_val ".x"
						set y_val ".y"

						set first_x $p_val$page_num_current$w_val$win_counter$c_val$x_counter$x_val
						set first_y $p_val$page_num_current$w_val$win_counter$c_val$x_counter$y_val

						set second_x $p_val$page_num_current$w_val$win_counter$c_val$y_counter$x_val
						set second_y $p_val$page_num_current$w_val$win_counter$c_val$y_counter$y_val

						#puts "bind 6"

						xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math 
						xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y)) 


						#sync2x(trim_depvect(p8w3c16.x,p8w3c16.y),trim_depvect($second_x,$second_y))

						#sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y))


						xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math
						xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

						#sqrt((lininterp(trim_depvect(p8w3c16.x,p8w3c16.y),p8w3c16.y,x)^2)+(lininterp(trim_depvect(p8w3c32.x,p8w3c32.y),p8w3c32.y,x)^2))

						#sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

						xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility True

						incr x_counter 3
						incr y_counter 3

						#plot_handle_$page_num_current$win_counter Recalculate
						#plot_handle_$page_num_current$win_counter Autoscale
						#plot_handle_$page_num_current$win_counter Draw


							# ######################################################################################################################################

					}

							
					#puts "curve loaded"

					if { $win_counter == 3 } {
							
						incr retainer_pamcrash_shear1_name_counter
						incr retainer_pamcrash_shear2_name_counter
						#puts $retainer_pamcrash_shear1_name_counter
					}	
				}
				#SHEAR CALCULATION FROM X AND Y ENDS FOR ABAQUS

			}

			if { $win_counter == 2 } {

				plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
				y_axis_handle_$page_num_current$win_counter SetLabel "Axial Force($::GA_Report::force_unit)"

				plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
				x_axis_handle_$page_num_current$win_counter SetLabel "Time($::GA_Report::time_unit)"

			}

			if { $win_counter == 3 } {

				plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
				y_axis_handle_$page_num_current$win_counter SetLabel "Shear Force(N)"

				plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
				x_axis_handle_$page_num_current$win_counter SetLabel "Time (S)"

			}
			
			plot_handle_$page_num_current$win_counter SetLegendLocation "right"

			plot_handle_$page_num_current$win_counter Recalculate
			plot_handle_$page_num_current$win_counter Autoscale
			#plot_handle_$page_num_current$win_counter Draw


		}

		# SHEAR RESULTANT CURVE WINDOW.	

		# ADD THR AXIAL AND SHEAR CURVE WINDOW END	

		master_project AddPage
		incr page_num_current
		#unset retainer_list

		set name_inc 0

		set page_num_note [ expr { $page_num_current - 1 } ]
		set retainer_member_itr 1
		set max_y_text ".y"
		
		foreach retainer_member $retainer_element_list_01	{
				
			anim_handle_$page_num_note$anim_counter GetNoteHandle note_handle_$page_num_note$anim_counter$retainer_member_itr [ anim_handle_$page_num_note$anim_counter AddNote ]
			set notecurve_pointer_end w2c$retainer_member_itr$max_y_text
			set ret_curve_pointer p$page_num_note$notecurve_pointer_end

			if { $::GA_Report::c3var == "Abaqus_S" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
			if { $::GA_Report::c3var == "PamCrash" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
			
			if { $::GA_Report::c3var == "LsDyna" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
					
			set shearcurve_pointer_end w3c$shear_itr$max_y_text
			set shear_curve_pointer p$page_num_note$shearcurve_pointer_end

			#puts $ret_curve_pointer
			#puts $shear_curve_pointer
			

			set current_comp_name [ lindex $retainer_element_name_list_01 $name_inc ]
			set force_search "AXFVAL"
			set failure_val 0
			set fexist [lsearch -all -inline $current_comp_name *$force_search*]
					
			if { $fexist > 0 } {
				set connector_split [split $current_comp_name _]
				set pos_string [lsearch $connector_split AXFVAL]
				set axval_pos [ expr { $pos_string + 1}]
				set shearval_pos [ expr { $pos_string + 3}]
				set axial_limit [ lindex $connector_split $axval_pos]
				set shear_limit [ lindex $connector_split $shearval_pos]		
			}

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetAttachment "element $retainer_member"
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetPositionToAttachment true
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetFont "{Calibri} 8 normal roman"
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($ret_curve_pointer)}"
			set axial_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
			set axial_max_val [lindex $axial_text 0]
			
			#puts "axial text $axial_text"
			set axial_round [ expr {int(100*$axial_max_val +0.5)/100.0} ]

			#puts "axial value is $axial_max_val for $retainer_member"

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($shear_curve_pointer)}"
			set shear_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
			set shear_max_val [lindex $shear_text 0]
					
			#puts "shear text $shear_text"
			set shear_round [ expr {int(100*$shear_max_val +0.5)/100.0} ]


			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText " ID- $retainer_member \n Ax- $axial_round Sh- $shear_round"

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetTransparency False

			if { $fexist > 0 } {
				set failure_val [ expr { ( ($axial_max_val / $axial_limit) * ($axial_max_val / $axial_limit) ) + ( ($shear_max_val / $shear_limit) * ($shear_max_val / $shear_limit) ) }]
				
				if { $axial_max_val > $axial_limit } { set failure_val 2 }
				if { $shear_max_val > $shear_limit } { set failure_val 2 }
					
			}
		
			if { $failure_val > 1} { 
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor White
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "255 0 0"
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "fail_$name_inc"
					
			} else {
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor Black
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "0 255 0"
				note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "pass_$name_inc"
			}
					
			incr name_inc
			incr retainer_member_itr
					
		}
		anim_handle_$page_num_note$anim_counter Draw
	}
	# for each for retainer cut string ends here.
	return $page_num_current
	unset retainer_strings_list
	unset retainer_element_list_01
	unset retainer_element_name_list_01
	unset retainer_list
}


proc ::GA_Report::screwforce_page { op_file_name op_file_path page_num_current } {

	master_session SetUserVariable SHOWUNITSDIALOG 0
	master_session SetUnitsProfile DEFAULT
	set retainer_strings_list [ list ]
	append retainer_strings_list "XXSCR,"
	append retainer_strings_list $::GA_Report::retainer_strings
	set final_retainer_strings_list [ string map {"," " "} $retainer_strings_list ]

	foreach ret_cut_string $final_retainer_strings_list {
				
		master_session SetUserVariable SHOWUNITSDIALOG 0
		#puts $::GA_Report::retainer_strings
		#puts "retainer force selected"
		set retainer_element_list_01 [list]
		set retainer_element_name_list_01 [list]
		set retainer_list_$op_file_name [list]
		#puts $op_file_name
		set op_file $op_file_name
		
		if { $::GA_Report::c3var == "Abaqus_S" } {
			set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
			set op_file_path_curve $op_file_path
		}
				
		if { $::GA_Report::c3var == "PamCrash" } {
			set op_file_cur [ string map {".erfh5" ""} $op_file ]
			set op_file_path_curve $op_file_path
		}
				
		if { $::GA_Report::c3var == "LsDyna" } { 

			set op_file_cur $op_file
			set substring "d3plot"
			set variable $op_file_cur

			if {[string first $substring $variable] != -1} {
				set cut_string {d3plot} 
				set cut_slash {/} 
				set op_file_cur [ string trim $op_file_cur "$cut_string" ]
				set op_file_cur [ string trim $op_file_cur "$cut_slash" ]

			} 

			set op_file_path_curve [ string map {"d3plot" "binout0000"} $op_file_path ]
		}
				

		set t [::post::GetT];
		variable SecListIndex {}
		set win_counter 1
		set section_id 1

		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 3

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]

		#puts "one file loaded"

		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		set anim_counter $win_counter

		model_handle_$page_num_current$win_counter SetResult $op_file_path
		#puts "result loaded"

		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_control_handle_$page_num_current$win_counter
		set retainer_selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
		result_control_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_handle_$page_num_current$win_counter $retainer_selection_set_id


		model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter
		query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id

		#puts "retainer selection set is $retainer_selection_set_id"

		set data_component [ contour_handle_$page_num_current$win_counter GetDataComponent ]
		contour_handle_$page_num_current$win_counter SetDataComponent $data_component
		set layer [ contour_handle_$page_num_current$win_counter GetLayer ]
		contour_handle_$page_num_current$win_counter SetLayer $layer
		set data_type [ contour_handle_$page_num_current$win_counter GetDataType ]
		contour_handle_$page_num_current$win_counter SetDataType $data_type

		#### ADDED UNIQUE BELOW TO FLUSH OUT DUPLICATES
		#set $::GA_Report::one_d_element_list  [ lsort -unique $::GA_Report::one_d_element_list ]

		foreach one_d_element $::GA_Report::one_d_element_list_retainer {
			#puts "one d element $one_d_element"
			selection_set_handle_$page_num_current$win_counter SetSelectMode displayed
			selection_set_handle_$page_num_current$win_counter Add "id $one_d_element"
			query_handle_$page_num_current$win_counter SetDataSourceProperty contour datacomps "$data_component"
			query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id
			query_handle_$page_num_current$win_counter SetQuery "component.name"
			query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter$one_d_element
			set one_d_element_component [ iterator_handle_$page_num_current$win_counter$one_d_element GetDataList ]
			#puts "one d comp is $one_d_element_component"

			set exist [lsearch -all -inline $one_d_element_component *$ret_cut_string*]
			if { $exist > 0 } {  lappend retainer_element_list_01 $one_d_element }
			if { $exist > 0 } {  lappend retainer_element_name_list_01 $one_d_element_component }
			
			selection_set_handle_$page_num_current$win_counter Subtract "id $one_d_element"

		}

		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#

		#puts "retainer list is"
		#puts $retainer_element_list_01
		#puts "retainer name list is"
		#puts $retainer_element_name_list_01
		
		set retainer_length [ llength $retainer_element_list_01]

		selection_set_handle_$page_num_current$win_counter Clear

		# model style apply 

		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter SetColorMode model
		model_handle_$page_num_current$win_counter SetColor White
		model_handle_$page_num_current$win_counter SetPolygonMode transparent
		anim_handle_$page_num_current$win_counter Draw

		# ADD THR AXIAL AND SHEAR CURVE WINDOW START	


		incr win_counter
				
				
		for {set win_counter 2 } {$win_counter <= 3} {incr win_counter} {
			master_project SetActivePage $page_num_current
			page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
			#win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
			win_of$page_num_current$win_counter SetClientType plot
			win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter

			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter

			set x_counter 1
			set y_counter 2

			set retainer_pamcrash_name_counter 0
			set retainer_pamcrash_shear1_name_counter 0
			set retainer_pamcrash_shear2_name_counter 0
			set under_score "_"

			foreach retainer_type_elem $retainer_element_list_01 {
				if { $win_counter == 2 } {

					plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
					curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
					curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

					curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
									
					x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file

					#plot_handle_$page_num_current$win_counter Draw
					x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
							
					if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
					}
							
					if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
								
							
					}
		
					y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
					if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
					}
							
					if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
						
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
		
					}
							#plot_handle_$page_num_current$win_counter Draw

					if { $::GA_Report::c3var == "LsDyna" } { 
								
						#master_session SetUserVariable SHOWUNITSDIALOG 0
						
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"


						y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
						y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "axial"
		
					}
							
					if { $::GA_Report::c3var == "Abaqus_S" } {
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"
	
					}
							
							
					if { $::GA_Report::c3var == "PamCrash" } {
							
							set pam_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_name_counter ]
							set pam_request $pam_request_comp_name$under_score$retainer_type_elem
							#puts "PAM REQUEST IS $pam_request"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_request"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-X axis"

					}
					#puts "curve axial loaded"
					incr retainer_pamcrash_name_counter
				}

				if { $win_counter == 3 } {

					#master_session SetUserVariable SHOWUNITSDIALOG 0					
					#x component plotted.
					plot_handle_$page_num_current$win_counter GetCurveHandle x_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
					x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
					x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

					#plot_handle_$page_num_current$win_counter Draw
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
					x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
								
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
					x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
					
					
					#plot_handle_$page_num_current$win_counter Draw


					if { $::GA_Report::c3var == "Abaqus_S" } {

						#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"
							
							
					}
							
							
					if { $::GA_Report::c3var == "PamCrash" } {

						set pam_shear1_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear1_name_counter ]
						set pam_shear1_request $pam_shear1_request_comp_name$under_score$retainer_type_elem
				
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear1_request"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Y axis"
		
					}
		
							
					if { $::GA_Report::c3var == "LsDyna" } { 
							
							
						#master_session SetUserVariable SHOWUNITSDIALOG 0
						#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
						
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
						x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"
						
						
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
						x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_t"
		
							
					}
							#puts "bind 2"
					if { ($::GA_Report::c3var == "Abaqus_S") || ($::GA_Report::c3var == "PamCrash") || ($::GA_Report::c3var == "LsDyna") } {

							#master_session SetUserVariable SHOWUNITSDIALOG 0
							x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False
							
							#y component plotted.
							plot_handle_$page_num_current$win_counter GetCurveHandle y_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file

							#plot_handle_$page_num_current$win_counter Draw
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"

							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							#plot_handle_$page_num_current$win_counter Draw

							if { $::GA_Report::c3var == "Abaqus_S" } {
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"

							}

							if { $::GA_Report::c3var == "PamCrash" } {
							
								set pam_shear2_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear2_name_counter ]
								set pam_shear2_request $pam_shear2_request_comp_name$under_score$retainer_type_elem
								
								
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear2_request"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Z axis"
							
							
							}

							#puts "bind 3"
			
							if { $::GA_Report::c3var == "LsDyna" } { 							
								#master_session SetUserVariable SHOWUNITSDIALOG 0
								#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
								
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
								
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
								y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"
	
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
								y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_s"

							}


							y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName y$retainer_type_elem

							# #####################################################################################################################################
							# shear calculation follows.

							plot_handle_$page_num_current$win_counter GetCurveHandle xy_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem

							#set x_counter 1
							#set y_counter 2
							#puts "bind 5"

							set p_val p
							set w_val w
							set c_val c
							set x_val ".x"
							set y_val ".y"

							set first_x $p_val$page_num_current$w_val$win_counter$c_val$x_counter$x_val
							set first_y $p_val$page_num_current$w_val$win_counter$c_val$x_counter$y_val

							set second_x $p_val$page_num_current$w_val$win_counter$c_val$y_counter$x_val
							set second_y $p_val$page_num_current$w_val$win_counter$c_val$y_counter$y_val

							#puts "bind 6"

							xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math 
							xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y)) 


							#sync2x(trim_depvect(p8w3c16.x,p8w3c16.y),trim_depvect($second_x,$second_y))

							#sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y))


							xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math
							xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

							#sqrt((lininterp(trim_depvect(p8w3c16.x,p8w3c16.y),p8w3c16.y,x)^2)+(lininterp(trim_depvect(p8w3c32.x,p8w3c32.y),p8w3c32.y,x)^2))

							#sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility True

							incr x_counter 3
							incr y_counter 3

							#plot_handle_$page_num_current$win_counter Recalculate
							#plot_handle_$page_num_current$win_counter Autoscale
							#plot_handle_$page_num_current$win_counter Draw


							# ######################################################################################################################################	
						
					}

					if { $win_counter == 3 } {
							
						incr retainer_pamcrash_shear1_name_counter
						incr retainer_pamcrash_shear2_name_counter
						#puts $retainer_pamcrash_shear1_name_counter
						
					}
						
						
						
				}
						#SHEAR CALCULATION FROM X AND Y ENDS FOR ABAQUS
			}




			if { $win_counter == 2 } {

				plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
				y_axis_handle_$page_num_current$win_counter SetLabel "Axial Force($::GA_Report::force_unit)"

				plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
				x_axis_handle_$page_num_current$win_counter SetLabel "Time($::GA_Report::time_unit)"

			}

			if { $win_counter == 3 } {

				plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
				y_axis_handle_$page_num_current$win_counter SetLabel "Shear Force(N)"

				plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
				x_axis_handle_$page_num_current$win_counter SetLabel "Time (S)"

			}



					plot_handle_$page_num_current$win_counter SetLegendLocation "right"

					plot_handle_$page_num_current$win_counter Recalculate
					plot_handle_$page_num_current$win_counter Autoscale
					#plot_handle_$page_num_current$win_counter Draw


		}

		# SHEAR RESULTANT CURVE WINDOW.	
		# ADD THR AXIAL AND SHEAR CURVE WINDOW END	
		master_project AddPage
		incr page_num_current
		#unset retainer_list

		set name_inc 0

		set page_num_note [ expr { $page_num_current - 1 } ]
		set retainer_member_itr 1
		set max_y_text ".y"
		foreach retainer_member $retainer_element_list_01	{
				
			anim_handle_$page_num_note$anim_counter GetNoteHandle note_handle_$page_num_note$anim_counter$retainer_member_itr [ anim_handle_$page_num_note$anim_counter AddNote ]
			set notecurve_pointer_end w2c$retainer_member_itr$max_y_text
			set ret_curve_pointer p$page_num_note$notecurve_pointer_end

			if { $::GA_Report::c3var == "Abaqus_S" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
			if { $::GA_Report::c3var == "PamCrash" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
			
			if { $::GA_Report::c3var == "LsDyna" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
			
			set shearcurve_pointer_end w3c$shear_itr$max_y_text
			set shear_curve_pointer p$page_num_note$shearcurve_pointer_end

			#puts $ret_curve_pointer
			#puts $shear_curve_pointer
			

			set current_comp_name [ lindex $retainer_element_name_list_01 $name_inc ]
			set force_search "AXFVAL"
			set failure_val 0
			set fexist [lsearch -all -inline $current_comp_name *$force_search*]
					
			if { $fexist > 0 } {
					
				set connector_split [split $current_comp_name _]
				set pos_string [lsearch $connector_split AXFVAL]
				set axval_pos [ expr { $pos_string + 1}]
				set shearval_pos [ expr { $pos_string + 3}]
				set axial_limit [ lindex $connector_split $axval_pos]
				set shear_limit [ lindex $connector_split $shearval_pos]	
					
			}

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetAttachment "element $retainer_member"
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetPositionToAttachment true
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetFont "{Calibri} 8 normal roman"
			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($ret_curve_pointer)}"
			set axial_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
			set axial_max_val [lindex $axial_text 0]
			
			#puts "axial text $axial_text"
			set axial_round [ expr {int(100*$axial_max_val +0.5)/100.0} ]

			#puts "axial value is $axial_max_val for $retainer_member"

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($shear_curve_pointer)}"
			set shear_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
			set shear_max_val [lindex $shear_text 0]
					
			#puts "shear text $shear_text"
			set shear_round [ expr {int(100*$shear_max_val +0.5)/100.0} ]


			note_handle_$page_num_note$anim_counter$retainer_member_itr SetText " ID- $retainer_member \n Ax- $axial_round Sh- $shear_round"

			note_handle_$page_num_note$anim_counter$retainer_member_itr SetTransparency False

			if { $fexist > 0 } {
				set failure_val [ expr { ( ($axial_max_val / $axial_limit) * ($axial_max_val / $axial_limit) ) + ( ($shear_max_val / $shear_limit) * ($shear_max_val / $shear_limit) ) }]
				
				if { $axial_max_val > $axial_limit } { set failure_val 2 }
				if { $shear_max_val > $shear_limit } { set failure_val 2 }
					
			}		
					
			if { $failure_val > 1} { 
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor White
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "255 0 0"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "fail_$name_inc"
					
			} else {
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor Black
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "0 255 0"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "pass_$name_inc"
			}
					
			incr name_inc
			incr retainer_member_itr
		}
		anim_handle_$page_num_note$anim_counter Draw
	}
	# for each for retainer cut string ends here.
	return $page_num_current
	unset retainer_strings_list
	unset retainer_element_list_01
	unset retainer_element_name_list_01
	unset retainer_list


}



proc ::GA_Report::htforce_page { op_file_name op_file_path page_num_current } {

		master_session SetUserVariable SHOWUNITSDIALOG 0
		master_session SetUnitsProfile DEFAULT
		set retainer_strings_list [ list ]
		append retainer_strings_list "XXHT,"
		append retainer_strings_list $::GA_Report::retainer_strings
		set final_retainer_strings_list [ string map {"," " "} $retainer_strings_list ]

			foreach ret_cut_string $final_retainer_strings_list {
				
				master_session SetUserVariable SHOWUNITSDIALOG 0
				#puts $::GA_Report::retainer_strings
				#puts "retainer force selected"
				set retainer_element_list_01 [list]
				set retainer_element_name_list_01 [list]
				set retainer_list_$op_file_name [list]
				#puts $op_file_name
				set op_file $op_file_name
				
				if { $::GA_Report::c3var == "Abaqus_S" } {
				set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
				set op_file_path_curve $op_file_path
				
				
				
				}
				
				if { $::GA_Report::c3var == "PamCrash" } {
				set op_file_cur [ string map {".erfh5" ""} $op_file ]
				set op_file_path_curve $op_file_path
				}
				
				if { $::GA_Report::c3var == "LsDyna" } { 
				
				set op_file_cur $op_file
				
				set substring "d3plot"
				set variable $op_file_cur
				
					if {[string first $substring $variable] != -1} {
    

					set cut_string {d3plot} 
					set cut_slash {/} 
					set op_file_cur [ string trim $op_file_cur "$cut_string" ]
					set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
				
					} 
				
				set op_file_path_curve [ string map {"d3plot" "binout0000"} $op_file_path ]
				
				
				
				}
				

				set t [::post::GetT];
				variable SecListIndex {}
				set win_counter 1
				set section_id 1

				#puts $op_file_cur
				master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
				page_handle$op_file_cur$page_num_current  SetLayout 3


				page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
				win_of$page_num_current$win_counter SetClientType animation
				win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
				set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]

				#puts "one file loaded"

				anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
				set anim_counter $win_counter

				model_handle_$page_num_current$win_counter SetResult $op_file_path
				#puts "result loaded"

				model_handle_$page_num_current$win_counter GetResultCtrlHandle result_control_handle_$page_num_current$win_counter
				set retainer_selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
				result_control_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter

				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_handle_$page_num_current$win_counter $retainer_selection_set_id


				model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter
				query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id

				#puts "retainer selection set is $retainer_selection_set_id"

				set data_component [ contour_handle_$page_num_current$win_counter GetDataComponent ]
				contour_handle_$page_num_current$win_counter SetDataComponent $data_component
				set layer [ contour_handle_$page_num_current$win_counter GetLayer ]
				contour_handle_$page_num_current$win_counter SetLayer $layer
				set data_type [ contour_handle_$page_num_current$win_counter GetDataType ]
				contour_handle_$page_num_current$win_counter SetDataType $data_type

				#### ADDED UNIQUE BELOW TO FLUSH OUT DUPLICATES
				#set $::GA_Report::one_d_element_list  [ lsort -unique $::GA_Report::one_d_element_list ]

				foreach one_d_element $::GA_Report::one_d_element_list_retainer {
					#puts "one d element $one_d_element"
					selection_set_handle_$page_num_current$win_counter SetSelectMode displayed
					selection_set_handle_$page_num_current$win_counter Add "id $one_d_element"
					query_handle_$page_num_current$win_counter SetDataSourceProperty contour datacomps "$data_component"
					query_handle_$page_num_current$win_counter SetSelectionSet $retainer_selection_set_id
					query_handle_$page_num_current$win_counter SetQuery "component.name"
					query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter$one_d_element
					set one_d_element_component [ iterator_handle_$page_num_current$win_counter$one_d_element GetDataList ]
					#puts "one d comp is $one_d_element_component"

					set exist [lsearch -all -inline $one_d_element_component *$ret_cut_string*]
					if { $exist > 0 } {  lappend retainer_element_list_01 $one_d_element }
                    if { $exist > 0 } {  lappend retainer_element_name_list_01 $one_d_element_component }
					
					selection_set_handle_$page_num_current$win_counter Subtract "id $one_d_element"

				}

				#----------------------HIDE NOTE START---------------------------#
				anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
				Note_hide_$page_num_current$win_counter SetVisibility False
				#----------------------HIDE NOTE END-----------------------------#

				#puts "retainer list is"
				#puts $retainer_element_list_01
				#puts "retainer name list is"
				#puts $retainer_element_name_list_01
				
				set retainer_length [ llength $retainer_element_list_01]

				selection_set_handle_$page_num_current$win_counter Clear

				# model style apply 

				win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
				fit_control_$page_num_current$win_counter Fit
				fit_control_$page_num_current$win_counter SetOrientation right



				model_handle_$page_num_current$win_counter SetMeshMode features
				model_handle_$page_num_current$win_counter SetColorMode model
				model_handle_$page_num_current$win_counter SetColor White
				model_handle_$page_num_current$win_counter SetPolygonMode transparent
				anim_handle_$page_num_current$win_counter Draw

				# ADD THR AXIAL AND SHEAR CURVE WINDOW START	


				incr win_counter
				
				
				for {set win_counter 2 } {$win_counter <= 3} {incr win_counter} {
					master_project SetActivePage $page_num_current
					page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
					#win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
					win_of$page_num_current$win_counter SetClientType plot
					win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter

					page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter




					set x_counter 1
					set y_counter 2

					set retainer_pamcrash_name_counter 0
					set retainer_pamcrash_shear1_name_counter 0
					set retainer_pamcrash_shear2_name_counter 0
					set under_score "_"

					foreach retainer_type_elem $retainer_element_list_01 {


					

						if { $win_counter == 2 } {



							plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

							curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file

							





							

							#plot_handle_$page_num_current$win_counter Draw
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
							
							if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							}
							
							if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							}
							
							
							
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
							if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							}
							
							if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } { 
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							}
							#plot_handle_$page_num_current$win_counter Draw

							if { $::GA_Report::c3var == "LsDyna" } { 
							
							
							#master_session SetUserVariable SHOWUNITSDIALOG 0
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"


							y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "axial"
							
							
							
							
							}
							
							if { $::GA_Report::c3var == "Abaqus_S" } {
							
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF1-Connector element total force"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"
							
							
							
							
							}
							
							
							if { $::GA_Report::c3var == "PamCrash" } {
							
							set pam_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_name_counter ]
							set pam_request $pam_request_comp_name$under_score$retainer_type_elem
							#puts "PAM REQUEST IS $pam_request"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_request"
							y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-X axis"
							
							
							
							
							}
							
							
							
							
							
							
							
							
							
							#puts "curve axial loaded"



						incr retainer_pamcrash_name_counter


						}

						if { $win_counter == 3 } {



							#master_session SetUserVariable SHOWUNITSDIALOG 0
							
							#puts "bind 1"

                            
							#x component plotted.
							plot_handle_$page_num_current$win_counter GetCurveHandle x_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							x_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y
							
							
							
							
							
							#puts "bind 1"
							

							

							#plot_handle_$page_num_current$win_counter Draw
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							
							
							
							
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							
							#plot_handle_$page_num_current$win_counter Draw


							if { $::GA_Report::c3var == "Abaqus_S" } {

                            #x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF2-Connector element total force"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"
							
							
							}
							
							
							if { $::GA_Report::c3var == "PamCrash" } {

                            
							set pam_shear1_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear1_name_counter ]
							set pam_shear1_request $pam_shear1_request_comp_name$under_score$retainer_type_elem
							
							
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear1_request"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Y axis"
							
							
							
							
							
							
							
							}
							
							
							
							
							
							
							
							
							
							
							if { $::GA_Report::c3var == "LsDyna" } { 
							
							
							#master_session SetUserVariable SHOWUNITSDIALOG 0
							#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							x_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"
							
							
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
							x_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_t"
							
							
							
							
							
							}
							#puts "bind 2"
							if { ($::GA_Report::c3var == "Abaqus_S") || ($::GA_Report::c3var == "PamCrash") || ($::GA_Report::c3var == "LsDyna") } {

							#master_session SetUserVariable SHOWUNITSDIALOG 0
							x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False
							
							#y component plotted.
							plot_handle_$page_num_current$win_counter GetCurveHandle y_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType file


							


							

							#plot_handle_$page_num_current$win_counter Draw
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve 
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"


							
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetFilename $op_file_path_curve
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "time"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "length"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnitType "mass"			
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetMetaData HWUnit "none"
							#plot_handle_$page_num_current$win_counter Draw

								if { $::GA_Report::c3var == "Abaqus_S" } {
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "CTF3-Connector element total force"
									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "E$retainer_type_elem"
									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Value"

									}

								if { $::GA_Report::c3var == "PamCrash" } {
							
									set pam_shear2_request_comp_name [ lindex $retainer_element_name_list_01 $retainer_pamcrash_shear2_name_counter ]
									set pam_shear2_request $pam_shear2_request_comp_name$under_score$retainer_type_elem
									
									
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Time"
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
									y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Time"

									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Spring (Time History)"
									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$pam_shear2_request"
									y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Force-Z axis"
							
							
							
							
							
							
								}

								#puts "bind 3"
			
								if { $::GA_Report::c3var == "LsDyna" } { 
							
							
							#master_session SetUserVariable SHOWUNITSDIALOG 0
							#x_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetSubcase elout
							
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "Index"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "Time"
							y_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "Index"
							
							
							
							
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem  SetSubcase elout
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetDataType "beam"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetRequest "$retainer_type_elem"
							y_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetComponent "shear_s"
							
							
							
							
							
							}


							y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility False
							y_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName y$retainer_type_elem

							#puts "bind 4"






							# #####################################################################################################################################
							# shear calculation follows.

							plot_handle_$page_num_current$win_counter GetCurveHandle xy_curve_handle_$page_num_current$win_counter$retainer_type_elem [ plot_handle_$page_num_current$win_counter AddCurve]
							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem x
							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem GetVectorHandle xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem y

							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetName $retainer_type_elem

							#set x_counter 1
							#set y_counter 2
							#puts "bind 5"

							set p_val p
							set w_val w
							set c_val c
							set x_val ".x"
							set y_val ".y"

							set first_x $p_val$page_num_current$w_val$win_counter$c_val$x_counter$x_val
							set first_y $p_val$page_num_current$w_val$win_counter$c_val$x_counter$y_val

							set second_x $p_val$page_num_current$w_val$win_counter$c_val$y_counter$x_val
							set second_y $p_val$page_num_current$w_val$win_counter$c_val$y_counter$y_val

							#puts "bind 6"

							xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math 
							xy_x_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y)) 


							#sync2x(trim_depvect(p8w3c16.x,p8w3c16.y),trim_depvect($second_x,$second_y))

							#sync2x(trim_depvect($first_x,$first_y),trim_depvect($second_x,$second_y))


							xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetType Math
							xy_y_vector_handle_$page_num_current$win_counter$retainer_type_elem SetExpression sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

							#sqrt((lininterp(trim_depvect(p8w3c16.x,p8w3c16.y),p8w3c16.y,x)^2)+(lininterp(trim_depvect(p8w3c32.x,p8w3c32.y),p8w3c32.y,x)^2))

							#sqrt((lininterp(trim_depvect($first_x,$first_y),$first_y,x)^2)+(lininterp(trim_depvect($second_x,$second_y),$second_y,x)^2))

							xy_curve_handle_$page_num_current$win_counter$retainer_type_elem SetVisibility True

							incr x_counter 3
							incr y_counter 3

							#plot_handle_$page_num_current$win_counter Recalculate
							#plot_handle_$page_num_current$win_counter Autoscale
							#plot_handle_$page_num_current$win_counter Draw


							# ######################################################################################################################################

						
						
						
						
						}

							
							#puts "curve loaded"

							if { $win_counter == 3 } {
							
								incr retainer_pamcrash_shear1_name_counter
								incr retainer_pamcrash_shear2_name_counter
								#puts $retainer_pamcrash_shear1_name_counter
						
						
							}
						
						
						
						}
						#SHEAR CALCULATION FROM X AND Y ENDS FOR ABAQUS

						

					}




					if { $win_counter == 2 } {

						plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
						y_axis_handle_$page_num_current$win_counter SetLabel "Axial Force($::GA_Report::force_unit)"

						plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
						x_axis_handle_$page_num_current$win_counter SetLabel "Time($::GA_Report::time_unit)"

					}




					if { $win_counter == 3 } {

						plot_handle_$page_num_current$win_counter GetVerticalAxisHandle y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
						y_axis_handle_$page_num_current$win_counter SetLabel "Shear Force(N)"

						plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]
						x_axis_handle_$page_num_current$win_counter SetLabel "Time (S)"

					}



					plot_handle_$page_num_current$win_counter SetLegendLocation "right"

					plot_handle_$page_num_current$win_counter Recalculate
					plot_handle_$page_num_current$win_counter Autoscale
					#plot_handle_$page_num_current$win_counter Draw


				}


				# SHEAR RESULTANT CURVE WINDOW.	





				# ADD THR AXIAL AND SHEAR CURVE WINDOW END	



				master_project AddPage
				incr page_num_current
				#unset retainer_list

                set name_inc 0

				set page_num_note [ expr { $page_num_current - 1 } ]
				set retainer_member_itr 1
				set max_y_text ".y"
				foreach retainer_member $retainer_element_list_01	{
				
				    

					anim_handle_$page_num_note$anim_counter GetNoteHandle note_handle_$page_num_note$anim_counter$retainer_member_itr [ anim_handle_$page_num_note$anim_counter AddNote ]
					set notecurve_pointer_end w2c$retainer_member_itr$max_y_text
					set ret_curve_pointer p$page_num_note$notecurve_pointer_end



					if { $::GA_Report::c3var == "Abaqus_S" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
					if { $::GA_Report::c3var == "PamCrash" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
					
					if { $::GA_Report::c3var == "LsDyna" } { 	set shear_itr [ expr { $retainer_member_itr * 3} ] }
					
					set shearcurve_pointer_end w3c$shear_itr$max_y_text
					set shear_curve_pointer p$page_num_note$shearcurve_pointer_end

					#puts $ret_curve_pointer
					#puts $shear_curve_pointer
					

					set current_comp_name [ lindex $retainer_element_name_list_01 $name_inc ]
					set force_search "AXFVAL"
					set failure_val 0
					set fexist [lsearch -all -inline $current_comp_name *$force_search*]
					
					if { $fexist > 0 } {
					
					set connector_split [split $current_comp_name _]
					set pos_string [lsearch $connector_split AXFVAL]
					set axval_pos [ expr { $pos_string + 1}]
					set shearval_pos [ expr { $pos_string + 3}]
					set axial_limit [ lindex $connector_split $axval_pos]
					set shear_limit [ lindex $connector_split $shearval_pos]
					
					
					
					}
					
					
				
					
					


					note_handle_$page_num_note$anim_counter$retainer_member_itr SetAttachment "element $retainer_member"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetPositionToAttachment true
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetFont "{Calibri} 8 normal roman"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($ret_curve_pointer)}"
					set axial_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
					set axial_max_val [lindex $axial_text 0]
					
					#puts "axial text $axial_text"
					set axial_round [ expr {int(100*$axial_max_val +0.5)/100.0} ]

					#puts "axial value is $axial_max_val for $retainer_member"

					note_handle_$page_num_note$anim_counter$retainer_member_itr SetText "{max($shear_curve_pointer)}"
					set shear_text [note_handle_$page_num_note$anim_counter$retainer_member_itr GetExpandedText]
					set shear_max_val [lindex $shear_text 0]
					
					#puts "shear text $shear_text"
					set shear_round [ expr {int(100*$shear_max_val +0.5)/100.0} ]


					note_handle_$page_num_note$anim_counter$retainer_member_itr SetText " ID- $retainer_member \n Ax- $axial_round Sh- $shear_round"

                    note_handle_$page_num_note$anim_counter$retainer_member_itr SetTransparency False

				    if { $fexist > 0 } {
				    set failure_val [ expr { ( ($axial_max_val / $axial_limit) * ($axial_max_val / $axial_limit) ) + ( ($shear_max_val / $shear_limit) * ($shear_max_val / $shear_limit) ) }]
					
					if { $axial_max_val > $axial_limit } { set failure_val 2 }
					if { $shear_max_val > $shear_limit } { set failure_val 2 }
					
                    }

                    
					
					
					if { $failure_val > 1} { 
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor White
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "255 0 0"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "fail_$name_inc"
					
					} else {
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetTextColor Black
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetBackgroundColor "0 255 0"
					note_handle_$page_num_note$anim_counter$retainer_member_itr SetLabel "pass_$name_inc"
					}
					
					incr name_inc
					

					incr retainer_member_itr
					

				}
				anim_handle_$page_num_note$anim_counter Draw







			}
			# for each for retainer cut string ends here.




			return $page_num_current
			unset retainer_strings_list
			unset retainer_element_list_01
			unset retainer_element_name_list_01
			unset retainer_list


		}

proc ::GA_Report::a_surface_strain { op_file_name op_file_path page_num_current  } {



					#puts $op_file_name
					set op_file $op_file_name
					
					
					
					if { $::GA_Report::c3var == "Abaqus_S" } {
					set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
					}
					
					if { $::GA_Report::c3var == "PamCrash" } {
				set op_file_cur [ string map {".erfh5" ""} $op_file ]
				
				}
					
					
					#puts "first op file cur after trim is $op_file_cur"
					
					if { $::GA_Report::c3var == "LsDyna" } {

						
						if { $::GA_Report::user_master_id >= 1 } { 
							set ::GA_Report::master_node_id $::GA_Report::user_master_id

							} else {

							set ::GA_Report::master_node_id 1001

							}
					    set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"



						#puts "solver is LS DYNA -setting values"

						set ::GA_Report::solver_extension ""
						set ::GA_Report::plot_disp_datatype "Displacement" 
						
						
						
						set ::GA_Report::stress_datatype "Stress"
						set ::GA_Report::strain_datatype "Effective plastic strain"
						
						set ::GA_Report::stress_datacomp "vonMises"
						set ::GA_Report::strain_datacomp "Scalar value"
						
						set ::GA_Report::curve_disp_datatype  "Displacement"
						set ::GA_Report::curve_force_datatype "discrete/nodes"
						
						set ::GA_Report::x_curve_comp "resultant_force"
						set ::GA_Report::y_curve_comp "Mag"
						
						set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
						set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
						
						   
						set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
						
						set ::GA_Report::x_joint_component_type	"Time"

						set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
						
						set ::GA_Report::y_joint_component_type "Value"
						
						set cut_string {d3plot} 
						set cut_slash {/} 
						set op_file_cur $op_file
						set dyna_just_name [ string trim $op_file_cur "$cut_string" ]
						set dyna_just_name [ string trim $dyna_just_name "$cut_slash" ]
						set op_file_cur [ string trim $op_file_cur "$cut_string" ]
						set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
						#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
						
						#puts "op file path is $op_file_path"
						
						set op_file_curve_y $op_file_path
						set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
						
						#puts $op_file_curve_x
						#puts $op_file_curve_y
						

					}



					set t [::post::GetT];
					variable SecListIndex {}
					set win_counter 1
					set section_id 1

					set dir_name_to_read $::GA_Report::dir_for_parts_list
					set formatcsv200 ".csv"
					set slash_200 "/"
					set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"

					if { $::GA_Report::c3var == "Abaqus_S" } {
						set solver_inp_form $op_file_path
						set input_format [ string map {.odb .inp} "$solver_inp_form" ]
						#puts " abaqus input file $input_format"
					}

					if { $::GA_Report::c3var == "PamCrash" } {
						set solver_inp_form $op_file_path
						set input_format [ string map {.erfh5 .pc} "$solver_inp_form" ]
					}

					if { $::GA_Report::c3var == "LsDyna" } {
					
						set solver_inp_form {.dyn}
						set dyna_key_name $dyna_just_name$solver_inp_form
						
						
						set path_cut [ string trim $op_file_path "$cut_string" ]
						
						
						# additional slash is removed here for dyn file 
						set input_format $path_cut$dyna_just_name$solver_inp_form
						#puts " DYNA input file $input_format"
						
						
						#set input_format [ string map {"d3plot" $dyna_key_name} $op_file_path ]
						
						
						
					}


					set files_list_name_only [list]
					set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
					set part_files_count [llength $files_list_name_only]
					#puts "parts count is $part_files_count"

					for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

						set file1 [ lindex $files_list_name_only $part_counter]
						#puts "part name is $file1"
						set file [open $file1]
						set filevalues [read $file]
						close $file

						#puts $op_file_cur
						master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
						page_handle$op_file_cur$page_num_current  SetLayout 0
						master_project SetActivePage $page_num_current

						page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
						win_of$page_num_current$win_counter SetClientType animation
						win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
						page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
						#puts $op_file_path

						anim_handle_$page_num_current$win_counter Draw
						set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $input_format]
						anim_handle_$page_num_current$win_counter Draw
						anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
						model_handle_$page_num_current$win_counter SetResult $op_file_path
						
						#----------------------HIDE NOTE START---------------------------#
						anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
						Note_hide_$page_num_current$win_counter SetVisibility False
						#----------------------HIDE NOTE END-----------------------------#
						

						model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
						result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
						contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
						contour_handle_$page_num_current$win_counter SetEnableState true



						legend_handle$page_num_current$win_counter SetType user
						legend_handle$page_num_current$win_counter SetPosition upperleft
						legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
						legend_handle$page_num_current$win_counter SetNumericPrecision 3
						legend_handle$page_num_current$win_counter SetReverseEnable false
						legend_handle$page_num_current$win_counter SetNumberOfColors 9
						legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
						legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
						legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
						legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
						legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
						legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
						legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
						legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
						legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
						legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
						legend_handle$page_num_current$win_counter OverrideValue 0 0.000

						hwc result scalar legend values entitylabel=false

						hwc result scalar legend title font="{Noto Sans} 12 bold roman"
						hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
						hwc result scalar legend values minimum=false
						#hwc annotation note "Model Info" display text= "{for (i = 0; i != numpts(window.modeltitlelist); ++i) }\n{window.loadcaselist[i]} : {window.simulationsteplist[i]} : {window.framelist[i]}\n{endloop}"

						contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::strain_datatype"
						
						contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::strain_datacomp
					    contour_handle_$page_num_current$win_counter SetLayer Max
						contour_handle_$page_num_current$win_counter SetAverageMode none
						contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
						
						
						
												
						if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" )} {
						
						} else {
						contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
						}
						
						anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
						anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
						anim_handle_$page_num_current$win_counter Draw
						
						
						set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
						set last_step [ expr { $numsim_id_val - 1} ]
						result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

						# ######################one time 
						set intersect_a_surface [list]

						if { $part_counter < 1 } {

							set selection_set_ids [model_handle_$page_num_current$win_counter GetSelectionSetList]
							
							set selection_set_ids [ lsort -unique $selection_set_ids ]
							
							#set a_surface_selection_set_id ""
							#puts "selection set id $selection_set_ids"
							foreach sel_id $selection_set_ids {

								model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_check_$page_num_current$win_counter$sel_id $sel_id
								set label_of_selhandle [ selection_handle_check_$page_num_current$win_counter$sel_id GetLabel ]
								
								#puts "label of $sel_id is  $label_of_selhandle"
								if { $label_of_selhandle == "A_SURFACE_SET" } { 
									set a_surface_selection_set_id $sel_id 
									#puts " a surface set id is $sel_id "

								} 


							}

							#if { $a_surface_selection_set_id == "" } { set $a_surface_selection_set_id $::GA_Report::user_rbe_string }

							

							model_handle_$page_num_current$win_counter AddSelectionSet element
							model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_a_surf_$page_num_current$win_counter $a_surface_selection_set_id
							set elements_of_a_surface [selection_handle_a_surf_$page_num_current$win_counter GetList]






							model_handle_$page_num_current$win_counter UnMaskAll
							anim_handle_$page_num_current$win_counter Draw

						}

						# ######################one time




						foreach elem $elements_of_a_surface {
							
							set exist_elem [lsearch -all -inline $filevalues *$elem*]
					
						    if { $exist_elem > 0 } {
							
							

								lappend intersect_a_surface $elem

							}
						}




						# ############################################################################################################################	
						# ######################################### MAYBE KEEP THE COMPONENT - AND PLOT ON A SURFACE ONLY ############################	
						# ############################################################################################################################	




						set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

						model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

						selection_handle_$page_num_current$win_counter SetVisibility true
						selection_handle_$page_num_current$win_counter SetSelectMode displayed


						foreach element_part $intersect_a_surface {



							selection_handle_$page_num_current$win_counter Add "id $element_part"


						}


						model_handle_$page_num_current$win_counter SetMeshMode features
						model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
						model_handle_$page_num_current$win_counter ReverseMask
						selection_handle_$page_num_current$win_counter Clear



						anim_handle_$page_num_current$win_counter Draw



						set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
						model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp


						selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
						selection_handle_comp_$page_num_current$win_counter Add all


						
								legend_handle$page_num_current$win_counter SetType dynamic
								contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]
						
						model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

						
						



                        master_project SetActivePage $page_num_current
						hwc hide system all

						win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
						fit_control_$page_num_current$win_counter Fit
						fit_control_$page_num_current$win_counter SetOrientation right
                        if { $::GA_Report::c3var == "LsDyna" } {
						hwc result scalar load type="Effective plastic strain" component="Scalar value" cornerdata=false layer=Max displayed=true system=global
						}
						anim_handle_$page_num_current$win_counter Draw

						master_project AddPage
						incr page_num_current

						unset intersect_a_surface 

					}	





					#master_project AddPage

					return $page_num_current



				}


proc ::GA_Report::partwise_stress { op_file_name op_file_path page_num_current  } {
		
	#puts $op_file_name
	set op_file $op_file_name
	set material_name "Please_Update"
	
	if { $::GA_Report::c3var == "Abaqus_S"  } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}
	
	if { $::GA_Report::c3var == "LsDyna" } {

		
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]

	}
	
	
	set output_split [split $op_file_cur _]
	set side_code [ lindex $output_split 5]

	if { $side_code == "LH" } {  set side_val "right" }
	if { $side_code == "RH" } {  set side_val "left" }
	if { $side_code == "FT" } {  set side_val "back" }
	if { $side_code == "BK" } {  set side_val "front" }
	
	if { $side_code == "TP" } {  set side_val "bottom" }
	if { $side_code == "BT" } {  set side_val "top" }
	if { $side_code == "CT" } {  set side_val "back" }
	
	
	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	
	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"



	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

		set file1 [ lindex $files_list_name_only $part_counter]
		
		set stress_plot_values [ ::GA_Report::stress_name_process $read_parts_path $file1 ]
		
		set material_name [ lindex $stress_plot_values 0 ]
		set yield_stress [ lindex $stress_plot_values 1 ]
		set ultimate_stress [ lindex $stress_plot_values 2 ]
		set strain_limit [ lindex $stress_plot_values 3 ]
		
		#puts " mat and stress are $material_name $yield_stress $ultimate_stress $strain_limit"
		
		set material_name [ string map {"_" ""} $material_name ]
		
		
		# HERE NEED TO PROCESS YEILD AND ULTIMATE IF AVAILABLE AND MAT NAME.
		
		set file [open $file1]
		set filevalues [read $file]
		close $file
		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 1
		master_project SetActivePage $page_num_current
		
	  for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
		#puts $op_file_path

		anim_handle_$page_num_current$win_counter Draw
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		anim_handle_$page_num_current$win_counter Draw
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		model_handle_$page_num_current$win_counter SetResult $op_file_path

		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true

		hwc result scalar legend values entitylabel=false

		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#

		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 2
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		
		#hwc result scalar legend layout type=fixed
		hwc result scalar legend title font="{Noto Sans} 12 bold roman"
		hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
		hwc result scalar legend values minimum=false
		#hwc annotation note "Model Info" display text= "{for (i = 0; i != numpts(window.modeltitlelist); ++i) }\n{window.loadcaselist[i]} : {window.simulationsteplist[i]} : {window.framelist[i]}\n{endloop}"
		

		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"
		
		contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::stress_datacomp
		contour_handle_$page_num_current$win_counter SetLayer Max
		contour_handle_$page_num_current$win_counter SetAverageMode advanced
		
		if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" )} {
		
		} else {
			contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
		}
		
		if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
			hwc result scalar multiplier 1000
		}

		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed

		set dimension_counter 1
		foreach element_part $filevalues {

			selection_handle_$page_num_current$win_counter Add "id $element_part"
			# ADD HERE ELEMENT DIMENSION ONCE AND DECIDE THE CONTOUR TYPE
			
				if { $::GA_Report::c3var == "PamCrash" } { 
			
					if { $dimension_counter == 1} { 
					
						model_handle_$page_num_current$win_counter GetQueryCtrlHandle dimesion_query_$page_num_current$win_counter$dimension_counter
						dimesion_query_$page_num_current$win_counter$dimension_counter SetSelectionSet $selection_set_id
						
						dimesion_query_$page_num_current$win_counter$dimension_counter SetQuery "element.config";
						dimesion_query_$page_num_current$win_counter$dimension_counter GetIteratorHandle dimesion_iterator_$page_num_current$win_counter$dimension_counter
						set config_data [dimesion_iterator_$page_num_current$win_counter$dimension_counter GetDataList]
						#puts " element config is $config_data"
						
							if { $config_data == 210 } {
							
								contour_handle_$page_num_current$win_counter SetDataComponent "vonMises"
								contour_handle_$page_num_current$win_counter SetDataType "SXYZ/3D/Stress"
																	
							} else {
							
							}
						}	
			}
			
			incr dimension_counter
		}
		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
		model_handle_$page_num_current$win_counter ReverseMask
		selection_handle_$page_num_current$win_counter Clear

		set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

		selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
		selection_handle_comp_$page_num_current$win_counter Add all

		
		#legend_handle$page_num_current$win_counter SetType dynamic
		#anim_handle_$page_num_current$win_counter Draw
		#legend_handle$page_num_current$win_counter SetType fixed
		
		contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]
		
		model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		
		anim_handle_$page_num_current$win_counter AddNote
		anim_handle_$page_num_current$win_counter GetNoteHandle mat_note_$page_num_current$win_counter 2
		mat_note_$page_num_current$win_counter SetLabel $page_num_current$win_counter
		mat_note_$page_num_current$win_counter SetText $material_name
		mat_note_$page_num_current$win_counter SetVisibility False
		
		fit_control_$page_num_current$win_counter SetOrientation $side_val


		if { $yield_stress != 9999 } {
	
			if { $win_counter == 1 } {			
				page_handle$op_file_cur$page_num_current SetActiveWindow 1
				hwc result scalar legend values levelvalue="9 $yield_stress"
				anim_handle_$page_num_current$win_counter Draw
				#puts " applied value on legend $yield_stress"
		
			}
	
		}
	
	
		if { $ultimate_stress != 9999 } {
	
			if { $win_counter == 2 } {
					
				page_handle$op_file_cur$page_num_current SetActiveWindow 2
				hwc result scalar legend values levelvalue="9 $ultimate_stress"
				anim_handle_$page_num_current$win_counter Draw
				
				#hwc result scalar load type=$::GA_Report::stress_datatype component=$::GA_Report::stress_datacomp avgmode=advanced layer=Max displayed=true system=global
			
				#puts " applied value on legend $ultimate_stress"
			}					

		}

		hwc result scalar load type=$::GA_Report::stress_datatype component=$::GA_Report::stress_datacomp avgmode=advanced layer=Max displayed=true system=global

		anim_handle_$page_num_current$win_counter Draw
		hwc result scalar legend layout type=fixed
		anim_handle_$page_num_current$win_counter Draw

	  }

	master_project AddPage
	incr page_num_current

	}	

	#master_project AddPage

	return $page_num_current

}

proc ::GA_Report::partwise_stress_vonmises { op_file_name op_file_path page_num_current  } {

	if { $::GA_Report::cbState(empty24) == 1} {

		set ::GA_Report::stress_datacomp "SignedVonMises"

	}
	#puts $op_file_name
	set op_file $op_file_name
	set material_name "Please_Update"

	if { $::GA_Report::c3var == "Abaqus_S" } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}
		
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]

	}
		
	if { $::GA_Report::c3var == "LsDyna" } {

		
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
		
		#puts $op_file_curve_x
		#puts $op_file_curve_y
	}

	set output_split [split $op_file_cur _]
	set side_code [ lindex $output_split 5]

	if { $side_code == "LH" } {  set side_val "right" }
	if { $side_code == "RH" } {  set side_val "left" }
	if { $side_code == "FT" } {  set side_val "back" }
	if { $side_code == "BK" } {  set side_val "front" }
	
	if { $side_code == "TP" } {  set side_val "bottom" }
	if { $side_code == "BT" } {  set side_val "top" }
	if { $side_code == "CT" } {  set side_val "back" }
			
	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	

	
	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"



	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

		set file1 [ lindex $files_list_name_only $part_counter]

		set stress_plot_values [ ::GA_Report::stress_name_process $read_parts_path $file1 ]

		set material_name [ lindex $stress_plot_values 0 ]
		set yield_stress [ lindex $stress_plot_values 1 ]
		set ultimate_stress [ lindex $stress_plot_values 2 ]
		set strain_limit [ lindex $stress_plot_values 3 ]

		#puts " mat and stress are $material_name $yield_stress $ultimate_stress $strain_limit"

		set material_name [ string map {"_" ""} $material_name ]
		
		set file [open $file1]
		set filevalues [read $file]
		close $file
		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 1
		master_project SetActivePage $page_num_current
		
		for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {

			page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
			win_of$page_num_current$win_counter SetClientType animation
			win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
			#puts $op_file_path

			anim_handle_$page_num_current$win_counter Draw
			set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
			anim_handle_$page_num_current$win_counter Draw
			anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
			model_handle_$page_num_current$win_counter SetResult $op_file_path

			model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
			result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
			contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
			contour_handle_$page_num_current$win_counter SetEnableState true


			#----------------------HIDE NOTE START---------------------------#
			anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
			Note_hide_$page_num_current$win_counter SetVisibility False
			#----------------------HIDE NOTE END-----------------------------#

			legend_handle$page_num_current$win_counter SetType user
			legend_handle$page_num_current$win_counter SetPosition upperleft
			legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
			legend_handle$page_num_current$win_counter SetNumericPrecision 2
			legend_handle$page_num_current$win_counter SetReverseEnable false
			legend_handle$page_num_current$win_counter SetNumberOfColors 9
			legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
			legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
			legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
			legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
			legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
			legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
			legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
			legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
			legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
			legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
			legend_handle$page_num_current$win_counter OverrideValue 0 0.000

			hwc result scalar legend values entitylabel=false
			hwc result scalar legend title font="{Noto Sans} 12 bold roman"
			hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"

			contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"

			contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::stress_datacomp
			contour_handle_$page_num_current$win_counter SetLayer Max
			contour_handle_$page_num_current$win_counter SetAverageMode advanced

			if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" )} {
			} else {
				contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
			}

			set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
			set last_step [ expr { $numsim_id_val - 1} ]
			result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


			set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

			selection_handle_$page_num_current$win_counter SetVisibility true
			selection_handle_$page_num_current$win_counter SetSelectMode displayed

			set dimension_counter 1
			foreach element_part $filevalues {

				selection_handle_$page_num_current$win_counter Add "id $element_part"
				# ADD HERE ELEMENT DIMENSION ONCE AND DECIDE THE CONTOUR TYPE

				if { $::GA_Report::c3var == "PamCrash" } { 
					if { $dimension_counter == 1} { 
						model_handle_$page_num_current$win_counter GetQueryCtrlHandle dimesion_query_$page_num_current$win_counter$dimension_counter
						dimesion_query_$page_num_current$win_counter$dimension_counter SetSelectionSet $selection_set_id
						
						dimesion_query_$page_num_current$win_counter$dimension_counter SetQuery "element.config";
						dimesion_query_$page_num_current$win_counter$dimension_counter GetIteratorHandle dimesion_iterator_$page_num_current$win_counter$dimension_counter
						set config_data [dimesion_iterator_$page_num_current$win_counter$dimension_counter GetDataList]
						#puts " element config is $config_data"
						
						if { $config_data == 210 } {
							contour_handle_$page_num_current$win_counter SetDataComponent "vonMises"
							contour_handle_$page_num_current$win_counter SetDataType "SXYZ/3D/Stress"								
						} else {

						}
						
					}		
				}

				incr dimension_counter
			}
			
			model_handle_$page_num_current$win_counter SetMeshMode features
			model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
			model_handle_$page_num_current$win_counter ReverseMask
			selection_handle_$page_num_current$win_counter Clear

			set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

			selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
			selection_handle_comp_$page_num_current$win_counter Add all


			legend_handle$page_num_current$win_counter SetType dynamic
			contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

			model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

			anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
			anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

			win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
			fit_control_$page_num_current$win_counter Fit

			anim_handle_$page_num_current$win_counter AddNote
			anim_handle_$page_num_current$win_counter GetNoteHandle mat_note_$page_num_current$win_counter 2
			mat_note_$page_num_current$win_counter SetLabel $page_num_current$win_counter
			mat_note_$page_num_current$win_counter SetText $material_name
			mat_note_$page_num_current$win_counter SetVisibility False

			fit_control_$page_num_current$win_counter SetOrientation $side_val

			#fit_control_$page_num_current$win_counter SetOrientation right

			anim_handle_$page_num_current$win_counter Draw

			if { $win_counter == 2  } {
				# puts "iso starts"

				hwc hwd page makecurrent $page_num_current
				hwc hwd page current activewindow=2
				hwc attribute global features true
				hwc attribute global transparency true

				if { $::GA_Report::c3var == "Abaqus_S" } {
					#hwc result iso load type="$::GA_Report::stress_datatype" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max system=global displayed=true
					hwc result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max displayed=true system=global
				}
				if { $::GA_Report::c3var == "LsDyna" } {
					hwc result iso load type="$::GA_Report::stress_datatype" component="Scalar value" layer=Max displayed=true
				}
				#result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max displayed=true system=global
				#hwc result iso load type="$::GA_Report::stress_datatype" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max system=global displayed=true
				#hwc result iso load type="$::GA_Report::stress_datatype" component=vonMises avgmode=advanced  layer=Max system=global displayed=true
				hwc result iso display currentvalue=1
				hwc result iso display color=Red
				hwc result iso display usecolor=true
				#puts "iso end"
				#hwc result scalar legend layout type=fixed
				anim_handle_$page_num_current$win_counter Draw   
			}

		}

		master_project AddPage
		incr page_num_current
	}	

	#master_project AddPage

	return $page_num_current
}


proc ::GA_Report::partwise_strain { op_file_name op_file_path page_num_current  } {

	#puts $op_file_name
	set op_file $op_file_name
	set material_name "Please_Update"
	
	if { $::GA_Report::c3var == "Abaqus_S" } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}

	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}


	if { $::GA_Report::c3var == "LsDyna" } {
		
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur $op_file
		
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]		

	}

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"

	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

		set file1 [ lindex $files_list_name_only $part_counter]
		
		
		# reading strain values start.
		
		set stress_plot_values [ ::GA_Report::stress_name_process $read_parts_path $file1 ]
		
		set material_name [ lindex $stress_plot_values 0 ]
		set yield_stress [ lindex $stress_plot_values 1 ]
		set ultimate_stress [ lindex $stress_plot_values 2 ]
		set strain_limit [ lindex $stress_plot_values 3 ]
		
		#puts " mat and stress are $material_name $yield_stress $ultimate_stress $strain_limit"
		
		set material_name [ string map {"_" ""} $material_name ]
		
		# reading strain values end.
		
		
		
		set file [open $file1]
		set filevalues [read $file]
		close $file

		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 0
		master_project SetActivePage $page_num_current

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
		#puts $op_file_path

		anim_handle_$page_num_current$win_counter Draw
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		anim_handle_$page_num_current$win_counter Draw
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		model_handle_$page_num_current$win_counter SetResult $op_file_path

		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true

		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#


		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 4
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		hwc result scalar legend values entitylabel=false


		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::strain_datatype"
		
		contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::strain_datacomp
		contour_handle_$page_num_current$win_counter SetLayer Max
		contour_handle_$page_num_current$win_counter SetAverageMode none
		
		
		
		if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" ) } {
		
		} else {
			contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
		}
		
		
		
		
		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
		
		
		hwc result scalar legend values entitylabel=false
		hwc result scalar legend title font="{Noto Sans} 12 bold roman"
		hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
		hwc result scalar legend values minimum=false
		#hwc annotation note "Model Info" display text= "{for (i = 0; i != numpts(window.modeltitlelist); ++i) }\n{window.loadcaselist[i]} : {window.simulationsteplist[i]} : {window.framelist[i]}\n{endloop}"

		







		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed

		set dimension_counter 1

		foreach element_part $filevalues {

			selection_handle_$page_num_current$win_counter Add "id $element_part"

			if { $::GA_Report::c3var == "PamCrash" } { 
			
				if { $dimension_counter == 1} { 

					model_handle_$page_num_current$win_counter GetQueryCtrlHandle dimesion_query_$page_num_current$win_counter$dimension_counter
					dimesion_query_$page_num_current$win_counter$dimension_counter SetSelectionSet $selection_set_id

					dimesion_query_$page_num_current$win_counter$dimension_counter SetQuery "element.config";
					dimesion_query_$page_num_current$win_counter$dimension_counter GetIteratorHandle dimesion_iterator_$page_num_current$win_counter$dimension_counter
					set config_data [dimesion_iterator_$page_num_current$win_counter$dimension_counter GetDataList]
					#puts " element config is $config_data"

					if { $config_data == 210 } {
						contour_handle_$page_num_current$win_counter SetDataType "EPLE/3D/Equivalent Plastic Strain"
						contour_handle_$page_num_current$win_counter SetDataComponent "Scalar value"

					} else {
						contour_handle_$page_num_current$win_counter SetDataComponent "Scalar value"
						contour_handle_$page_num_current$win_counter SetDataType "Plastic_Strain"
					
					}
				}		
			}
			incr dimension_counter
		}
		
		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
		model_handle_$page_num_current$win_counter ReverseMask
		selection_handle_$page_num_current$win_counter Clear

		set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

		selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
		selection_handle_comp_$page_num_current$win_counter Add all

		
		legend_handle$page_num_current$win_counter SetType dynamic
		contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]
		
		model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

		anim_handle_$page_num_current$win_counter Draw

		hwc result scalar legend layout type=fixed

		anim_handle_$page_num_current$win_counter Draw


		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		anim_handle_$page_num_current$win_counter AddNote
		anim_handle_$page_num_current$win_counter GetNoteHandle mat_note_$page_num_current$win_counter 2
		mat_note_$page_num_current$win_counter SetLabel $page_num_current$win_counter
		mat_note_$page_num_current$win_counter SetText $material_name
		mat_note_$page_num_current$win_counter SetVisibility False

		if { $strain_limit != 9999 } {
			if { $win_counter == 1 } {
				set strain_limit [ expr { $strain_limit * 0.01 } ]
				page_handle$op_file_cur$page_num_current SetActiveWindow 1
				hwc result scalar legend values levelvalue="9 $strain_limit"
				anim_handle_$page_num_current$win_counter Draw
				#puts " applied value on legend $strain_limit"
		
			}
		}
	
		if { $strain_limit != 9999 } {
			hwc result scalar load type=$::GA_Report::strain_datatype component=$::GA_Report::strain_datacomp avgmode=none layer=Max displayed=true system=global
		}

		anim_handle_$page_num_current$win_counter Draw

		master_project AddPage
		incr page_num_current
	}	

	#master_project AddPage
	return $page_num_current
}

proc ::GA_Report::partwise_strain_vonmises { op_file_name op_file_path page_num_current  } {

	if { $::GA_Report::cbState(empty24) == 1} {
		set ::GA_Report::strain_datacomp "SignedVonMises"
	}

	#puts $op_file_name
	set op_file $op_file_name
	set material_name "Please_Update"
	
	if { $::GA_Report::c3var == "Abaqus_S"  } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}
	
	if { $::GA_Report::c3var == "PamCrash" } {
		et op_file_cur [ string map {".erfh5" ""} $op_file ]

	}

	if { $::GA_Report::c3var == "LsDyna" } {
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur $op_file
		
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
	}

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"

	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

		set file1 [ lindex $files_list_name_only $part_counter]

		set stress_plot_values [ ::GA_Report::stress_name_process $read_parts_path $file1 ]

		set material_name [ lindex $stress_plot_values 0 ]
		set yield_stress [ lindex $stress_plot_values 1 ]
		set ultimate_stress [ lindex $stress_plot_values 2 ]
		set strain_limit [ lindex $stress_plot_values 3 ]

		#puts " mat and stress are $material_name $yield_stress $ultimate_stress $strain_limit"

		set material_name [ string map {"_" ""} $material_name ]
		set file [open $file1]
			set filevalues [read $file]
		close $file

		#puts $op_file_cur
		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 1
		master_project SetActivePage $page_num_current


		for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {

			page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
			win_of$page_num_current$win_counter SetClientType animation
			win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
			page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
			#puts $op_file_path

			anim_handle_$page_num_current$win_counter Draw
			set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
			anim_handle_$page_num_current$win_counter Draw
			anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
			model_handle_$page_num_current$win_counter SetResult $op_file_path

			model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
			result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
			contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
			contour_handle_$page_num_current$win_counter SetEnableState true


			#----------------------HIDE NOTE START---------------------------#
			anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
			Note_hide_$page_num_current$win_counter SetVisibility False
			#----------------------HIDE NOTE END-----------------------------#

			legend_handle$page_num_current$win_counter SetType user
			legend_handle$page_num_current$win_counter SetPosition upperleft
			legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
			legend_handle$page_num_current$win_counter SetNumericPrecision 4
			legend_handle$page_num_current$win_counter SetReverseEnable false
			legend_handle$page_num_current$win_counter SetNumberOfColors 9
			legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
			legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
			legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
			legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
			legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
			legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
			legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
			legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
			legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
			legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
			legend_handle$page_num_current$win_counter OverrideValue 0 0.000

			hwc result scalar legend values entitylabel=false
			hwc result scalar legend title font="{Noto Sans} 12 bold roman"
			hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"

			contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::strain_datatype"

			contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::strain_datacomp
			contour_handle_$page_num_current$win_counter SetLayer Max
			contour_handle_$page_num_current$win_counter SetAverageMode advanced
			
			hwc result scalar legend title font="{Noto Sans} 12 bold roman"
			hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
			hwc result scalar legend values minimum=false

			if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" )} {

			} else {
				contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
			}

			set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
			set last_step [ expr { $numsim_id_val - 1} ]
			result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


			set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

			selection_handle_$page_num_current$win_counter SetVisibility true
			selection_handle_$page_num_current$win_counter SetSelectMode displayed

			set dimension_counter 1
			foreach element_part $filevalues {

				selection_handle_$page_num_current$win_counter Add "id $element_part"
				# ADD HERE ELEMENT DIMENSION ONCE AND DECIDE THE CONTOUR TYPE

				if { $::GA_Report::c3var == "PamCrash" } { 

					if { $dimension_counter == 1} { 
					
						model_handle_$page_num_current$win_counter GetQueryCtrlHandle dimesion_query_$page_num_current$win_counter$dimension_counter
						dimesion_query_$page_num_current$win_counter$dimension_counter SetSelectionSet $selection_set_id
						
						dimesion_query_$page_num_current$win_counter$dimension_counter SetQuery "element.config";
						dimesion_query_$page_num_current$win_counter$dimension_counter GetIteratorHandle dimesion_iterator_$page_num_current$win_counter$dimension_counter
						set config_data [dimesion_iterator_$page_num_current$win_counter$dimension_counter GetDataList]
						#puts " element config is $config_data"
						
						if { $config_data == 210 } {
							contour_handle_$page_num_current$win_counter SetDataComponent "EPLE/3D/Equivalent Plastic Strain"
							contour_handle_$page_num_current$win_counter SetDataType "Scalar value"									
						} else {
						
							contour_handle_$page_num_current$win_counter SetDataComponent "Scalar value"
							contour_handle_$page_num_current$win_counter SetDataType "Plastic_Strain"
						}
					}		
				}
				incr dimension_counter
			}
			
			model_handle_$page_num_current$win_counter SetMeshMode features
			model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
			model_handle_$page_num_current$win_counter ReverseMask
			selection_handle_$page_num_current$win_counter Clear

			set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

			selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
			selection_handle_comp_$page_num_current$win_counter Add all


			legend_handle$page_num_current$win_counter SetType dynamic
			contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

			model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

			anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
			anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

			win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
			fit_control_$page_num_current$win_counter Fit

			anim_handle_$page_num_current$win_counter AddNote
			anim_handle_$page_num_current$win_counter GetNoteHandle mat_note_$page_num_current$win_counter 2
			mat_note_$page_num_current$win_counter SetLabel $page_num_current$win_counter
			mat_note_$page_num_current$win_counter SetText $material_name
			mat_note_$page_num_current$win_counter SetVisibility False

			fit_control_$page_num_current$win_counter SetOrientation right
			anim_handle_$page_num_current$win_counter Draw

			if { $win_counter == 2  } {
				#puts "iso starts"

				hwc hwd page makecurrent $page_num_current
				hwc hwd page current activewindow=2
				hwc attribute global features true
				hwc attribute global transparency true

				if { $::GA_Report::c3var == "Abaqus_S" } {
					#hwc result iso load type="$::GA_Report::stress_datatype" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max system=global displayed=true
					#hwc result iso load type="$::GA_Report::strain_datatype" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max displayed=true system=global
					hwc result iso load type="PE-Global-Plastic strain components IP" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max displayed=true system=global
				}
				if { $::GA_Report::c3var == "LsDyna" } {
					hwc result iso load type="$::GA_Report::strain_datatype" component="Scalar value" layer=Max displayed=true
				}
				#result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max displayed=true system=global
				#hwc result iso load type="$::GA_Report::stress_datatype" component=SignedVonMises avgmode=advanced cornerdata=true layer=Max system=global displayed=true
				#hwc result iso load type="$::GA_Report::stress_datatype" component=vonMises avgmode=advanced  layer=Max system=global displayed=true
				hwc result iso display currentvalue=0.01
				hwc result iso display color=Red
				hwc result iso display usecolor=true
				#puts "iso end"
				anim_handle_$page_num_current$win_counter Draw   

			} 
		}
		master_project AddPage
		incr page_num_current
	}
	return $page_num_current
}
				
				
proc ::GA_Report::registerPreferences {menuName  preferenceFile {debug 0} } {
	set preferenceFile [file normalize $preferenceFile]
	set t [expr rand()][clock seconds]
	master_session GetPreferenceManagerHandle pref$t
	pref$t RegisterPreferenceFile $menuName $preferenceFile false
	set default_pref_file [lindex [pref$t GetDefaultPreferenceFileComponentList] 0]
	if {$debug} {puts "Default File = \"$default_pref_file\""}

	if {![string match $menuName $default_pref_file]} {
		set newPrefFileIndex 0
		set n_pref_files [pref$t GetNumberofPreferenceFiles]
		if {$debug} {puts "Number of Preference Files = $n_pref_files"}
		while {$newPrefFileIndex < $n_pref_files} {
			set pref_file_menu [lindex [pref$t GetPreferenceFileComponentList $newPrefFileIndex "" ""] 0]
			set pref_file_path [lindex [pref$t GetPreferenceFileComponentList $newPrefFileIndex "" ""] 1]
			if {$debug} {puts "Preference File Menu = $pref_file_menu"}
			if {[string match $menuName $pref_file_menu]} {

				set currentPrefFileName [lindex [::hw::registerpreference::GetDefaultPreferenceFileInfo] 0];
				if {$currentPrefFileName != ""} {
					set currentPrefFileIndex [lindex [::hw::registerpreference::GetPreferenceFileDetails $currentPrefFileName] end];
				} else {
					set currentPrefFileIndex -1
				}
				#Loading the preference file and updating the menu items.
				::hw::registerpreference::h_SelectPreferenceFile $newPrefFileIndex $currentPrefFileIndex;

				if {$debug} {
					puts "Loaded \"$newPrefFileIndex\" \"$pref_file_menu\" \"$pref_file_path\""
				}
				break;
			}

			incr newPrefFileIndex
		}
	}

	if {$debug} {puts "Loading ${menuName} finished"}
}


proc ::GA_Report::local_impact_page_master { op_file_name op_file_path page_num_current } {

	#puts "local impact master page entry $op_file_name"
	set op_file $op_file_name

	if { $::GA_Report::c3var == "Abaqus_S"  } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}  

	set i 0
	set k 1

	if { $::GA_Report::c3var == "Abaqus_S" } {
		set solver_inp_form $op_file_path
		set input_format [ string map {.odb .inp} "$solver_inp_form" ]
	}

	if { $::GA_Report::c3var == "PamCrash" } {
		set solver_inp_form $op_file_path
		set input_format [ string map {.erfh5 .pc} "$solver_inp_form" ]
	}


	if { $::GA_Report::c3var == "LsDyna" } {
		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::x_joint_component_type	"Time"
		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
		
		#puts $op_file_curve_x
		#puts $op_file_curve_y
		

	}


	if { $::GA_Report::c3var == "LsDyna" } {

		set solver_inp_form {.dyn}
		set slash_200 {/}
		set cut_string1 {d3plot} 
		
		set dyna_just_name [ string trim $op_file_name "$cut_string1" ]
		set dyna_just_name [ string trim $dyna_just_name "$slash_200" ]
		#puts "just dyna name $dyna_just_name"
		
		set dyna_key_name $dyna_just_name$solver_inp_form
		
		set path_cut [ string trim $op_file_path "$cut_string1" ]
		set path_cut [ string trim $path_cut "$slash_200" ]
		
		
		set input_format $path_cut$slash_200$dyna_just_name$solver_inp_form
		#puts " DYNA input file $input_format"
		#set input_format [ string map {"d3plot" $dyna_key_name} $op_file_path ]	
	}

	master_project SetActivePage $page_num_current 

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	#puts $op_file_cur
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1


	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $input_format]
	#puts "one file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]


	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id
	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed



	selection_handle_$page_num_current$win_counter Add "id $::GA_Report::comp_name_local_impact"

	#puts "local impact comp is $::GA_Report::comp_name_local_impact"

	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear
	model_handle_$page_num_current$win_counter SetMeshMode features

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#
	
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::strain_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::strain_datacomp
	contour_handle_$page_num_current$win_counter SetLayer Max
	contour_handle_$page_num_current$win_counter SetAverageMode advanced

	if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" ) } {
		
	} else {
		contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
	}

	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

	#result_handle_71 GetIsoValueCtrlHandle isohandle1
	#isohandle1 SetColor Red
	#isohandle1 GetIsoValueMin
	#isohandle1 GetIsoValueMax
	#isohandle1 SetDataType "$::GA_Report::strain_datatype"
	#isohandle1 SetIsoValue 0.0001
	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right
	#puts "iso starts"

	hwc hwd page makecurrent $page_num_current
	hwc hwd page current activewindow=1
	hwc attribute global features true
	hwc attribute global transparency true

	if { $::GA_Report::c3var == "Abaqus_S" } {
		hwc result iso load type="PE-Global-Plastic strain components IP" component=vonMises avgmode=advanced cornerdata=true layer=Max system=global displayed=true
	}
	if { $::GA_Report::c3var == "LsDyna" } {
		hwc result iso load type="Effective plastic strain" component="Scalar value" layer=Max displayed=true
	}

	hwc result iso load type="Effective plastic strain" component=vonMises avgmode=advanced  layer=Max system=global displayed=true
	hwc result iso display currentvalue=0.001
	hwc result iso display color=Red
	hwc result iso display usecolor=true
	#puts "iso end"
	anim_handle_$page_num_current$win_counter Draw

	# ################################################## first eindow end ###########################################################
	incr win_counter

	# ########################################### SECOND WINDOW START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $input_format]
	#puts "one file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]


	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id
	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed



	selection_handle_$page_num_current$win_counter Add "id $::GA_Report::comp_name_local_impact"
	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear
	model_handle_$page_num_current$win_counter SetMeshMode features

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::strain_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent $::GA_Report::strain_datacomp
	contour_handle_$page_num_current$win_counter SetLayer Max
	contour_handle_$page_num_current$win_counter SetAverageMode advanced

	if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" ) } {
		
	} else {
		contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
	}
	
	contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right


	anim_handle_$page_num_current$win_counter Draw

	# ########################################### SECOND WINDOW END ######################################################	

	set win_counter 1
	incr page_num_current
	#puts "passed pagenum is $page_num_current"

	master_project AddPage
	return $page_num_current
}


proc ::GA_Report::impact_page_master { op_file_name op_file_path page_num_current } {

	#puts $op_file_name
	set op_file $op_file_name

	if { $::GA_Report::c3var == "Abaqus_S" } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}

	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}

	 if { $::GA_Report::tool_element_id == "" } {
		set ::GA_Report::tool_element_id 10001 
	 }
	 
	if { $::GA_Report::user_master_id >= 1 } { set master_node_id $::GA_Report::user_master_id
	} else {
		set master_node_id 1001
	}
	 
	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::x_joint_component_type	"Time"

		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
		
		#puts $op_file_curve_x
		#puts $op_file_curve_y
	}

	if { $::GA_Report::c3var == "PamCrash" } {

		set op_file_curve $op_file_path
		
		#puts "solver is Pamcrash -setting values"

		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "ESTRESS"
		set ::GA_Report::strain_datatype "EPLE/2D"
		
		set ::GA_Report::stress_datacomp "Maximum equivalent stress in shell element"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		
		
		set ::GA_Report::curve_disp_datatype "Node (Time History)"						
		set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::x_curve_comp "Contact_Force-Magnitude"
		set ::GA_Report::y_curve_comp "Translational_Displacement-Magnitude"
		
		set ::GA_Report::x_curve_request "IMPACTOR_TRIM_CONTACT"
		# ###############################THNODE NAME IS CONFLICTING , THIS MAY NEED TO BE STANDARDIZED OR ADDED TO GUI"
		# set ::GA_Report::y_curve_request "Verschiebung Pruefkoerper"
		
		#set ::GA_Report::y_curve_request "Impactor_Displacement"
		set ::GA_Report::y_curve_request "Verschiebung Pruefkoerper"
		
	}					
	   

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {

		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	#puts $op_file_cur
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	 if { $::GA_Report::c3var == "PamCrash" } {

		result_handle_$page_num_current$win_counter SetCurrentSubcase 1
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	}

	if { $::GA_Report::c3var == "Abaqus_S" } {
		result_handle_$page_num_current$win_counter SetCurrentSubcase 3
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	}


	if { $::GA_Report::c3var == "LsDyna" } {
		result_handle_$page_num_current$win_counter SetCurrentSubcase 1
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step
	}
	
	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false


	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple



	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	result_handle_$page_num_current$win_counter SetCurrentSimulation 1
	# ################################################## setting view start ###########################################################

	set measure_page [ expr { $page_num_current - 1 } ]

	anim_handle_$page_num_current$win_counter GetMeasureHandle measure_handle$page_num_current$win_counter 1
	measure_handle$page_num_current$win_counter SetLabel node_master_measure
	measure_handle$page_num_current$win_counter SetType Position
	measure_handle$page_num_current$win_counter CreateItem
	measure_handle$page_num_current$win_counter AddNode "1 $::GA_Report::master_node_id"

	master_project SetActivePage $measure_page
	master_project SetActivePage $page_num_current


	set master_coord_list [ measure_handle$page_num_current$win_counter GetValueList ]
	set all_val_coord [ lindex $master_coord_list 0 ]

	set x_val_coord [ lindex $all_val_coord 0 ]
	set y_val_coord [ lindex $all_val_coord 1 ]
	set z_val_coord [ lindex $all_val_coord 2 ]

	#puts "x coord $x_val_coord"
	#puts "y coord $y_val_coord"
	#puts "z coord $z_val_coord"

	set radius 5

	set selection_set_id_tool [ model_handle_$page_num_current$win_counter AddSelectionSet element]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_tool_$page_num_current$win_counter $selection_set_id_tool
	selection_handle_tool_$page_num_current$win_counter SetVisibility true
	selection_handle_tool_$page_num_current$win_counter SetSelectMode displayed
	selection_handle_tool_$page_num_current$win_counter Add "sphere $x_val_coord $y_val_coord $z_val_coord $radius"

	set elements_of_sphere [selection_handle_tool_$page_num_current$win_counter GetList]
	selection_handle_tool_$page_num_current$win_counter Clear



	set selection_set_id_impactor [ model_handle_$page_num_current$win_counter AddSelectionSet element]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_impactor_$page_num_current$win_counter $selection_set_id_impactor
	selection_handle_impactor_$page_num_current$win_counter SetVisibility true
	selection_handle_impactor_$page_num_current$win_counter SetSelectMode displayed
	selection_handle_impactor_$page_num_current$win_counter Add "id $::GA_Report::tool_element_id"
	selection_handle_impactor_$page_num_current$win_counter Add "Attached"
	selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 1"
	selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 0"
	set impactor_attached_list [ selection_handle_impactor_$page_num_current$win_counter GetList]

	set elements_of_tool [list]
	set elements_of_trim [list]

	foreach elem_tool $elements_of_sphere {
		set exist_elem [lsearch -all -inline $impactor_attached_list *$elem_tool*]
		if { $exist_elem > 0 } {
			lappend elements_of_tool $elem_tool
		} else {
			lappend elements_of_trim $elem_tool
		}
	}

	#puts $elements_of_trim   

	set pointer_element_of_trim [ lindex $elements_of_trim 0 ]
	#puts "pointer element is $pointer_element_of_trim"

	unset elements_of_tool
	unset elements_of_trim

	selection_handle_impactor_$page_num_current$win_counter Clear

	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	anim_handle_$page_num_current$win_counter GetBestViewHandle bestview_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter AddBestView]

	bestview_handle_$page_num_current$win_counter SetEntity element $pointer_element_of_trim
	bestview_handle_$page_num_current$win_counter  SetViewMode contour
	bestview_handle_$page_num_current$win_counter SetFocusRegionSize 100
	bestview_handle_$page_num_current$win_counter SetGlobalVisibility hidden
	bestview_handle_$page_num_current$win_counter SetNoteShowSpotID false
	bestview_handle_$page_num_current$win_counter ActivateView
	anim_handle_$page_num_current$win_counter Draw
	anim_handle_$page_num_current$win_counter RemoveBestView 1
	anim_handle_$page_num_current$win_counter Draw


	# mask the 0ne d elements 
	set selection_set_one_d_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_one_d_$page_num_current$win_counter $selection_set_one_d_id
	selection_handle_one_d_$page_num_current$win_counter Add "dimension 1"
	selection_handle_one_d_$page_num_current$win_counter Add "dimension 0"
	model_handle_$page_num_current$win_counter Mask [selection_handle_one_d_$page_num_current$win_counter GetID]
	selection_handle_one_d_$page_num_current$win_counter Clear

	# ################################################## setting view end ###########################################################
	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter
	# ###########################################SECTION WINDOW START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features



	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step



	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000


	hwc result scalar legend values entitylabel=false


	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple
	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed
	foreach comp_biw_part $biw_only_comps_id {

		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent
	}

	section_cur_handle_$page_num_current$win_counter SetBaseNode $::GA_Report::master_node_id
	#section_cur_handle_$page_num_current$win_counter SetOrientation  "XAxis" " 1 0 0 "
	section_cur_handle_$page_num_current$win_counter SetOrientationMethod  "XAxis"
	section_cur_handle_$page_num_current$win_counter SetVisibility "True"
	section_cur_handle_$page_num_current$win_counter SetDeformMode deformable 
	section_cur_handle_$page_num_current$win_counter SetClipElements "True"
	section_cur_handle_$page_num_current$win_counter SetDisplayOption “gridtext” false
	section_cur_handle_$page_num_current$win_counter SetDisplayOption “gridlines” false
	#section_cur_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation back

	anim_handle_$page_num_current$win_counter Draw

	#puts "one load page done - moving to biw"


	# ###########################################SECTION WINDOW END ######################################################		

	incr section_id 
	master_project AddPage
	set win_counter 1

	incr page_num_current
	# #########################################START BIW PLOTS ##############################################################

	master_project SetActivePage $page_num_current
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1



	for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {
		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
		page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
		#puts $op_file_path


		anim_handle_$page_num_current$win_counter Draw
		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		anim_handle_$page_num_current$win_counter Draw
		#puts "one file loaded"
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		model_handle_$page_num_current$win_counter SetResult $op_file_path
		#puts "result loaded"
		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter

		if { $win_counter == 2 } { result_handle_$page_num_current$win_counter SetCurrentSubcase 2 }


		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true


		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 3
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		hwc result scalar legend values entitylabel=false


		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
		contour_handle_$page_num_current$win_counter SetDataComponent Mag
		#contour_handle_$page_num_current$win_counter SetLayer Max
		#contour_handle_$page_num_current$win_counter SetAverageMode simple

		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
		anim_handle_$page_num_current$win_counter Draw



		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed


		foreach comp_biw_part $biw_only_comps_id { 	selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" }



		model_handle_$page_num_current$win_counter SetMeshMode features
		model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
		model_handle_$page_num_current$win_counter ReverseMask
		selection_handle_$page_num_current$win_counter Clear



		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

		selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
		if { $win_counter == 2 } {	
			model_handle_$page_num_current$win_counter UnMaskAll 
			anim_handle_$page_num_current$win_counter Draw
			selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
			selection_handle_comp_$page_num_current$win_counter SetSelectMode SetSelectMode all 

			set selection_set_one_d_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_one_d_$page_num_current$win_counter $selection_set_one_d_id
			selection_handle_one_d_$page_num_current$win_counter Add "dimension 1"
			selection_handle_one_d_$page_num_current$win_counter Add "dimension 0"
			model_handle_$page_num_current$win_counter Mask [selection_handle_one_d_$page_num_current$win_counter GetID]
			selection_handle_one_d_$page_num_current$win_counter Clear
		}

		selection_handle_comp_$page_num_current$win_counter Add all
		if { $win_counter == 2 } { 
		
				#model_handle_$page_num_current$win_counter UnMaskAll 
				set selection_set_id_comp_extra [ model_handle_$page_num_current$win_counter AddSelectionSet element]
				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_extra_$page_num_current$win_counter $selection_set_id_comp_extra
				selection_handle_extra_$page_num_current$win_counter Add "id $::GA_Report::tool_element_id"
				selection_handle_extra_$page_num_current$win_counter Add "Attached"
				model_handle_$page_num_current$win_counter Mask [selection_handle_extra_$page_num_current$win_counter GetID]
				selection_handle_extra_$page_num_current$win_counter Clear
				anim_handle_$page_num_current$win_counter Draw
		}

		legend_handle$page_num_current$win_counter SetType dynamic
		contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

		model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

		anim_handle_$page_num_current$win_counter Draw
	}

	# ######################################### END BIW PLOTS ##############################################################	
	master_project AddPage
}

proc ::GA_Report::sunexposure_master { op_file_name op_file_path page_num_current } {

	 if { $::GA_Report::tool_element_id == "" } { 
		set ::GA_Report::tool_element_id 10001 
	 }
	 
	 if { $::GA_Report::user_master_id >= 1 } { set master_node_id $::GA_Report::user_master_id
	} else {
		set master_node_id 1001
	}
	 
	#puts $op_file_name
	set op_file $op_file_name
	#set master_node_id 1000
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]   

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {

		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps

	#puts " Biw comp names"
	#puts $biw_only_comps_name

	#puts "Biw comp ids"
	#puts  $biw_only_comps_id

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 2
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000



	hwc result scalar legend title font="{Noto Sans} 12 bold roman"
	hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
	#hwc result scalar legend values minimum=false
	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple



	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right


	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### PAGE 2 START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features



	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { result_handle_$page_num_current$win_counter SetCurrentSubcase 2 }

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 2
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend title font="{Noto Sans} 12 bold roman"
	hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
	#hwc result scalar legend values minimum=false


	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag

	hwc result scalar legend values entitylabel=false


	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}
	
	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	hwc result scalar legend layout type=fixed
	anim_handle_$page_num_current$win_counter Draw

	#puts "one load page done - moving to biw"


	# ########################################### PAGE 2  END ######################################################		

	master_project AddPage
	set win_counter 1

	incr page_num_current
	return $page_num_current
}


proc ::GA_Report::sunexposure_assembly { op_file_name op_file_path page_num_current } {

	 if { $::GA_Report::tool_element_id == "" } { 
		set ::GA_Report::tool_element_id 10001 
	}
	 
	if { $::GA_Report::user_master_id >= 1 } { set master_node_id $::GA_Report::user_master_id

	} else {
		set master_node_id 1001
	}
	 
	#puts $op_file_name
	set op_file $op_file_name
	#set master_node_id 1000
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]   

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {

		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	set axis_counter 1
		
	for {set axis_counter 1 } {$axis_counter <= 4} {incr axis_counter} {	
	
		
		if { $axis_counter == 1 } { set data_comp_sunexp "Mag"   }
		if { $axis_counter == 2 } { set data_comp_sunexp "X"   }
		if { $axis_counter == 3 } { set data_comp_sunexp "Y"   }
		if { $axis_counter == 4 } { set data_comp_sunexp "Z"   }

		master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
		page_handle$op_file_cur$page_num_current  SetLayout 1
		master_project SetActivePage $page_num_current

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		#anim_handle_$page_num_current$win_counter AddModel $op_file_path
		#puts "one file loaded"
		#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		#there is no active model- so revert
		model_handle_$page_num_current$win_counter SetResult $op_file_path
		#puts "result loaded"
		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true
		result_handle_$page_num_current$win_counter GetSubcaseList
		set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#

		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 2
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		
		if { $axis_counter == 1 } { legend_handle$page_num_current$win_counter SetColor 0 "192 192 192" }
		if { $axis_counter == 2 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }
		if { $axis_counter == 3 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }
		if { $axis_counter == 4 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }
		
		
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		hwc result scalar legend title font="{Noto Sans} 12 bold roman"
		hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
		#hwc result scalar legend values minimum=false

		legend_handle$page_num_current$win_counter SetType dynamic
		

		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
		contour_handle_$page_num_current$win_counter SetDataComponent $data_comp_sunexp
		#contour_handle_$page_num_current$win_counter SetLayer Max
		#contour_handle_$page_num_current$win_counter SetAverageMode simple

		hwc result scalar legend values entitylabel=false


		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		#legend_handle$page_num_current$win_counter SetType dynamic
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed


		foreach comp_biw_part $biw_only_comps_id {
			model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
			part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent
			part_handle_$page_num_current$win_counter$comp_biw_part SetVisibility false

		}

		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right


		model_handle_$page_num_current$win_counter SetMeshMode features
		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
		anim_handle_$page_num_current$win_counter Draw

		incr win_counter

		# ########################################### PAGE 2 START ######################################################	

		page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
		
		page_handle$op_file_cur$page_num_current SetActiveWindow 2
		
		win_of$page_num_current$win_counter SetClientType animation
		win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

		set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
		#puts "section file loaded"
		anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
		model_handle_$page_num_current$win_counter SetResult $op_file_path


		#puts "anim handle done"
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
		selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
		model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

		#puts "master node loaded"

		win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
		anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

		query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
		query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
		query_handle_$page_num_current$win_counter SetQuery "node.coords"

		query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
		set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
		#puts $node_coord_section
		set x_of_base [ lindex $node_coord_section 0 ]
		set y_of_base [ lindex $node_coord_section 1 ]
		set z_of_base [ lindex $node_coord_section 2 ]

		#puts $x_of_base

		#my_client GetSectionHandle my_section $SectionID

		#puts "my_section_$page_num_current$win_counter"


		model_handle_$page_num_current$win_counter SetMeshMode features

		model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
		result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
		contour_handle_$page_num_current$win_counter SetEnableState true
		result_handle_$page_num_current$win_counter GetSubcaseList

		if { $win_counter == 2 } { 
			result_handle_$page_num_current$win_counter SetCurrentSubcase 2 
		}
		set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]
		
		set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
		set last_step [ expr { $numsim_id_val - 1} ]
		result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

		#----------------------HIDE NOTE START---------------------------#
		anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
		Note_hide_$page_num_current$win_counter SetVisibility False
		#----------------------HIDE NOTE END-----------------------------#

		legend_handle$page_num_current$win_counter SetType user
		legend_handle$page_num_current$win_counter SetPosition upperleft
		legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
		legend_handle$page_num_current$win_counter SetNumericPrecision 2
		legend_handle$page_num_current$win_counter SetReverseEnable false
		legend_handle$page_num_current$win_counter SetNumberOfColors 9
		legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
		legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
		legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
		legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
		legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
		legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
		legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
		legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
		legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
		legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
		legend_handle$page_num_current$win_counter OverrideValue 0 0.000

		hwc result scalar legend title font="{Noto Sans} 12 bold roman"
		hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
		#hwc result scalar legend values minimum=false
		
		legend_handle$page_num_current$win_counter SetType dynamic

		contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
		contour_handle_$page_num_current$win_counter SetDataComponent $data_comp_sunexp
		anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
		anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

		hwc result scalar legend values entitylabel=false

		set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
		
		model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

		selection_handle_$page_num_current$win_counter SetVisibility true
		selection_handle_$page_num_current$win_counter SetSelectMode displayed

		foreach comp_biw_part $biw_only_comps_id {
			model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
			part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent
			part_handle_$page_num_current$win_counter$comp_biw_part SetVisibility false

		}
		
		win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
		fit_control_$page_num_current$win_counter Fit
		fit_control_$page_num_current$win_counter SetOrientation right

		hwc result scalar legend layout type=fixed
		anim_handle_$page_num_current$win_counter Draw

		#puts "one load page done - moving to biw"


		# ########################################### PAGE 2  END ######################################################		
		master_project AddPage
		set win_counter 1

		incr page_num_current
	}
	
	return $page_num_current

}


proc ::GA_Report::sunexposure_parts { op_file_name op_file_path page_num_current  } {

	#puts $op_file_name
	set op_file $op_file_name
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	
	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"

	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 1 } {$part_counter < $part_files_count} {incr part_counter} {
		set file1 [ lindex $files_list_name_only $part_counter]
		set file [open $file1]
			set filevalues [read $file]
		close $file
		
		# ############################################ START X Y Z PLOTS ############################################################						
		set axis_counter 1
		
		for {set axis_counter 1 } {$axis_counter <= 4} {incr axis_counter} {	
		
			master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
			page_handle$op_file_cur$page_num_current  SetLayout 1
			master_project SetActivePage $page_num_current

			if { $axis_counter == 1 } { set data_comp_sunexp "Mag"   }
			if { $axis_counter == 2 } { set data_comp_sunexp "X"   }
			if { $axis_counter == 3 } { set data_comp_sunexp "Y"   }
			if { $axis_counter == 4 } { set data_comp_sunexp "Z"   }					

			for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {

				set one 1
				set two 2

				page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
				win_of$page_num_current$win_counter SetClientType animation
				win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
				page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
				#puts $op_file_path

				anim_handle_$page_num_current$win_counter Draw
				set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
				anim_handle_$page_num_current$win_counter Draw
				anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
				model_handle_$page_num_current$win_counter SetResult $op_file_path

				model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
				result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
				contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
				contour_handle_$page_num_current$win_counter SetEnableState true

				#----------------------HIDE NOTE START---------------------------#
				anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
				Note_hide_$page_num_current$win_counter SetVisibility False
				#----------------------HIDE NOTE END-----------------------------#

				legend_handle$page_num_current$win_counter SetType user
				legend_handle$page_num_current$win_counter SetPosition upperleft
				legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
				legend_handle$page_num_current$win_counter SetNumericPrecision 2
				legend_handle$page_num_current$win_counter SetReverseEnable false
				legend_handle$page_num_current$win_counter SetNumberOfColors 9

				if { $axis_counter == 1 } { legend_handle$page_num_current$win_counter SetColor 0 "192 192 192" }
				if { $axis_counter == 2 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }
				if { $axis_counter == 3 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }
				if { $axis_counter == 4 } { legend_handle$page_num_current$win_counter SetColor 0 "0  0 200" }

				legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
				legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
				legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
				legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
				legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
				legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
				legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
				legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
				legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
				legend_handle$page_num_current$win_counter OverrideValue 0 0.000
				legend_handle$page_num_current$win_counter SetType dynamic

				hwc result scalar legend values entitylabel=false
				hwc result scalar legend title font="{Noto Sans} 12 bold roman"
				hwc result scalar legend values valuefont="{Noto Sans} 12 bold roman"
				#hwc result scalar legend values minimum=false

				contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"

				contour_handle_$page_num_current$win_counter SetDataComponent $data_comp_sunexp
				#contour_handle_$page_num_current$win_counter SetLayer Max
				#contour_handle_$page_num_current$win_counter SetAverageMode advanced
				#contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
				anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
				anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

				if { $win_counter == 2 } { result_handle_$page_num_current$win_counter SetCurrentSubcase 2 }

				set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
				set last_step [ expr { $numsim_id_val - 1} ]
				
				result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

				set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

				selection_handle_$page_num_current$win_counter SetVisibility true
				selection_handle_$page_num_current$win_counter SetSelectMode displayed

				foreach element_part $filevalues {
					selection_handle_$page_num_current$win_counter Add "id $element_part"
				}
				model_handle_$page_num_current$win_counter SetMeshMode features
				model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
				model_handle_$page_num_current$win_counter ReverseMask
				selection_handle_$page_num_current$win_counter Clear

				set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

				selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
				selection_handle_comp_$page_num_current$win_counter Add all	
				contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

				model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

				#anim_handle_$page_num_current$win_counter GetNoteHandle note_handle_$page_num_current$win_counter$one [ anim_handle_$page_num_current$win_counter AddNote ]
				#anim_handle_$page_num_current$win_counter GetNoteHandle note_handle_$page_num_current$win_counter$two [ anim_handle_$page_num_current$win_counter AddNote ]
				set max [legend_handle$page_num_current$win_counter GetValue 9]
				set min [legend_handle$page_num_current$win_counter GetValue 0]


				if { $axis_counter == 1 } {
					set max_note_text "Max" 
					set min_note_text "Max" 
				}
				if { $axis_counter == 2 } { 
					set max_note_text "Towards Back" 
					set min_note_text "Towards Front"						
				}
				if { $axis_counter == 3 } {  
					set max_note_text "Towards In" 
					set min_note_text "Towards Out"
				}
				if { $axis_counter == 4 } {  
					set max_note_text "Towards Top" 
					set min_note_text "Towards Bottom"

				}
				#anim_handle_$page_num_current$win_counter GetMeasureHandle measure_handle$page_num_current$win_counter 1
				#measure_handle$page_num_current$win_counter SetLabel measureminmax
				#measure_handle$page_num_current$win_counter SetType "Dynamic MinMax Result"
				#measure_handle$page_num_current$win_counter CreateItem
				#note_handle_$page_num_current$win_counter$one SetAttachment "$max $max_note_text "
				#note_handle_$page_num_current$win_counter$one SetPositionToAttachment true
				#note_handle_$page_num_current$win_counter$one SetFont "{Calibri} 8 normal roman"
				#note_handle_$page_num_current$win_counter$one SetText "$max $max_note_text "

				hwc annotation measure "Static MinMax Result" display visibility= true id=false font="{Noto Sans} 14 normal roman"
				win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
				fit_control_$page_num_current$win_counter Fit

				fit_control_$page_num_current$win_counter SetOrientation right
				hwc result scalar legend layout type=fixed
				anim_handle_$page_num_current$win_counter Draw

			}
			master_project AddPage
			incr page_num_current

		}
		# ############################################ END X Y Z PLOTS ############################################################
	}	

	#master_project AddPage
	return $page_num_current
}


proc ::GA_Report::fdenergy_master { op_file_name op_file_path page_num_current  } {
			
	if { $::GA_Report::tool_element_id == "" } { set ::GA_Report::tool_element_id 10001 }
	#puts $op_file_name
	set op_file $op_file_name
	if { $::GA_Report::c3var == "Abaqus_S" } {
		set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	}
				
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_cur [ string map {".erfh5" ""} $op_file ]
	}
	   
	#puts "master node is $::GA_Report::user_master_id"

	set solver_choice $::GA_Report::c3var
	#set client_choice $::GA_Report::c4var
	#set product_choice $::GA_Report::c5var

	if { $::GA_Report::c3var == "Abaqus_S" } {
		set op_file_curve $op_file_path

		if { $::GA_Report::user_master_id >= 1 } { 
			set master_node_id $::GA_Report::user_master_id
		} else {
			set master_node_id 1001
		}
		set n_master_id N$master_node_id

		#puts "solver is abaqus -setting values"
		set ::GA_Report::solver_extension ".odb"
		set ::GA_Report::plot_disp_datatype "Displacement"
		
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
		set ::GA_Report::strain_datatype "PE-Global-Plastic strain components IP"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "vonMises"
		
		set ::GA_Report::curve_disp_datatype "Displacement"
		set ::GA_Report::curve_force_datatype "CF-Point loads"
		
		set ::GA_Report::x_curve_comp "MAG"
		set ::GA_Report::y_curve_comp "MAG"
		set ::GA_Report::x_curve_request $n_master_id
		set ::GA_Report::y_curve_request $n_master_id

		set win1_op_file_curve_x $op_file_path
		set win1_op_file_curve_y $op_file_path
		
		set win2_op_file_curve_x $op_file_path
		set win2_op_file_curve_y $op_file_path

		set ::GA_Report::win1_curve_x_disp_datatype  "Node (Time History)"
		set ::GA_Report::win1_curve_y_energy_datatype "Model (Time History)"
		
		set ::GA_Report::win1_x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::win1_y_curve_comp "ENKIT-Total internal energy"
		
		set ::GA_Report::win1_x_curve_request "$::GA_Report::contact_pair_name"
		set ::GA_Report::win1_y_curve_request "Model 1"
		
		set ::GA_Report::win2_curve_x_disp_datatype  "Node (Time History)"
		set ::GA_Report::win2_curve_y_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::win2_x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::win2_y_curve_comp "Contact_Force-Magnitude"
		
		set ::GA_Report::win2_x_curve_request "$::GA_Report::contact_pair_name"
		set ::GA_Report::win2_y_curve_request "IMPACTOR_TRIM_CONTACT"
		
	}

	if { $::GA_Report::c3var == "PamCrash" } {		
		set op_file_curve $op_file_path
		
		#puts "solver is Pamcrash -setting values"

		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		set ::GA_Report::stress_datatype "ESTRESS"
		set ::GA_Report::strain_datatype "EPLE/2D"
		
		set ::GA_Report::stress_datacomp "Maximum equivalent stress in shell element"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype "Node (Time History)"						
		set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::x_curve_comp "Contact_Force-Magnitude"
		set ::GA_Report::y_curve_comp "Translational_Displacement-Magnitude"
		
		set ::GA_Report::x_curve_request "IMPACTOR_TRIM_CONTACT"
		# ###############################THNODE NAME IS CONFLICTING , THIS MAY NEED TO BE STANDARDIZED OR ADDED TO GUI"
		# set ::GA_Report::y_curve_request "Verschiebung Pruefkoerper"
		
		#set ::GA_Report::y_curve_request "Impactor_Displacement"
		set ::GA_Report::y_curve_request "$::GA_Report::contact_pair_name"
		
		
		set ::GA_Report::win1_curve_x_disp_datatype  "Node (Time History)"
		set ::GA_Report::win1_curve_y_energy_datatype "Model (Time History)"
		
		set ::GA_Report::win1_x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::win1_y_curve_comp "ENKIT-Total internal energy"
		
		set ::GA_Report::win1_x_curve_request "$::GA_Report::contact_pair_name"
		set ::GA_Report::win1_y_curve_request "Model 1"
		
		set ::GA_Report::win2_curve_x_disp_datatype  "Node (Time History)"
		set ::GA_Report::win2_curve_y_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::win2_x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::win2_y_curve_comp "Contact_Force-Magnitude"
		
		set ::GA_Report::win2_x_curve_request "$::GA_Report::contact_pair_name"
		set ::GA_Report::win2_y_curve_request "IMPACTOR_TRIM_CONTACT"
	
		set win1_op_file_curve_x $op_file_path
		set win1_op_file_curve_y $op_file_path
		
		set win2_op_file_curve_x $op_file_path
		set win2_op_file_curve_y $op_file_path		
				
	}

	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		# ################################### NEED TO UPDATE FROM HERE #####################################
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		
		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 

		set ::GA_Report::curve_disp_datatype  "nodout"
		set ::GA_Report::curve_force_datatype "rcforc"

		set y_c_r "$::GA_Report::contact_pair_name"
		set ycr_add "-Slave"

		set ::GA_Report::x_curve_comp  "resultant_force"
		set ::GA_Report::y_curve_comp "resultant_displacement"

		set ::GA_Report::x_curve_request  "$y_c_r$ycr_add"
		set ::GA_Report::y_curve_request "$::GA_Report::master_node_id"

		set ::GA_Report::win1_curve_y_energy_datatype "glstat"
		set ::GA_Report::win1_y_curve_comp "internal_energy"
		set ::GA_Report::win1_y_curve_request "glstat"

		set ::GA_Report::win1_curve_x_disp_datatype  "nodout"						
		set ::GA_Report::win1_x_curve_comp "resultant_displacement"						
		set ::GA_Report::win1_x_curve_request "$::GA_Report::master_node_id"

		set ::GA_Report::win2_curve_x_disp_datatype  "nodout"
		set ::GA_Report::win2_x_curve_comp "resultant_displacement"
		set ::GA_Report::win2_x_curve_request "$::GA_Report::master_node_id"
		
		set ::GA_Report::win2_curve_y_force_datatype "rcforc"						
		set ::GA_Report::win2_y_curve_comp "resultant_force"						
		set ::GA_Report::win2_y_curve_request "$y_c_r$ycr_add"

		# ################################### NEED TO UPDATE FROM HERE #####################################
	
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]

		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
		set op_file_curve_y  $op_file_curve_x

		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement" 
		
		
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"

		set cut_string {d3plot} 
		set cut_slash {/} 
		
		set op_file_cur $op_file
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		
		
		set win1_op_file_curve_x $op_file_path
		set win1_op_file_curve_y [ string map {"d3plot" "glstat"} $win1_op_file_curve_x  ]
		
		set win2_op_file_curve_x $op_file_path
		set win2_op_file_curve_y [ string map {"d3plot" "binout0000"} $win1_op_file_curve_x  ]
		
		set win1_op_file_curve_x $win2_op_file_curve_y
		
		#puts $win1_op_file_curve_x
		#puts $win1_op_file_curve_y
					

	}

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
				
	master_project SetActivePage $page_num_current


	#puts $op_file_cur
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1			

	# ############################################################ WINDOW 1 CURVE START ###############################################################
	page_handle$op_file_cur$page_num_current SetActiveWindow 1

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter SetClientType plot
	win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter
	plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
	curve_handle_$page_num_current$win_counter GetVectorHandle win1_x_vector_handle_$page_num_current$win_counter x
	curve_handle_$page_num_current$win_counter GetVectorHandle win1_y_vector_handle_$page_num_current$win_counter y

	curve_handle_$page_num_current$win_counter SetName "Internal Energy Vs Displacement"

	win1_x_vector_handle_$page_num_current$win_counter SetType file
	win1_y_vector_handle_$page_num_current$win_counter SetType file
				
	if { $::GA_Report::c3var == "LsDyna" } {

		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_y


		win1_x_vector_handle_$page_num_current$win_counter  SetSubcase nodout
		win1_y_vector_handle_$page_num_current$win_counter  SetSubcase glstat
		#	y_vector_handle_$page_num_current$win_counter  SetSubcase rcforc
			

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_x_disp_datatype"
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_y_energy_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_y_curve_comp"	
	} 

	if { $::GA_Report::c3var == "PamCrash" } {

		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_y

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_x_disp_datatype"
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_y_energy_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_y_curve_comp"

		
	} 

	if { $::GA_Report::c3var == "Abaqus_S" } {
		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_y

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_x_disp_datatype"
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_y_energy_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_y_curve_comp"	
	} 

	#puts "curve loaded"

	plot_handle_$page_num_current$win_counter GetVerticalAxisHandle win1_y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
	plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle win1_x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]

	# input is static at N and mJ
	set force_energy_input [ string map {, " "} $::GA_Report::force_energy_string ]
	set force_input [lindex $force_energy_input 0]
	set energy_input [lindex $force_energy_input 1]


	if { $::GA_Report::c6var == "TON_mm_S_N_Mpa" } {
		set current_force_unit "N"
		set current_Disp_unit "mm"
		set current_energy_unit "mJ"
		set force_converted $force_input
		set energy_converted $energy_input
	}

	if { $::GA_Report::c6var == "KG_mm_MS_KN_GPa" } { 
		set current_force_unit "KN"
		set current_Disp_unit "mm"
		set current_energy_unit "J"
		set force_converted [ expr { $force_input / 1000 }]
		set energy_converted [ expr { $energy_input /1000 }]

	}

	win1_y_axis_handle_$page_num_current$win_counter SetLabel "Internal_Energy $current_energy_unit"
	win1_x_axis_handle_$page_num_current$win_counter SetLabel "Displacement $current_Disp_unit"        

	plot_handle_$page_num_current$win_counter AddHorizontalDatum
	plot_handle_$page_num_current$win_counter GetHorizontalDatumHandle win1_energy_datum_handle_$page_num_current$win_counter 1
	win1_energy_datum_handle_$page_num_current$win_counter SetLabel "Energy $energy_converted $current_energy_unit"
	win1_energy_datum_handle_$page_num_current$win_counter SetPosition $energy_converted
	win1_energy_datum_handle_$page_num_current$win_counter SetLineStyle 2


	plot_handle_$page_num_current$win_counter Recalculate
	plot_handle_$page_num_current$win_counter Autoscale
	plot_handle_$page_num_current$win_counter Draw

	#plot_handle_$page_num_current$win_counter AddVerticalDatum
	#plot_handle_$page_num_current$win_counter GetVerticalDatumHandle win1_energy_datum_handle_$page_num_current$win_counter 1

	# ############################################################ WINDOW 1 CURVE END ###############################################################			

	incr win_counter

	# ############################################################ WINDOW 2 CURVE START ###############################################################
	page_handle$op_file_cur$page_num_current SetActiveWindow 2		
	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter SetClientType plot
	win_of$page_num_current$win_counter GetClientHandle plot_handle_$page_num_current$win_counter
	plot_handle_$page_num_current$win_counter GetCurveHandle curve_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter AddCurve]
	curve_handle_$page_num_current$win_counter GetVectorHandle win1_x_vector_handle_$page_num_current$win_counter x
	curve_handle_$page_num_current$win_counter GetVectorHandle win1_y_vector_handle_$page_num_current$win_counter y

	curve_handle_$page_num_current$win_counter SetName "Impactor force Vs Displacement"

	win1_x_vector_handle_$page_num_current$win_counter SetType file
	win1_y_vector_handle_$page_num_current$win_counter SetType file
				
	if { $::GA_Report::c3var == "LsDyna" } {

		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win1_op_file_curve_x

		win1_x_vector_handle_$page_num_current$win_counter  SetSubcase nodout
		win1_y_vector_handle_$page_num_current$win_counter SetSubcase rcforc

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win1_curve_x_disp_datatype" 
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win2_curve_y_force_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win1_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win2_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win1_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win2_y_curve_comp"		
	} 

	if { $::GA_Report::c3var == "PamCrash" } {

		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win2_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win2_op_file_curve_y

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win2_curve_x_disp_datatype"
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win2_curve_y_force_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win2_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win2_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win2_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win2_y_curve_comp"

		
	} 

	if { $::GA_Report::c3var == "Abaqus_S" } {

		win1_x_vector_handle_$page_num_current$win_counter SetFilename $win2_op_file_curve_x 
		win1_y_vector_handle_$page_num_current$win_counter SetFilename $win2_op_file_curve_y

		win1_x_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win2_curve_x_disp_datatype"
		win1_y_vector_handle_$page_num_current$win_counter SetDataType "$::GA_Report::win2_curve_y_force_datatype"

		win1_x_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win2_x_curve_request"
		win1_y_vector_handle_$page_num_current$win_counter SetRequest "$::GA_Report::win2_y_curve_request"

		win1_x_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win2_x_curve_comp"
		win1_y_vector_handle_$page_num_current$win_counter SetComponent "$::GA_Report::win2_y_curve_comp"
		
	}


	#puts "curve loaded"

	plot_handle_$page_num_current$win_counter GetVerticalAxisHandle win1_y_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfVerticalAxes]
	plot_handle_$page_num_current$win_counter GetHorizontalAxisHandle win1_x_axis_handle_$page_num_current$win_counter [ plot_handle_$page_num_current$win_counter GetNumberOfHorizontalAxes]

	win1_y_axis_handle_$page_num_current$win_counter SetLabel "Force $current_force_unit"
	win1_x_axis_handle_$page_num_current$win_counter SetLabel "Displacement $current_Disp_unit"

	plot_handle_$page_num_current$win_counter AddHorizontalDatum
	plot_handle_$page_num_current$win_counter GetHorizontalDatumHandle win2_force_datum_handle_$page_num_current$win_counter 1
	win2_force_datum_handle_$page_num_current$win_counter SetLabel "Force $force_converted $current_force_unit"
	win2_force_datum_handle_$page_num_current$win_counter SetPosition $force_converted
	win2_force_datum_handle_$page_num_current$win_counter SetLineStyle 2


	plot_handle_$page_num_current$win_counter Recalculate
	plot_handle_$page_num_current$win_counter Autoscale
	plot_handle_$page_num_current$win_counter Draw




	# ############################################################ WINDOW 2 CURVE END ###############################################################

	master_project AddPage
	set win_counter 1

	incr page_num_current
	return $page_num_current


}



proc ::GA_Report::wr_master { op_file_name op_file_path page_num_current } {

	 if { $::GA_Report::tool_element_id == "" } { set ::GA_Report::tool_element_id 10001 }
	 
	 if { $::GA_Report::user_master_id >= 1 } { set master_node_id $::GA_Report::user_master_id

	} else {
		set master_node_id 1001
	}
	 
	#puts $op_file_name
	set op_file $op_file_name
	#set master_node_id 1000
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]   

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {

		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1

	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 3
	master_project SetActivePage $page_num_current

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent
	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right


	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter
	# ########################################### WINDOW 2 START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"
	model_handle_$page_num_current$win_counter SetMeshMode features
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { 
		result_handle_$page_num_current$win_counter SetCurrentSubcase 2 
	}

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id
	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### WINDOW 2  END ######################################################		

	# ########################################### WINDOW 3  START ######################################################

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 3
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path

	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"

	model_handle_$page_num_current$win_counter SetMeshMode features

	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { 
		result_handle_$page_num_current$win_counter SetCurrentSubcase 2 
	}

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	# ########################################### WINDOW 3  END ######################################################
	master_project AddPage
	set win_counter 1
	incr page_num_current

	# ########################################### PAGE 2  WINDOW 1 START ######################################################	
	
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 3
	master_project SetActivePage $page_num_current

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed
	
	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right


	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter



	# ########################################### PAGE 2 WINDOW 2 START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#my_client GetSectionHandle my_section $SectionID
	#puts "my_section_$page_num_current$win_counter"

	model_handle_$page_num_current$win_counter SetMeshMode features


	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { 
		result_handle_$page_num_current$win_counter SetCurrentSubcase 2
	}

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false


	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### PAGE 2 WINDOW 2  END ######################################################		

	# ########################################### PAGE 2 WINDOW 3  START ######################################################

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 3
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features
	
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { result_handle_$page_num_current$win_counter SetCurrentSubcase 2 }

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id
	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	foreach comp_biw_part $biw_only_comps_id {
		model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current$win_counter$comp_biw_part $comp_biw_part
		part_handle_$page_num_current$win_counter$comp_biw_part SetPolygonMode transparent

	}

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	master_project AddPage
	set win_counter 1
	incr page_num_current

	return $page_num_current
}

proc ::GA_Report::wr_biw { op_file_name op_file_path page_num_current } {

	if { $::GA_Report::tool_element_id == "" } { 
		set ::GA_Report::tool_element_id 10001
	}

	if { $::GA_Report::user_master_id >= 1 } { 
		set master_node_id $::GA_Report::user_master_id
	} else {
		set master_node_id 1001
	}
	 
	#puts $op_file_name
	set op_file $op_file_name
	#set master_node_id 1000
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]   

	set i 0
	set k 1
	set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
	set biw_formatcsv200 ".csv"
	set biw_slash_200 "/"
	set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

	set biw_only_comps_id [list]
	set biw_only_comps_name [list]

	set file_all_comps [open $biw_read_parts_path]
	set filevalues_all_comps [read $file_all_comps ]
	set all_comp_length [ llength $filevalues_all_comps ]
	set end_length [ expr { $all_comp_length * 2}]

	while { $i < $all_comp_length } {
		set biw_each_line [ lindex $filevalues_all_comps  $i ]
		set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
		set biw_each_line_split [ split $biw_each_line  , ]
		set biw_each_lineid_split [ split $biw_each_lineid  , ]

		set comp_name_check [lindex $biw_each_line_split 0]
		set comp_id_check [lindex $biw_each_lineid_split 0]

		set biw_content [lsearch -all -inline $comp_name_check *BIW*]
		set exclude_part [ llength $biw_content ]

		if { $exclude_part == 0 } {

		} else {
			append biw_only_comps_id $comp_id_check
			append biw_only_comps_id " "
			append biw_only_comps_name $comp_name_check
			append biw_only_comps_name " "
		}					 

		incr i 2
		incr k 2
	}

	close $file_all_comps


	if { $::GA_Report::c3var == "Abaqus_S" } {
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
	}

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	set section_id 1


	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1
	master_project SetActivePage $page_num_current
	
	
	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::plot_disp_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id {
		selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" 
	}

	model_handle_$page_num_current$win_counter SetMeshMode features
	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear

	#legend_handle$page_num_current$win_counter SetType dynamic
	#contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_$page_num_current$win_counter GetID]]
	#model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_$page_num_current$win_counter GetID]]

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	hwc result scalar load type=Displacement displayed=true
	
	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### PAGE 1 WINDOW 2 START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features

	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { 
		result_handle_$page_num_current$win_counter SetCurrentSubcase 2 
	}

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed

	foreach comp_biw_part $biw_only_comps_id { 	
		selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" 
	}

	model_handle_$page_num_current$win_counter SetMeshMode features
	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear

	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right
	
	hwc result scalar load type="S-Global-Stress components IP" displayed=true
	
	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	#puts "one load page done - moving to ISO"
			
	# ########################################### PAGE 1 WINDOW 2 END ######################################################

	master_project AddPage
	set win_counter 1
	incr page_num_current
	
	
	# ########################################### PAGE 2 WINDOW 1 START ######################################################	
	master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
	page_handle$op_file_cur$page_num_current  SetLayout 1
	master_project SetActivePage $page_num_current

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 1
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#anim_handle_$page_num_current$win_counter AddModel $op_file_path
	#puts "one file loaded"
	#anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter [ anim_handle_$page_num_current$win_counter GetActiveModel ]
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	#there is no active model- so revert
	model_handle_$page_num_current$win_counter SetResult $op_file_path
	#puts "result loaded"
	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList
	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	hwc result scalar legend values entitylabel=false

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	#contour_handle_$page_num_current$win_counter SetLayer Max
	#contour_handle_$page_num_current$win_counter SetAverageMode simple

	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed
	
	foreach comp_biw_part $biw_only_comps_id { 	
		selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" 
	}

	model_handle_$page_num_current$win_counter SetMeshMode features
	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear


	hwc result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced  layer=Max system=global displayed=true
	hwc attribute global transparency true
	hwc attribute global features true
	hwc result iso display currentvalue= 1
	hwc result iso display color=Red
	hwc result iso display usecolor=true
	#puts "iso end"
	
	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right


	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	incr win_counter

	# ########################################### PAGE 1 WINDOW 2 END ######################################################	

	# ########################################### PAGE 2 WINDOW 2 START ######################################################	

	page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
	page_handle$op_file_cur$page_num_current SetActiveWindow 2
	win_of$page_num_current$win_counter SetClientType animation
	win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter

	set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
	#puts "section file loaded"
	anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
	model_handle_$page_num_current$win_counter SetResult $op_file_path


	#puts "anim handle done"
	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_set_$page_num_current$win_counter [ model_handle_$page_num_current$win_counter AddSelectionSet node ]
	selection_set_$page_num_current$win_counter Add "id $::GA_Report::master_node_id"
	model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter

	#puts "master node loaded"

	win_of$page_num_current$win_counter GetViewControlHandle view_control_handle_$page_num_current$win_counter
	anim_handle_$page_num_current$win_counter GetSectionHandle section_cur_handle_$page_num_current$win_counter [anim_handle_$page_num_current$win_counter AddSection 0]

	query_handle_$page_num_current$win_counter SetSelectionSet [ selection_set_$page_num_current$win_counter GetID ]
	query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
	query_handle_$page_num_current$win_counter SetQuery "node.coords"

	query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
	set node_coord_section [ iterator_handle_$page_num_current$win_counter GetDataList]
	#puts $node_coord_section
	set x_of_base [ lindex $node_coord_section 0 ]
	set y_of_base [ lindex $node_coord_section 1 ]
	set z_of_base [ lindex $node_coord_section 2 ]

	#puts $x_of_base

	#my_client GetSectionHandle my_section $SectionID

	#puts "my_section_$page_num_current$win_counter"


	model_handle_$page_num_current$win_counter SetMeshMode features

	model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
	result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
	contour_handle_$page_num_current$win_counter SetEnableState true
	result_handle_$page_num_current$win_counter GetSubcaseList

	if { $win_counter == 2 } { result_handle_$page_num_current$win_counter SetCurrentSubcase 2 }

	set second_step_label [ result_handle_$page_num_current$win_counter GetSubcaseLabel 1 ]

	set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
	set last_step [ expr { $numsim_id_val - 1} ]
	result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step

	#----------------------HIDE NOTE START---------------------------#
	anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
	Note_hide_$page_num_current$win_counter SetVisibility False
	#----------------------HIDE NOTE END-----------------------------#

	legend_handle$page_num_current$win_counter SetType user
	legend_handle$page_num_current$win_counter SetPosition upperleft
	legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
	legend_handle$page_num_current$win_counter SetNumericPrecision 3
	legend_handle$page_num_current$win_counter SetReverseEnable false
	legend_handle$page_num_current$win_counter SetNumberOfColors 9
	legend_handle$page_num_current$win_counter SetColor 0 "192 192 192"
	legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
	legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
	legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
	legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
	legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
	legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
	legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
	legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
	legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
	legend_handle$page_num_current$win_counter OverrideValue 0 0.000

	#legend_handle$page_num_current$win_counter SetType dynamic
	contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"
	contour_handle_$page_num_current$win_counter SetDataComponent Mag
	
	hwc result scalar legend values entitylabel=false


	set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet component]

	model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

	selection_handle_$page_num_current$win_counter SetVisibility true
	selection_handle_$page_num_current$win_counter SetSelectMode displayed


	

	foreach comp_biw_part $biw_only_comps_id { 	selection_handle_$page_num_current$win_counter Add "id $comp_biw_part" }



	model_handle_$page_num_current$win_counter SetMeshMode features
	model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
	model_handle_$page_num_current$win_counter ReverseMask
	selection_handle_$page_num_current$win_counter Clear

	
	hwc result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced  layer=Max system=global displayed=true
	hwc attribute global transparency true
	hwc attribute global features true
	hwc result iso display currentvalue= 1
	hwc result iso display color=Red
	hwc result iso display usecolor=true
	#puts "iso end"


	win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
	fit_control_$page_num_current$win_counter Fit
	fit_control_$page_num_current$win_counter SetOrientation right

	model_handle_$page_num_current$win_counter SetMeshMode features
	anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
	anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"
	anim_handle_$page_num_current$win_counter Draw

	

	#puts "one load page done - moving to ISO"
	
	
	# ########################################### PAGE 2 WINDOW 2 END ######################################################
	
	
	master_project AddPage
	set win_counter 1
	incr page_num_current
	
	
	return $page_num_current

}

proc ::GA_Report::wr_parts { op_file_name op_file_path page_num_current } {

	# puts $op_file_name
	set op_file $op_file_name
	set op_file_cur [ string trim $op_file "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "LsDyna" } {

		if { $::GA_Report::user_master_id >= 1 } { 
			set ::GA_Report::master_node_id $::GA_Report::user_master_id
		} else {
			set ::GA_Report::master_node_id 1001
		}
		
		set ::GA_Report::n_master_id "N$::GA_Report::master_node_id"
		#puts "solver is LS DYNA -setting values"

		set ::GA_Report::solver_extension ""
		set ::GA_Report::plot_disp_datatype "Displacement"
		
		set ::GA_Report::stress_datatype "Stress"
		set ::GA_Report::strain_datatype "Effective plastic strain"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "Scalar value"
		
		set ::GA_Report::curve_disp_datatype  "Displacement"
		set ::GA_Report::curve_force_datatype "discrete/nodes"
		
		set ::GA_Report::x_curve_comp "resultant_force"
		set ::GA_Report::y_curve_comp "Mag"
		
		set ::GA_Report::x_curve_request "$::GA_Report::master_node_id"
		set ::GA_Report::y_curve_request "$::GA_Report::n_master_id"
		
		   
		set ::GA_Report::x_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::x_joint_component_type	"Time"
		set ::GA_Report::y_joint_data_type "CTF1-Connector element total force"
		set ::GA_Report::y_joint_component_type "Value"
		
		set cut_string {d3plot} 
		set cut_slash {/}
		
		set op_file_cur [ string trim $op_file_cur "$cut_string" ]
		set op_file_cur [ string trim $op_file_cur "$cut_slash" ]
		#set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_cur ]
		
		set op_file_curve_y $op_file_path
		set op_file_curve_x [ string map {"d3plot" "binout0000"} $op_file_curve_y ]
	
	}

	set t [::post::GetT];
	variable SecListIndex {}
	set win_counter 1
	

	set dir_name_to_read $::GA_Report::dir_for_parts_list
	set formatcsv200 ".csv"
	set slash_200 "/"
	set read_parts_path "$dir_name_to_read$slash_200$::GA_Report::data_folder$slash_200$op_file_cur"

	set files_list_name_only [list]
	set files_list_name_only [glob -nocomplain -directory $read_parts_path *.csv]
	set part_files_count [llength $files_list_name_only]

	for {set part_counter 0 } {$part_counter < $part_files_count} {incr part_counter} {

		set file1 [ lindex $files_list_name_only $part_counter]
		set file [open $file1]
		set filevalues [read $file]
		close $file

		for {set pg_counter 1 } {$pg_counter <= 2} {incr pg_counter} {

			master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
			page_handle$op_file_cur$page_num_current  SetLayout 1
			master_project SetActivePage $page_num_current
		
			for {set win_counter 1 } {$win_counter <= 2} {incr win_counter} {

				page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
				page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
				win_of$page_num_current$win_counter SetClientType animation
				win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
				page_handle$op_file_cur$page_num_current SetActiveWindow $win_counter
				#puts $op_file_path

				anim_handle_$page_num_current$win_counter Draw
				set loop_id_val [anim_handle_$page_num_current$win_counter AddModel $op_file_path]
				anim_handle_$page_num_current$win_counter Draw
				anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter $loop_id_val
				model_handle_$page_num_current$win_counter SetResult $op_file_path

				model_handle_$page_num_current$win_counter GetResultCtrlHandle result_handle_$page_num_current$win_counter
				result_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter
				contour_handle_$page_num_current$win_counter GetLegendHandle legend_handle$page_num_current$win_counter
				contour_handle_$page_num_current$win_counter SetEnableState true


				#----------------------HIDE NOTE START---------------------------#
				anim_handle_$page_num_current$win_counter GetNoteHandle Note_hide_$page_num_current$win_counter 1
				Note_hide_$page_num_current$win_counter SetVisibility False
				#----------------------HIDE NOTE END-----------------------------#

				legend_handle$page_num_current$win_counter SetType user
				legend_handle$page_num_current$win_counter SetPosition upperleft
				legend_handle$page_num_current$win_counter SetNumericFormat "fixed"
				legend_handle$page_num_current$win_counter SetNumericPrecision 3
				legend_handle$page_num_current$win_counter SetReverseEnable false
				legend_handle$page_num_current$win_counter SetNumberOfColors 9
				legend_handle$page_num_current$win_counter SetColor 0 "0 0 255"
				legend_handle$page_num_current$win_counter SetColor 1 "21 121 255"
				legend_handle$page_num_current$win_counter SetColor 2 "0 199 221"
				legend_handle$page_num_current$win_counter SetColor 3 "40 255 185"
				legend_handle$page_num_current$win_counter SetColor 4 "57 255 0"
				legend_handle$page_num_current$win_counter SetColor 5 "170 255 0"
				legend_handle$page_num_current$win_counter SetColor 6 "255 227 0"
				legend_handle$page_num_current$win_counter SetColor 7 "255 113 0"
				legend_handle$page_num_current$win_counter SetColor 8 "255   0   0"
				legend_handle$page_num_current$win_counter SetColor 9 "192 192 192"
				legend_handle$page_num_current$win_counter OverrideValue 0 0.000

				hwc result scalar legend values entitylabel=false

				contour_handle_$page_num_current$win_counter SetDataType "$::GA_Report::stress_datatype"

				if { $pg_counter == 2 } {
					contour_handle_$page_num_current$win_counter SetDataComponent "SignedVonMises"

				} else {
					contour_handle_$page_num_current$win_counter SetDataComponent "SignedVonMises"
				}

				contour_handle_$page_num_current$win_counter SetLayer Max
				contour_handle_$page_num_current$win_counter SetAverageMode advanced

				if { ($::GA_Report::c3var == "LsDyna" )||($::GA_Report::c3var == "PamCrash" )} {

				} else {
					contour_handle_$page_num_current$win_counter SetCornerDataEnabled true
				}
				
				set numsim_id_val [ result_handle_$page_num_current$win_counter GetNumberOfSimulations 1]
				set last_step [ expr { $numsim_id_val - 1} ]
				result_handle_$page_num_current$win_counter SetCurrentSimulation $last_step


				set selection_set_id [ model_handle_$page_num_current$win_counter AddSelectionSet element]

				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_$page_num_current$win_counter $selection_set_id

				selection_handle_$page_num_current$win_counter SetVisibility true
				selection_handle_$page_num_current$win_counter SetSelectMode displayed

				set dimension_counter 1
				foreach element_part $filevalues {
						selection_handle_$page_num_current$win_counter Add "id $element_part"
						# ADD HERE ELEMENT DIMENSION ONCE AND DECIDE THE CONTOUR TYPE
						if { $::GA_Report::c3var == "PamCrash" } { 
							if { $dimension_counter == 1} { 
								model_handle_$page_num_current$win_counter GetQueryCtrlHandle dimesion_query_$page_num_current$win_counter$dimension_counter
								dimesion_query_$page_num_current$win_counter$dimension_counter SetSelectionSet $selection_set_id
								
								dimesion_query_$page_num_current$win_counter$dimension_counter SetQuery "element.config";
								dimesion_query_$page_num_current$win_counter$dimension_counter GetIteratorHandle dimesion_iterator_$page_num_current$win_counter$dimension_counter
								set config_data [dimesion_iterator_$page_num_current$win_counter$dimension_counter GetDataList]
								#puts " element config is $config_data"
								
									if { $config_data == 210 } {
									
									contour_handle_$page_num_current$win_counter SetDataComponent "vonMises"
									contour_handle_$page_num_current$win_counter SetDataType "SXYZ/3D/Stress"
									
																			
									} else {

									}
							}			
						}
						
					incr dimension_counter
				}
				
				model_handle_$page_num_current$win_counter SetMeshMode features
				model_handle_$page_num_current$win_counter Mask [selection_handle_$page_num_current$win_counter GetID]
				model_handle_$page_num_current$win_counter ReverseMask
				selection_handle_$page_num_current$win_counter Clear

				set selection_set_id_comp [ model_handle_$page_num_current$win_counter AddSelectionSet component]
				model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_comp_$page_num_current$win_counter $selection_set_id_comp

				selection_handle_comp_$page_num_current$win_counter SetSelectMode displayed
				selection_handle_comp_$page_num_current$win_counter Add all


				legend_handle$page_num_current$win_counter SetType dynamic
				contour_handle_$page_num_current$win_counter SetSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

				model_handle_$page_num_current$win_counter RemoveSelectionSet [selection_handle_comp_$page_num_current$win_counter GetID]]

				anim_handle_$page_num_current$win_counter SetDisplayOptions contour true
				anim_handle_$page_num_current$win_counter SetDisplayOptions "legend" "true"

				win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
				fit_control_$page_num_current$win_counter Fit
				fit_control_$page_num_current$win_counter SetOrientation right


				if { $pg_counter == 2 } {

					hwc result iso load type="S-Global-Stress components IP" component=SignedVonMises avgmode=advanced  layer=Max system=global displayed=true
					hwc attribute global transparency true
					hwc attribute global features true
					hwc result iso display currentvalue= 1
					hwc result iso display color=Red
					hwc result iso display usecolor=true
					#puts "iso end"

				}

				anim_handle_$page_num_current$win_counter Draw

			}

			master_project AddPage
			incr page_num_current

		}
		#master_project AddPage
		#incr page_num_current
	}	

	#master_project AddPage
	return $page_num_current   
}

proc ::GA_Report::stress_name_process { read_parts_path file1 } {
				
	set formatcsv200 ".csv"
	set slash_200 "/"
	
	set yield_value_numeric 9999
	set ultimate_value_numeric 9999
	set strain_value_numeric 9999
	set mat_final_name "empty"

	#puts "file 1 string name is $file1"
	#puts "file path is $read_parts_path"
	set part_mat [ string trim $file1 "$read_parts_path" ]
	set part_mat [ string trim $part_mat "$formatcsv200" ]

	set part_mat_split [ split $part_mat  _ ]
	
	set yield_index [lsearch $part_mat_split XXY]
	set ultimate_index [lsearch $part_mat_split XXU]
	set strain_index [lsearch $part_mat_split XXS]
	set material_start_index [lsearch $part_mat_split XXMS]
	set material_end_index [lsearch $part_mat_split XXME]
	
	if { $yield_index >= 0 } { 
		set yield_index [ expr { $yield_index + 1 } ]
		set yield_value [ lindex $part_mat_split $yield_index ]
		set yield_value_numeric [ string map {"P" "."} $yield_value ]
	}
		
	if { $strain_index >= 0 } { 
		set strain_index [ expr { $strain_index + 1 } ]
		set strain_value [ lindex $part_mat_split $strain_index ]
		set strain_value_numeric [ string map {"P" "."} $strain_value ]
	}	
		
	if { $ultimate_index >= 0 } { 
		set ultimate_index [ expr { $ultimate_index + 1 } ]
		set ultimate_value [ lindex $part_mat_split $ultimate_index ]
		
		set ultimate_value_numeric [ string map {"P" "."} $ultimate_value ]	
	}
		
	if { ($material_start_index > 0 ) && ( $material_end_index > 0 ) } { 
	
		set scope_of_index [ expr { $material_end_index - $material_start_index } ]
		set material_start_val [ expr  { $material_start_index + 1 } ]
		set material_end_val [ expr  { $material_end_index - 1 } ]
		
		set mat_final_name ""
		set u_score _
			
		for {set win_counter 1 } {$win_counter < $scope_of_index} {incr win_counter} {
			set mat_piece [ lindex $part_mat_split $material_start_val ]
			set mat_final_name $mat_final_name$u_score$mat_piece
			incr material_start_val
		}
	
	}
	
	set return_string $mat_final_name
	lappend return_string $yield_value_numeric
	lappend return_string $ultimate_value_numeric
	lappend return_string $strain_value_numeric
	
	#puts "return string is $return_string"
	return $return_string										
}

# ----------------------------------------------- CONTROL FLOW FUNCTIONS-----------------------------------------------------
proc ::GA_Report::ListGenerate {entityList mapEntityRow} {

	set report_pagetype_list [list]

	set entities [list]
	foreach row $mapEntityRow {
		if {[lsearch $entityList [lindex $row 0]]!=-1} {
			lappend entities [lindex $row 1]
			#puts "found [lindex $row 1] in [lindex $row 0]"
		}
	}

	# foreach entity $entities {

		# #puts $entity 

	# }
	set ::GA_Report::selected_files_list $entities 
	#puts "selected files list in list generate is "
	#puts $::GA_Report::selected_files_list

	#puts $::GA_Report::user_master_id 	
	#puts $::GA_Report::user_biw_string 
	#puts $::GA_Report::user_rbe_string 

	if { $::GA_Report::cbState(empty1) == 1} { 
		set loadmaster_val 1
		lappend report_pagetype_list loadmaster

	} else {
		set loadmaster_val 0
	}

	if { $::GA_Report::cbState(empty2) == 1} { 
		set impactmaster_val 1
		lappend report_pagetype_list impactmaster

	} else {
		set impactmaster_val 0
	}

	if { $::GA_Report::cbState(empty3) == 1} { 
		set fdenergy_val 1
		lappend report_pagetype_list fdenergy

	} else {
		set fdenergy_val 0
	}

	if { $::GA_Report::cbState(empty4) == 1} { 
		set partwisestress_val 1
		lappend report_pagetype_list partwisestress

	} else {
		set partwisestress_val 0
	}

	if { $::GA_Report::cbState(empty5) == 1} { 
		set partwisestrain_val 1
		lappend report_pagetype_list partwisestrain

	} else {
		set partwisestrain_val 0
	}

	if { $::GA_Report::cbState(empty6) == 1} { 
		set asurfacestrain_val 1
		lappend report_pagetype_list asurfacestrain

	} else {
		set asurfacestrain_val 0
	}

	if { $::GA_Report::cbState(empty7) == 1} { 
		set localimpact_val 1
		lappend report_pagetype_list localimpact

	} else {
		set localimpact_val 0
	}

	if { $::GA_Report::cbState(empty8) == 1} { 
		set retainerforcce_val 1
		lappend report_pagetype_list retainerforce

	} else {
		set retainerforce 0
	}

	if { $::GA_Report::cbState(empty9) == 1} { 
		set screwforce_val 1
		lappend report_pagetype_list screwforce

	} else {
		set screwforce_val 0
	}

	if { $::GA_Report::cbState(empty10) == 1} { 
		set htforce_val 1
		lappend report_pagetype_list htforce

	} else {
		set htforce_val 0
	}

	if { $::GA_Report::cbState(empty11) == 1} { 
		set sunexposure_val 1
		lappend report_pagetype_list sunexposure

	} else {
		set sunexposure_val 0
	}


	if { $::GA_Report::cbState(empty14) == 1} { 
		set sunexposure_assembly 1
		lappend report_pagetype_list sunexposure_assembly

	} else {
		set sunexposure_assembly_val 0
	}
	
	if { $::GA_Report::cbState(empty15) == 1} { 
		set sunexposure_parts 1
		lappend report_pagetype_list sunexposure_parts

	} else {
		set sunexposure_parts_val 0
	}


	if { $::GA_Report::cbState(empty17) == 1} { 
		set ::GA_Report::disp_force 1
	} else {
		set ::GA_Report::disp_force 0
	}

	if { $::GA_Report::cbState(empty19) == 1} { 
		set wr_master 1
		lappend report_pagetype_list wrmaster

	} else {
		set wr_master 0
	}

	if { $::GA_Report::cbState(empty20) == 1} { 
		set wr_biw 1
		lappend report_pagetype_list wrbiw 

	} else {
		set wr_biw 0
	}

	if { $::GA_Report::cbState(empty21) == 1} { 
		set wr_parts 1
		lappend report_pagetype_list wrparts
	} else {
		set wr_parts 0
	}

	#puts $report_pagetype_list

	set ::GA_Report::pages_selected $report_pagetype_list

	set solver_choice $::GA_Report::c3var
	#set client_choice $::GA_Report::c4var
	#set product_choice $::GA_Report::c5var

	if { $::GA_Report::c3var == "Abaqus_S" } {
		if { $::GA_Report::user_master_id >= 1 } { 
			set master_node_id $::GA_Report::user_master_id
		} else {
			set master_node_id 1001
		}
		set ::GA_Report::n_master_id "N$master_node_id"

		#puts "solver is abaqus -setting values"
		set ::GA_Report::solver_extension ".odb"
		set ::GA_Report::plot_disp_datatype "Displacement"
		
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
		set ::GA_Report::strain_datatype "PE-Global-Plastic strain components IP"
		
		set ::GA_Report::stress_datacomp "vonMises"
		set ::GA_Report::strain_datacomp "vonMises"
		
		set ::GA_Report::curve_disp_datatype "Displacement"
		set ::GA_Report::curve_force_datatype "CF-Point loads"
		
		set ::GA_Report::x_curve_comp "MAG"
		set ::GA_Report::y_curve_comp "MAG"
		set ::GA_Report::x_curve_request $::GA_Report::n_master_id
		set ::GA_Report::y_curve_request $::GA_Report::n_master_id

	}

	if { $::GA_Report::c3var == "PamCrash" } {

		#puts "solver is Pamcrash -setting values"

		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 

		set ::GA_Report::stress_datatype "ESTRESS"
		set ::GA_Report::strain_datatype "EPLE/2D"
		
		set ::GA_Report::stress_datacomp "Maximum equivalent stress in shell element"
		set ::GA_Report::strain_datacomp "Scalar value"

		set ::GA_Report::curve_disp_datatype "Displacement"
		set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		
		set ::GA_Report::x_curve_comp "Translational_Displacement-Magnitude"
		set ::GA_Report::y_curve_comp "Contact_Force-Magnitude"
		set ::GA_Report::x_curve_request "Impactor_Displacement"
		set ::GA_Report::y_curve_request "IMPACTOR_TRIM_CONTACT"
			
	}

	if { $::GA_Report::c3var == "LsDyna" } {

		#puts "solver is LsDyna -setting values"
		set ::GA_Report::solver_extension ".erfh5"
		set ::GA_Report::plot_disp_datatype "Displacement" 
		set ::GA_Report::curve_disp_datatype "Displacement"
		set ::GA_Report::stress_datatype "S-Global-Stress components IP"
		set ::GA_Report::strain_datatype "PE-Global-Plastic strain components IP"
		set ::GA_Report::curve_force_datatype "Contact Variables (Time History)"
		set ::GA_Report::x_curve_comp "Impactor_Displacement"
		set ::GA_Report::y_curve_comp "IMPACTOR_TRIM_CONTACT"
		

	}

	::GA_Report::sessionload $report_pagetype_list $::GA_Report::c3var 
}



proc ::GA_Report::page_loader { } {

	if {![info exists ::GA_Report::selected_files_list]} {
		tk_messageBox -message "Select valid result file(s)" -icon error
		return
	}

	#.mytoplevel.a.c.labelFrame002.rbe63 configure -background green
	hwt::PopupWorkingWindow "Loading Files to chosen Structure...After This is done, if Partwise results are selected , Plese remove unwanted partwise files from required result folders"
	#puts "page_loader_starts"
	set solver_chosen $::GA_Report::c3var
	#set client_chosen $::GA_Report::c4var
	#set product_chosen $::GA_Report::c5var
	#puts $solver_chosen
	#puts $client_chosen
	#puts $product_chosen

	set file_map [list]

	#puts $::GA_Report::selected_files_list
	set data_col_page_nums [ llength $::GA_Report::selected_files_list ]
	set page_number [ expr { $data_col_page_nums + 1} ]
	::GA_Report::registerPreferences "Test_Menu 2" "C:/Program Files/Altair/2022/hwdesktop/utility/VehicleSafetyTools/mv_hv_hg/vst.mvw"

	set ::GA_Report::page_starter_num  $page_number 

	foreach file_selected $::GA_Report::selected_files_list {

		set load_file_path [concat $::GA_Report::dir_slash$file_selected]
		#puts "pages selected $::GA_Report::pages_selected"

		foreach page_selected $::GA_Report::pages_selected {

			if {$page_selected == "loadmaster" } {  

				::GA_Report::load_page_master $file_selected $load_file_path $page_number		
				set file_map_string $file_selected
				append file_map_string " "
				append file_map_string "load_master_page"
				append file_map_string " "
				append file_map_string $page_number
				incr page_number
				lappend file_map $file_map_string
				set file_map_string $file_selected
				append file_map_string " "
				append file_map_string "load_master_page_biw"
				append file_map_string " "
				append file_map_string $page_number
				lappend file_map $file_map_string
				incr page_number

			}

			if {$page_selected == "fdenergy" } { 	
				set page_from_fun [ ::GA_Report::fdenergy_master $file_selected $load_file_path $page_number ]
				
				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "fdenergy_master_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun
			}

			if {$page_selected == "impactmaster" } { 

				::GA_Report::impact_page_master $file_selected $load_file_path $page_number

				set file_map_string $file_selected
				append file_map_string " "
				append file_map_string "impact_master_page"
				append file_map_string " "
				append file_map_string $page_number
				incr page_number
				lappend file_map $file_map_string
				set file_map_string $file_selected
				append file_map_string " "
				append file_map_string "impact_master_page_biw"
				append file_map_string " "
				append file_map_string $page_number
				lappend file_map $file_map_string
				incr page_number

			}

			if {$page_selected == "retainerforce" } { 

				set page_from_fun [ ::GA_Report::retainerforce_page $file_selected $load_file_path $page_number ]
				set diff [expr { $page_from_fun - $page_number }]

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "retainer_force_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun
			}
			
			if {$page_selected == "screwforce" } { 

				set page_from_fun [ ::GA_Report::screwforce_page $file_selected $load_file_path $page_number ]
				set diff [expr { $page_from_fun - $page_number }]

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "screw_force_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun
			}


			if {$page_selected == "htforce" } { 

				set page_from_fun [ ::GA_Report::htforce_page $file_selected $load_file_path $page_number ]
				set diff [expr { $page_from_fun - $page_number }]

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "ht_force_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun
			}

			if {$page_selected == "partwisestress" } { 

				if { $::GA_Report::cbState(empty24) == 1} {
					set page_from_fun [ ::GA_Report::partwise_stress_vonmises $file_selected $load_file_path $page_number ]
				} else {
					set page_from_fun [ ::GA_Report::partwise_stress $file_selected $load_file_path $page_number ]
				}

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "partwise_stress_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}

				set page_number $page_from_fun
			}

			if {$page_selected == "partwisestrain" } { 
	
				if { $::GA_Report::cbState(empty24) == 1} {
					set page_from_fun [ ::GA_Report::partwise_strain_vonmises $file_selected $load_file_path $page_number ]
				} else {
					set page_from_fun [ ::GA_Report::partwise_strain $file_selected $load_file_path $page_number ]
				}

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "partwise_strain_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun

			}

			if {$page_selected == "sunexposure" } { 
				set page_from_fun [ ::GA_Report::sunexposure_master $file_selected $load_file_path $page_number ]

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "sunexposure_master_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun
				#puts " after sunexposure master page is $page_number"
			}
			
			
			if {$page_selected == "sunexposure_assembly" } { 

				set page_from_fun [ ::GA_Report::sunexposure_assembly $file_selected $load_file_path $page_number ]
				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "sunexposure_assembly_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun

			}
			
			if {$page_selected == "sunexposure_parts" } { 

				set page_from_fun [ ::GA_Report::sunexposure_parts $file_selected $load_file_path $page_number ]
				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "sunexposure_parts_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}
				set page_number $page_from_fun

			}

			if {$page_selected == "asurfacestrain" } { 

				set page_from_fun [ ::GA_Report::a_surface_strain $file_selected $load_file_path $page_number ]

				for {set i $page_number } {$i < $page_from_fun} {incr i} {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "a_surface_strain_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				}


				set page_number $page_from_fun
				#puts " after a surface-strain plot page is $page_number"

			}


			if {$page_selected == "wrmaster" } { 

				set page_from_fun [ ::GA_Report::wr_master $file_selected $load_file_path $page_number ]

				for {set i $page_number } {$i < $page_from_fun} {incr i 2 } {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_master_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string
					
					set k [ expr { $i + 1 } ]

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_master_page_2"
					append file_map_string " "
					append file_map_string $k
					lappend file_map $file_map_string
				
				}

				set page_number $page_from_fun
				#puts " after wr master page is $page_number"

			}
			
			if {$page_selected == "wrbiw" } { 

				set page_from_fun [ ::GA_Report::wr_biw $file_selected $load_file_path $page_number ]

				for {set i $page_number } {$i < $page_from_fun} {incr i 2 } {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_biw_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string
					
					set k [ expr { $i + 1 } ]

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_biw_page_2"
					append file_map_string " "
					append file_map_string $k
					lappend file_map $file_map_string	

				}

				set page_number $page_from_fun
				#puts " after wr biw master page is $page_number"

			}
			
			if {$page_selected == "wrparts" } { 

				set page_from_fun [ ::GA_Report::wr_parts $file_selected $load_file_path $page_number ]

				for {set i $page_number } {$i < $page_from_fun} {incr i 2 } {

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_parts_master_page"
					append file_map_string " "
					append file_map_string $i
					lappend file_map $file_map_string

				
					set k [ expr { $i + 1 } ]

					set file_map_string $file_selected
					append file_map_string " "
					append file_map_string "wr_parts_master_page_2"
					append file_map_string " "
					append file_map_string $k
					lappend file_map $file_map_string	
				}

				set page_number $page_from_fun
				#puts " after wr parts master page is $page_number"

			}

			if {$page_selected == "localimpact" } { 

				set local_impact_string_input $::GA_Report::grill_comp_name
				set proper_name [ string map {, " "} $::GA_Report::grill_comp_name ]
				set ::GA_Report::file_name_local_impact [lindex $proper_name 0]
				set ::GA_Report::comp_name_local_impact [lindex $proper_name 1]
				#puts " local impact file name entry $::GA_Report::file_name_local_impact"
				#puts " local impact COMP ID entry $::GA_Report::comp_name_local_impact"

				#puts "should match with file_name_enty $file_selected "
				
				if { $::GA_Report::c3var == "LsDyna" } {
		
					set cut_string {d3plot} 
					set before_cut $file_selected
					set Dd3plot_cut [ string trim $file_selected "$cut_string" ]
					set slash {/}
					set Dd3plot_cut [ string trim $Dd3plot_cut "$slash" ]
		
					set file_selected $Dd3plot_cut
					#puts "aftercut file is $Dd3plot_cut"
		
				}
				
				#puts " condition is $file_selected = $::GA_Report::file_name_local_impact"

				if { $file_selected == $::GA_Report::file_name_local_impact } {
					
					if { $::GA_Report::c3var == "LsDyna" } {  
						set file_selected $before_cut
					}
					
					#puts "file name matched with local impact"
					set page_from_fun [ ::GA_Report::local_impact_page_master $file_selected $load_file_path $page_number ]

					for {set i $page_number } {$i < $page_from_fun} {incr i} {

						set file_map_string $file_selected
						append file_map_string " "
						append file_map_string "local_impact_page"
						append file_map_string " "
						append file_map_string $i
						lappend file_map $file_map_string

					}

					set page_number $page_from_fun
					#puts " after local impact page is $page_number"
				}

			}

		}

	}

	set ::GA_Report::page_list_loaded $file_map
	#puts $::GA_Report::page_list_loaded
	set ::GA_Report::final_page_number $page_number
	set ::GA_Report::file_open_finish_time [clock seconds]
	
	.mytoplevel.a.c.labelFrame002.rbe63 configure -background green
	
	hwt::PopdownWorkingWindow

}

proc ::GA_Report::Generate_python_head {} {

	#.mytoplevel.a.q.labelFrame001011.rbe10 configure -background green
	
	if {![info exists ::GA_Report::page_starter_num]} {
		tk_messageBox -message "Please execute the tool" -icon error
		return
	}
	
	set ::GA_Report::publish_start_time [clock seconds]
	
	#puts $::GA_Report::report_folder_path
	global report_dir
	set report_dir $::GA_Report::report_folder_path


	set path_first "prs = Presentation('"
	set path_last "')"
	set slash "\\"
	set master "Master_2023.pptx"
	set ppt_path "$path_first$::GA_Report::report_folder_path$slash$master$path_last"


	set OUTPUT_FILE "$report_dir/report_01.py"
	set ::GA_Report::file_head [open $OUTPUT_FILE w+];


	puts $::GA_Report::file_head "import collections"
	puts $::GA_Report::file_head "import collections.abc"
	puts $::GA_Report::file_head "from pptx import Presentation"
	puts $::GA_Report::file_head "from pptx.util import Inches"
	puts $::GA_Report::file_head "from pptx.dml.color import RGBColor"
	puts $::GA_Report::file_head "from pptx.enum.dml import MSO_THEME_COLOR"
	puts $::GA_Report::file_head "from pptx.enum.shapes import MSO_SHAPE"
	puts $::GA_Report::file_head "from pptx.enum.shapes import MSO_CONNECTOR"
	puts $::GA_Report::file_head "from pptx.dml.color import ColorFormat, RGBColor"
	puts $::GA_Report::file_head "from pptx.enum.text import PP_ALIGN"

	puts $::GA_Report::file_head $ppt_path


	::GA_Report::image_generate
	
	.mytoplevel.a.q.labelFrame001011.rbe10 configure -background green

}


proc ::GA_Report::image_generate {} {

	hwt::PopupWorkingWindow "Generating Animations , Graphs and Contour plots"
	set j 0
	for {set i $::GA_Report::page_starter_num } {$i < $::GA_Report::final_page_number} {incr i} {

		set current_page_data [ lindex $::GA_Report::page_list_loaded $j]
		#puts "page data is "
		#puts $current_page_data

		set file_name [lindex  $current_page_data 0 ]
		set page_type [lindex  $current_page_data 1]
		set Page_number [ lindex $current_page_data 2]

		if { $page_type == "load_master_page" } {   ::GA_Report::image_load_master $file_name  $page_type  $Page_number      }
		if { $page_type == "load_master_page_biw" } {  ::GA_Report::do_nothing           }
		if { $page_type == "impact_master_page" } {   ::GA_Report::image_impact_master $file_name  $page_type  $Page_number          }
		if { $page_type == "impact_master_page_biw" } {  ::GA_Report::do_nothing           }
		if { $page_type == "retainer_force_page" } {  ::GA_Report::image_retainer_master $file_name  $page_type  $Page_number           }
		if { $page_type == "screw_force_page" } {  ::GA_Report::image_retainer_master $file_name  $page_type  $Page_number           }
		if { $page_type == "ht_force_page" } {  ::GA_Report::image_retainer_master $file_name  $page_type  $Page_number           }

		if { $page_type == "partwise_stress_page" } {
			::GA_Report::image_partwise_stress_master $file_name  $page_type  $Page_number
		}
		
		if { $::GA_Report::cbState(empty24) == 1} {
			if { $page_type == "partwise_strain_page" } {
				::GA_Report::image_partwise_strain_master_vonmises $file_name  $page_type  $Page_number         
			}
		} else {
			if { $page_type == "partwise_strain_page" } { 
				::GA_Report::image_partwise_strain_master $file_name  $page_type  $Page_number 
			}
		}
		
		
		if { $page_type == "a_surface_strain_page" } {  ::GA_Report::image_asurface_strain_master $file_name  $page_type  $Page_number          }
		if { $page_type == "local_impact_page" } { ::GA_Report::image_localimpact_master  $file_name  $page_type  $Page_number          }
		if { $page_type == "sunexposure_master_page" } { ::GA_Report::image_sunexposure_master  $file_name  $page_type  $Page_number          }
		if { $page_type == "sunexposure_assembly_page" } { ::GA_Report::image_sunexposure_assembly_master  $file_name  $page_type  $Page_number          }
		if { $page_type == "sunexposure_parts_page" } { ::GA_Report::image_sunexposure_parts_master  $file_name  $page_type  $Page_number          } 
		if { $page_type == "fdenergy_master_page" } { ::GA_Report::image_fdenergy_master  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_master_page" } { ::GA_Report::image_wr_master_page  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_master_page_2" } { ::GA_Report::image_wr_master_page_2  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_biw_page" } { ::GA_Report::image_wr_biw_page  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_biw_page_2" } { ::GA_Report::image_wr_biw_page_2  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_parts_master_page" } { ::GA_Report::image_wr_parts_master_page  $file_name  $page_type  $Page_number          }
		if { $page_type == "wr_parts_master_page_2" } { ::GA_Report::image_wr_parts_master_page_2  $file_name  $page_type  $Page_number          }
			
		incr j
	}

	hwt::PopdownWorkingWindow
	::GA_Report::py_save_execute
}




proc ::GA_Report::do_nothing { } { 


}

# ----------------------------------------------- IMAGE LOAD MASTER FUNCTIONS-----------------------------------------------------

proc ::GA_Report::image_load_master { file_name_img page_type_img page_number_img } {

	set solver_choice $::GA_Report::c3var
	master_project SetActivePage $page_number_img
	set total_windows 4
	set img_window 2

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]
	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		
		set res_file_name $op_file_cur_name_only
		
	}

	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture animation of displacement window 1
		
		
	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ]	
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]
	}


	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
	}

	 
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	master_session CaptureAnimationByWindow 0 gif $window_image_name_LM_1 0 0 1 1 percent 100 100;

	# capture image of  curve window
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	incr img_window


	# capture animation of section window - section view to be removed.
	page_handle$op_file_image$page_number_img SetActiveWindow 3
	set window_image_name_LM_3 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w3$anim_ext
	master_session CaptureAnimationByWindow 2 gif $window_image_name_LM_3 0 0 1 1 percent 100 100;

	# getting curve max for tool displacement.
	set curve_max_val_list [list]
	set curve_max_val_list [note_handle_$page_number_img$win2 GetExpandedText]
	set tool_max_val [lindex $curve_max_val_list 3]
	#puts "curve max is $tool_max_val"

	# getting curve max for trim displacement.
	set disp_trim_max [legend_handle$page_number_img$win1 GetValue 9]

	######################## capture Biw DISPLACEMENT AND  permanent set OF TRIM #####################################

	set biw_page_num [ expr { $page_number_img + 1} ]
	master_project SetActivePage $biw_page_num
	# capture image of  biw only

	set window_image_name_LMBIW_1 $img_folder_path$res_file_name$biw$page_type_img$us$page_number_img$w1$img_ext
	page_handle$op_file_image$biw_page_num SetActiveWindow 1
	master_session CaptureWindow 0 JPEG "$window_image_name_LMBIW_1" percent 100 100
	incr img_window

	# capture image of permanent set

	set window_image_name_LMBIW_2 $img_folder_path$res_file_name$biw$page_type_img$us$page_number_img$w2$img_ext
	page_handle$op_file_image$biw_page_num SetActiveWindow 2
	master_session CaptureWindow 1 JPEG "$window_image_name_LMBIW_2" percent 100 100
	incr img_window


	set disp_biw_max [legend_handle$biw_page_num$win1 GetValue 9]
	set disp_trim_perm [legend_handle$biw_page_num$win2 GetValue 9]

	::GA_Report::py_load_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $window_image_name_LM_3  $window_image_name_LMBIW_1 $window_image_name_LMBIW_2  $tool_max_val  $disp_trim_max  $disp_biw_max $disp_trim_perm $page_number_img

}

proc ::GA_Report::image_impact_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img
	set total_windows 4
	set img_window 2

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]
	}

	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
		
	}

	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture animation of displacement window 1


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
		
		
	}
	
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	master_session CaptureAnimationByWindow 0 gif $window_image_name_LM_1 0 0 1 1 percent 100 100;

	# capture animation of section window - section view to be removed.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$anim_ext
	master_session CaptureAnimationByWindow 1 gif $window_image_name_LM_2 0 0 1 1 percent 100 100;

	# getting curve max for trim displacement.
	set disp_trim_max [legend_handle$page_number_img$win1 GetValue 9]

	######################## capture Biw DISPLACEMENT AND  permanent set OF TRIM #####################################

	set biw_page_num [ expr { $page_number_img + 1} ]
	master_project SetActivePage $biw_page_num
	# capture image of  biw only

	set window_image_name_LMBIW_1 $img_folder_path$res_file_name$biw$page_type_img$us$page_number_img$w1$img_ext
	page_handle$op_file_image$biw_page_num SetActiveWindow 1
	master_session CaptureWindow 0 JPEG "$window_image_name_LMBIW_1" percent 100 100


	# capture image of permanent set

	set window_image_name_LMBIW_2 $img_folder_path$res_file_name$biw$page_type_img$us$page_number_img$w2$img_ext
	page_handle$op_file_image$biw_page_num SetActiveWindow 2
	master_session CaptureWindow 1 JPEG "$window_image_name_LMBIW_2" percent 100 100



	set disp_biw_max [legend_handle$biw_page_num$win1 GetValue 9]
	set disp_trim_perm [legend_handle$biw_page_num$win2 GetValue 9]

	::GA_Report::py_impact_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $window_image_name_LMBIW_1 $window_image_name_LMBIW_2  $disp_trim_max  $disp_biw_max $disp_trim_perm $page_number_img

}

proc ::GA_Report::image_retainer_master { file_name_img page_type_img page_number_img } {

	set solver_choice $::GA_Report::c3var
	master_project SetActivePage $page_number_img
	set total_windows 4
	set img_window 2

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		
		set res_file_name $op_file_cur_name_only
	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"
	#puts "img_folder_path $img_folder_path"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]
	}

	# capture animation of displacement window 1

	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only	
	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	#puts "image retainer is $window_image_name_LM_1"
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100

	# capture animation of section window - section view to be removed.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	# capture animation of section window - section view to be removed.
	page_handle$op_file_image$page_number_img SetActiveWindow 3
	set window_image_name_LM_3 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w3$img_ext
	master_session CaptureWindow 2 JPEG $window_image_name_LM_3 percent 100 100


	::GA_Report::py_retainer_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $window_image_name_LM_3
}		


proc ::GA_Report::image_localimpact_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window
	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
		
	}
	
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100


	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	set strain_max_local [legend_handle$page_number_img$win2 GetValue 9]
	set strain_local_impact_breakage [legend_handle$page_number_img$win2 GetValue 8]

	::GA_Report::py_localimpact_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $strain_max_local $strain_local_impact_breakage

}	
				
proc ::GA_Report::image_partwise_stress_master { file_name_img page_type_img page_number_img } {

master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list

	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]
	}
	
	if { $::GA_Report::c3var == "LsDyna" } {	
		set cut_string {d3plot}
		set cut_slash {/}						
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
		
	}

	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window
	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 

	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]
	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only	
	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	set stress_parts_local [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	set stress_parts_yield_local [legend_handle$page_number_img$win1 GetValue 8]
	set stress_parts_ultimate_local [legend_handle$page_number_img$win2 GetValue 8]
	
	set material_name_note [ mat_note_$page_number_img$win1 GetText ]
   
   #set stress_parts_yield_local [ expr { $::GA_Report::report_stress_multiplier * $stress_parts_yield_local } ]
   #set stress_parts_ultimate_local [ expr { $::GA_Report::report_stress_multiplier * $stress_parts_ultimate_local } ]

	::GA_Report::py_partwise_stress_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $stress_parts_local $stress_parts_yield_local $stress_parts_ultimate_local $material_name_note

}
				
proc ::GA_Report::image_partwise_strain_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list

	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]
	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window

	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]
	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
	}
	
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	set strain_parts_local [legend_handle$page_number_img$win1 GetValue 9]

	set strain_parts_ultimate_local [legend_handle$page_number_img$win1 GetValue 8]
	set material_name_note [ mat_note_$page_number_img$win1 GetText ]

	::GA_Report::py_partwise_strain_master_code $res_file_name $window_image_name_LM_1    $strain_parts_local  $strain_parts_ultimate_local $material_name_note
}


proc ::GA_Report::image_partwise_strain_master_vonmises { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
		
		
	}
	
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
		
		
	}
	
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	set strain_parts_local [legend_handle$page_number_img$win1 GetValue 9]

	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	set strain_parts_ultimate_local [legend_handle$page_number_img$win1 GetValue 8]
	set material_name_note [ mat_note_$page_number_img$win1 GetText ]


	::GA_Report::py_partwise_strain_master_code_vonmises $res_file_name $window_image_name_LM_1 $window_image_name_LM_2   $strain_parts_local  $strain_parts_ultimate_local $material_name_note
}

				
proc ::GA_Report::image_asurface_strain_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot}
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
		
		
	}
		
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/}
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
			
	}

	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	set strain_parts_asurface [legend_handle$page_number_img$win1 GetValue 9]
	
	set strain_parts_ultimate_asurface [legend_handle$page_number_img$win1 GetValue 8]
	::GA_Report::py_asurface_strain_master_code $res_file_name $window_image_name_LM_1   $strain_parts_asurface  $strain_parts_ultimate_asurface

}
				
				
proc ::GA_Report::image_sunexposure_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list

	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	
	master_session CaptureAnimationByWindow 0 gif $window_image_name_LM_1 0 0 1 1 percent 100 100;
	set max_loading_disp_all [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$anim_ext
	master_session CaptureAnimationByWindow 1 gif $window_image_name_LM_2 0 0 1 1 percent 100 100;
	

   set max_unloading_disp_all [legend_handle$page_number_img$win2 GetValue 9]
   set data_comp_contour [ contour_handle_$page_number_img$win1 GetDataComponent ]
	

	::GA_Report::py_sunexposure_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $max_loading_disp_all $max_unloading_disp_all $data_comp_contour
	
}


proc ::GA_Report::image_sunexposure_assembly_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_loading_disp_all [legend_handle$page_number_img$win1 GetValue 9]
	set min_loading_disp_all [legend_handle$page_number_img$win1 GetValue 0]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$anim_ext
	
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	set max_unloading_disp_all [legend_handle$page_number_img$win2 GetValue 9]
	set min_unloading_disp_all [legend_handle$page_number_img$win2 GetValue 0]
	
	set data_comp_contour [ contour_handle_$page_number_img$win1 GetDataComponent ]

	::GA_Report::py_sunexposure_assembly_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $max_loading_disp_all $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	
}

proc ::GA_Report::image_sunexposure_parts_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_loading_disp_all [legend_handle$page_number_img$win1 GetValue 9]
	set min_loading_disp_all [legend_handle$page_number_img$win1 GetValue 0]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$anim_ext
	
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

   set max_unloading_disp_all [legend_handle$page_number_img$win2 GetValue 9]
   set min_unloading_disp_all [legend_handle$page_number_img$win2 GetValue 0]
	
   set data_comp_contour [ contour_handle_$page_number_img$win1 GetDataComponent ]

	::GA_Report::py_sunexposure_parts_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  $max_loading_disp_all $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	
}


proc ::GA_Report::image_fdenergy_master { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur_name_only [ string trim $res_file_name "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set res_file_name $op_file_cur_name_only
		
		
	}

	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	
	if { $::GA_Report::c3var == "LsDyna" } {
		
		set cut_string {d3plot} 
		set cut_slash {/} 
		set op_file_cur_name_only [ string trim $op_file_image "$cut_string" ]
		set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
		set op_file_image $op_file_cur_name_only
		
		
	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100

	::GA_Report::py_fdenergy_master_code $res_file_name $window_image_name_LM_1  $window_image_name_LM_2  

}

proc ::GA_Report::image_wr_master_page  { file_name_img page_type_img page_number_img } {
					
	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$anim_ext
	master_session CaptureAnimationByWindow 0 gif $window_image_name_LM_1 0 0 1 1 percent 100 100;
	
	
	set max_loading_disp_all [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$anim_ext
	master_session CaptureAnimationByWindow 1 gif $window_image_name_LM_2 0 0 1 1 percent 100 100;
	
	page_handle$op_file_image$page_number_img SetActiveWindow 3
	set window_image_name_LM_3 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w3$anim_ext
	master_session CaptureAnimationByWindow 2 gif $window_image_name_LM_3 0 0 1 1 percent 100 100;

	::GA_Report::py_wr_master_page_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2 $window_image_name_LM_3 $max_loading_disp_all

}




proc ::GA_Report::image_wr_master_page_2  { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list

	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_loading_disp_all [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100
	
	page_handle$op_file_image$page_number_img SetActiveWindow 3
	set window_image_name_LM_3 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w3$img_ext
	master_session CaptureWindow 2 JPEG $window_image_name_LM_3 percent 100 100

	::GA_Report::py_wr_master_page_2_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2 $window_image_name_LM_3 $max_loading_disp_all

}



proc ::GA_Report::image_wr_biw_page  { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list

	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_biw_disp [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100
	set max_biw_stress [legend_handle$page_number_img$win1 GetValue 9]

	::GA_Report::py_wr_biw_page_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2  $max_biw_disp $max_biw_stress
}

proc ::GA_Report::image_wr_biw_page_2  { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img
	
	

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_biw_tensile_stress [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100
	
	set max_biw_compressive_stress [legend_handle$page_number_img$win1 GetValue 9]
	
	::GA_Report::py_wr_biw_page_2_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2  $max_biw_tensile_stress $max_biw_compressive_stress
}



proc ::GA_Report::image_wr_parts_master_page  { file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img
	
	

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	set max_part_tensile_stress [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100
	set max_part_compressive_stress [legend_handle$page_number_img$win1 GetValue 0]

	::GA_Report::py_wr_parts_master_page_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2  $max_part_tensile_stress $max_part_compressive_stress
}


proc ::GA_Report::image_wr_parts_master_page_2 	{ file_name_img page_type_img page_number_img } {

	master_project SetActivePage $page_number_img

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list


	set s1 $file_name_img 
	set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set res_file_name [ string map {".erfh5" ""} $s1 ]

	}
	
	
	set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$res_file_name$slash_110"

	set w1 "_window_1"
	set w2 "_window_2"
	set w3 "_window_3"

	set biw "_biw_"

	set win1 1
	set win2 2
	set win3 3
	set win4 4

	set anim_ext ".gif"
	set img_ext ".jpeg"
	set us "_"

	# capture image of plastic strain window


	set op_file_image [ string trim $file_name_img "$::GA_Report::solver_extension" ] 
	
	if { $::GA_Report::c3var == "PamCrash" } {
		set op_file_image [ string map {".erfh5" ""} $file_name_img ]

	}
	
	page_handle$op_file_image$page_number_img SetActiveWindow 1
	set window_image_name_LM_1 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w1$img_ext
	master_session CaptureWindow 0 JPEG $window_image_name_LM_1 percent 100 100
	
	
	set max_part_tensile_stress [legend_handle$page_number_img$win1 GetValue 9]

	# capture image of plastic strain window.
	page_handle$op_file_image$page_number_img SetActiveWindow 2
	set window_image_name_LM_2 $img_folder_path$res_file_name$us$page_type_img$us$page_number_img$w2$img_ext
	master_session CaptureWindow 1 JPEG $window_image_name_LM_2 percent 100 100
	set max_part_compressive_stress [legend_handle$page_number_img$win1 GetValue 0]
	

	::GA_Report::py_wr_parts_master_page_2_code $res_file_name $window_image_name_LM_1 $window_image_name_LM_2  $max_part_tensile_stress $max_part_compressive_stress

}
	
# --------------------------------------------- PYTHON MASTER CODE FUNCTIONS------------------------------------------------------

proc ::GA_Report::py_load_master_code { out_name pic_win1 pic_win2 pic_win3 pic_biw_1 pic_biw_2 tool_max trim_max biw_max trim_perm page_number_img} {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_load_master_image_import $pic_win1 $pic_win2 $pic_win3 $pic_biw_1 $pic_biw_2 $out_name $tool_max $trim_max $biw_max $trim_perm

	#set ::GA_Report::op_name $output_name
	#set ::GA_Report::prod_name $final_product
	#set ::GA_Report::area_name $final_area_description
	#set ::GA_Report::load_descr $final_load_description
	#set ::GA_Report::load_limit $final_load_limit
	#set ::GA_Report::force_limit $final_load_force_limit
	#set ::GA_Report::tool_descr $final_load_tool_description
	#set ::GA_Report::loc_num $final_point_num
	#set ::GA_Report::tempr_sim $final_temp
	
	#set line1 LOC_NUM FILE_NAME TEMP AREA LOAD  TOOL FORCE LIMIT X Y Z TOOL_MAX TRIM_MAX PERM_TRIM BIW_MAX 
	#lappend ::GA_Report::load_master_list $line1
	
	
	set window_data 3
	set node_coord_section [ iterator_handle_$page_number_img$window_data GetDataList]
	#puts $node_coord_section
	set value_of_base [ lindex $node_coord_section 0 ]
	
	set x_of_base [ lindex $value_of_base 0 ]
	set y_of_base [ lindex $value_of_base 1 ]
	set z_of_base [ lindex $value_of_base 2 ]


	
	set each_line $::GA_Report::loc_num
	append each_line ","
	append each_line $::GA_Report::op_name
	append each_line ", "
	append each_line $::GA_Report::tempr_sim 
	append each_line ", "
	append each_line $::GA_Report::area_name
	append each_line ", "
	append each_line $::GA_Report::load_descr
	append each_line ", "
	append each_line $::GA_Report::tool_descr
	append each_line ", "
	append each_line $::GA_Report::force_limit
	append each_line ", "
	append each_line $::GA_Report::load_limit
	append each_line ", "
	append each_line $x_of_base
	append each_line ", "
	append each_line $y_of_base
	append each_line ", "
	append each_line $z_of_base
	append each_line ", "
	append each_line $tool_max
	append each_line ", "
	append each_line $trim_max
	append each_line ", "
	append each_line $trim_perm
	append each_line ", "
	append each_line $biw_max
	
	lappend ::GA_Report::load_master_list $each_line

}
				


proc ::GA_Report::py_impact_master_code { out_name pic_win1 pic_win2  pic_biw_1 pic_biw_2  trim_max biw_max trim_perm page_number_img } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_impact_master_image_import $pic_win1 $pic_win2  $pic_biw_1 $pic_biw_2 $out_name $trim_max $biw_max $trim_perm

	set window_data 1
	
	set master_coord_list [ measure_handle$page_number_img$window_data GetValueList ]
	set all_val_coord [ lindex $master_coord_list 0 ]

	set x_val_coord [ lindex $all_val_coord 0 ]
	set y_val_coord [ lindex $all_val_coord 1 ]
	set z_val_coord [ lindex $all_val_coord 2 ]

	set each_line $::GA_Report::loc_num
	append each_line ", "
	append each_line $::GA_Report::op_name
	append each_line ", "
	append each_line $::GA_Report::tempr_sim 
	append each_line ", "
	append each_line $::GA_Report::area_name
	append each_line ", "
	append each_line $::GA_Report::load_descr
	append each_line ", "
	append each_line $::GA_Report::tool_descr
	append each_line ", "
	append each_line $::GA_Report::force_limit
	append each_line ", "
	append each_line $::GA_Report::load_limit
	append each_line ", "
	append each_line $x_val_coord
	append each_line ", "
	append each_line $y_val_coord
	append each_line ", "
	append each_line $z_val_coord
	append each_line ", "
	append each_line $trim_max
	append each_line ", "
	append each_line $trim_perm
	append each_line ", "
	append each_line $biw_max
	
	lappend ::GA_Report::impact_master_list $each_line

}

proc ::GA_Report::py_retainer_master_code { out_name pic_win1 pic_win2 pic_win3  } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_retainer_master_image_import $pic_win1 $pic_win2 $pic_win3 $out_name
}

proc ::GA_Report::py_localimpact_master_code { out_name pic_win1 pic_win2 local_strain_max strain_local_impact_breakage } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_localimpact_master_image_import $pic_win1 $pic_win2 $out_name $local_strain_max $strain_local_impact_breakage
}	

proc ::GA_Report::py_partwise_stress_master_code { out_name pic_win1 pic_win2 stress_parts_local stress_parts_yield_local stress_parts_ultimate_local material_name_note } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_partwise_stress_master_image_import $pic_win1 $pic_win2 $out_name $stress_parts_local $stress_parts_yield_local $stress_parts_ultimate_local $material_name_note
}

proc ::GA_Report::py_partwise_strain_master_code { out_name pic_win1  strain_parts_local  strain_parts_ultimate_local material_name_note } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_partwise_strain_master_image_import $pic_win1  $out_name $strain_parts_local  $strain_parts_ultimate_local $material_name_note
}
proc ::GA_Report::py_partwise_strain_master_code_vonmises { out_name pic_win1 pic_win2 strain_parts_local  strain_parts_ultimate_local material_name_note } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_partwise_strain_master_image_import_vonmises $pic_win1 $pic_win2 $out_name $strain_parts_local  $strain_parts_ultimate_local $material_name_note

}
				
				
proc ::GA_Report::py_asurface_strain_master_code { out_name pic_win1  strain_parts_asurface  strain_parts_ultimate_asurface } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_asurface_strain_master_image_import $pic_win1  $out_name $strain_parts_asurface  $strain_parts_ultimate_asurface
}

proc ::GA_Report::py_sunexposure_master_code { out_name pic_win1 pic_win2 max_loading_disp_all max_unloading_disp_all data_comp_contour  } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_sunexposure_image_import $pic_win1 $pic_win2 $out_name  $max_loading_disp_all  $max_unloading_disp_all $data_comp_contour

	set ::GA_Report::unload_limit 1
	set each_line $::GA_Report::op_name
	append each_line ", "
	append each_line $::GA_Report::area_name
	append each_line ", "
	append each_line $::GA_Report::load_descr 
	append each_line ", "
	append each_line $::GA_Report::load_limit
	append each_line ", "
	append each_line $::GA_Report::unload_limit
	append each_line ", "
	append each_line $max_loading_disp_all
	append each_line ", "
	append each_line $max_unloading_disp_all
	append each_line ", "
	append each_line "-"
	append each_line ", "
	append each_line "-"
	append each_line ", "
	append each_line "$data_comp_contour"
	append each_line ", "
	
	
	lappend ::GA_Report::sunexposure_master_list $each_line

}

proc ::GA_Report::py_sunexposure_assembly_code { out_name pic_win1 pic_win2 max_loading_disp_all max_unloading_disp_all min_loading_disp_all min_unloading_disp_all data_comp_contour } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_sunexposure_assembly_image_import $pic_win1 $pic_win2 $out_name  $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour



	set ::GA_Report::unload_limit 1
	set each_line $::GA_Report::op_name
	append each_line ", "
	append each_line $::GA_Report::area_name
	append each_line ", "
	append each_line $::GA_Report::load_descr 
	append each_line ", "
	append each_line $::GA_Report::load_limit
	append each_line ", "
	append each_line $::GA_Report::unload_limit
	append each_line ", "
	append each_line $max_loading_disp_all
	append each_line ", "
	append each_line $max_unloading_disp_all
	append each_line ", "
	append each_line $min_loading_disp_all
	append each_line ", "
	append each_line $min_unloading_disp_all
	append each_line ", "
	append each_line "$data_comp_contour"
	append each_line ", "
	
	
	
	lappend ::GA_Report::sunexposure_master_list $each_line

}
				
proc ::GA_Report::py_sunexposure_parts_code { out_name pic_win1 pic_win2 max_loading_disp_all max_unloading_disp_all min_loading_disp_all min_unloading_disp_all data_comp_contour } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_sunexposure_parts_image_import $pic_win1 $pic_win2 $out_name  $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour



	set ::GA_Report::unload_limit 1
	set each_line $::GA_Report::op_name
	append each_line ", "
	append each_line $::GA_Report::area_name
	append each_line ", "
	append each_line $::GA_Report::load_descr 
	append each_line ", "
	append each_line $::GA_Report::load_limit
	append each_line ", "
	append each_line $::GA_Report::unload_limit
	append each_line ", "
	append each_line $max_loading_disp_all
	append each_line ", "
	append each_line $max_unloading_disp_all
	append each_line ", "
	append each_line $min_loading_disp_all
	append each_line ", "
	append each_line $min_unloading_disp_all
	append each_line ", "
	append each_line "$data_comp_contour"
	append each_line ", "
	
	
	
	lappend ::GA_Report::sunexposure_master_list $each_line

}				


proc ::GA_Report::py_fdenergy_master_code { out_name pic_win1 pic_win2  } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_fdenergy_master_image_import $pic_win1 $pic_win2 $out_name 


}		

proc ::GA_Report::py_wr_master_page_code { out_name pic_win1 pic_win2 pic_win3 max_loading_disp_all		} {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_master_page_image_import $pic_win1 $pic_win2 $pic_win3 $out_name $max_loading_disp_all

}


proc ::GA_Report::py_wr_master_page_2_code { out_name pic_win1 pic_win2 pic_win3 max_loading_disp_all		} {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_master_page_2_image_import $pic_win1 $pic_win2 $pic_win3 $out_name $max_loading_disp_all

}
proc ::GA_Report::py_wr_biw_page_code { out_name pic_win1 pic_win2  max_biw_disp max_biw_stress } {
	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_biw_page_image_import $pic_win1 $pic_win2  $out_name $max_biw_disp $max_biw_stress

}
proc ::GA_Report::py_wr_biw_page_2_code { out_name pic_win1 pic_win2 max_biw_tensile_stress max_biw_compressive_stress } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_biw_page_2_image_import $pic_win1 $pic_win2  $out_name $max_biw_tensile_stress $max_biw_compressive_stress

}
proc ::GA_Report::py_wr_parts_master_page_code { out_name pic_win1 pic_win2 max_part_tensile_stress max_part_compressive_stress } {
				
	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_parts_master_page_image_import $pic_win1 $pic_win2  $out_name $max_part_tensile_stress $max_part_compressive_stress

}
proc ::GA_Report::py_wr_parts_master_page_2_code { out_name pic_win1 pic_win2 max_part_tensile_stress max_part_compressive_stress } {

	::GA_Report::py_heading_write $out_name
	::GA_Report::py_wr_parts_master_page_2_image_import $pic_win1 $pic_win2  $out_name $max_part_tensile_stress $max_part_compressive_stress
}


				
# --------------------------------------------- PYTHON HEADING WRITE FUNCTIONS----------------------------------------------------				

proc ::GA_Report::py_heading_write { output_name  } {


	#add processing to derive the heading , temprature, point number ,project name ,phase , week
	# set report_file_name 

	set ::GA_Report::unit N
	set name_to_process $output_name
	set output_split [split $name_to_process _]

	set client_code [ lindex $output_split 0]
	set project_code [ lindex $output_split 1]
	set product_code [ lindex $output_split 2]
	set solver_code [ lindex $output_split 3]
	set stage_code [ lindex $output_split 4]
	set side_code [ lindex $output_split 5]
	set temp_code [ lindex $output_split 6]
	set part_code [ lindex $output_split 7]
	set load_code [ lindex $output_split 8]
	set force_code [ lindex $output_split 9]
	set funct_code [ lindex $output_split 10]
	set sl_number [ lindex $output_split 11]



	set load_file "/LOAD_CODE.csv"
	set part_file "/PART_CODE.csv"

	set load_read_path $::GA_Report::report_folder_path$load_file
	set part_read_path $::GA_Report::report_folder_path$part_file


	set part_file_val [open $part_read_path]
	set part_filevalues [read $part_file_val]
	set part_file_length [llength $part_filevalues]

	set load_file_val [open $load_read_path]
	set load_filevalues [read $load_file_val]
	set load_file_length [llength $load_filevalues]

	set part_list_split [list]
	set load_list_split [list]

	set i 0
	while {$i <= [expr $part_file_length -1]}  {

		set each_line [lindex $part_filevalues $i]
		set each_line_split [split $each_line ,]
		#puts $each_line_split
		lappend part_list_split $each_line_split
		incr i
	}

	set i 0
	while {$i <= [expr $load_file_length -1]}  {

		set each_line [lindex $load_filevalues $i]
		set each_line_split [split $each_line ,]
		#puts $each_line_split
		lappend load_list_split $each_line_split
		incr i
	}



	foreach input_of_file $part_list_split {

		set input_client [lindex $input_of_file 0]
		set input_product [lindex $input_of_file 1]
		set input_area_code [lindex $input_of_file 2]
		set input_area_description [lindex $input_of_file 3]


		if { $client_code == $input_client } {

			if { $part_code == $input_area_code } {

				set final_area_description $input_area_description
				set final_product $input_product

			}

		}

	}

	foreach input_of_file $load_list_split {

		set input_client [lindex $input_of_file 0]
		set input_load_code [lindex $input_of_file 1]
		set input_load_description [lindex $input_of_file 2]
		set input_load_limit [lindex $input_of_file 3]
		set input_force_limit [lindex $input_of_file 4]
		set input_tool_description [lindex $input_of_file 5]



		if { $client_code == $input_client } {

			if { $load_code == $input_load_code } {

				set final_load_description $input_load_description
				set final_load_limit $input_load_limit
				set final_load_force_limit $input_force_limit
				set final_load_tool_description $input_tool_description
				set final_point_num $sl_number 
				if { $temp_code == "RT" } { set final_temp "23C"}
				if { $temp_code == "HT" } { set final_temp "80C"}


			}

		}

	}


	set space " "
	set col ":"
	set asp "Loc"
	set phase " - Phase - KWxx Vxx Modxx - "

	set ::GA_Report::op_name $output_name
	set ::GA_Report::prod_name $final_product
	set ::GA_Report::area_name $final_area_description
	set ::GA_Report::load_descr $final_load_description
	set ::GA_Report::load_limit $final_load_limit
	set ::GA_Report::force_limit $final_load_force_limit
	set ::GA_Report::tool_descr $final_load_tool_description
	set ::GA_Report::loc_num $final_point_num
	set ::GA_Report::tempr_sim $final_temp


	set final_file_heading_line1 $final_product$space$final_area_description$space$final_temp$space$col$space$asp$space$sl_number


	set final_file_heading_line2 $client_code$space$project_code$phase$final_load_description

	set com_001 {slide = prs.slides.add_slide(prs.slide_layouts[6])}
	puts $::GA_Report::file_head $com_001

	puts $::GA_Report::file_head "slide.shapes.title.text = '$final_file_heading_line2'"

	puts $::GA_Report::file_head "txBox = slide.shapes.add_textbox(3, 2, 3, 4)"
	puts $::GA_Report::file_head "tf = txBox.text_frame"

	puts $::GA_Report::file_head "p = tf.add_paragraph()"
	puts $::GA_Report::file_head "p.text = '    $final_file_heading_line1'"

	puts $::GA_Report::file_head "p.font.size = Inches(0.5)"
	puts $::GA_Report::file_head "p.font.name = 'Calibri'"
	puts $::GA_Report::file_head "p.font.bold = True"
	puts $::GA_Report::file_head "p.font.color.rgb = RGBColor(0xFF, 0xFF, 0xFF)"




}

proc ::GA_Report::py_heading_ask { output_name question } {


	#add processing to derive the heading , temprature, point number ,project name ,phase , week
	# set report_file_name 

	set ::GA_Report::unit N
	set name_to_process $output_name
	set output_split [split $name_to_process _]

	set client_code [ lindex $output_split 0]
	set project_code [ lindex $output_split 1]
	set product_code [ lindex $output_split 2]
	set solver_code [ lindex $output_split 3]
	set stage_code [ lindex $output_split 4]
	set side_code [ lindex $output_split 5]
	set temp_code [ lindex $output_split 6]
	set part_code [ lindex $output_split 7]
	set load_code [ lindex $output_split 8]
	set force_code [ lindex $output_split 9]
	set funct_code [ lindex $output_split 10]
	set sl_number [ lindex $output_split 11]



	set load_file "/LOAD_CODE.csv"
	set part_file "/PART_CODE.csv"

	set load_read_path $::GA_Report::report_folder_path$load_file
	set part_read_path $::GA_Report::report_folder_path$part_file


	set part_file_val [open $part_read_path]
	set part_filevalues [read $part_file_val]
	set part_file_length [llength $part_filevalues]

	set load_file_val [open $load_read_path]
	set load_filevalues [read $load_file_val]
	set load_file_length [llength $load_filevalues]

	set part_list_split [list]
	set load_list_split [list]

	set i 0
	while {$i <= [expr $part_file_length -1]}  {

		set each_line [lindex $part_filevalues $i]
		set each_line_split [split $each_line ,]
		#puts $each_line_split
		lappend part_list_split $each_line_split
		incr i
	}

	set i 0
	while {$i <= [expr $load_file_length -1]}  {

		set each_line [lindex $load_filevalues $i]
		set each_line_split [split $each_line ,]
		#puts $each_line_split
		lappend load_list_split $each_line_split
		incr i
	}

	foreach input_of_file $part_list_split {

		set input_client [lindex $input_of_file 0]
		set input_product [lindex $input_of_file 1]
		set input_area_code [lindex $input_of_file 2]
		set input_area_description [lindex $input_of_file 3]


		if { $client_code == $input_client } {

			if { $part_code == $input_area_code } {

				set final_area_description $input_area_description
				set final_product $input_product

			}

		}

	}

	foreach input_of_file $load_list_split {

		set input_client [lindex $input_of_file 0]
		set input_load_code [lindex $input_of_file 1]
		set input_load_description [lindex $input_of_file 2]
		set input_load_limit [lindex $input_of_file 3]
		set input_force_limit [lindex $input_of_file 4]
		set input_tool_description [lindex $input_of_file 5]

		if { $client_code == $input_client } {

			if { $load_code == $input_load_code } {

				set final_load_description $input_load_description
				set final_load_limit $input_load_limit
				set final_load_force_limit $input_force_limit
				set final_load_tool_description $input_tool_description
				set final_point_num $sl_number 
				if { $temp_code == "RT" } { set final_temp "23C"}
				if { $temp_code == "HT" } { set final_temp "80C"}


			}

		}

	}

	if { $question == "load_limit"} { return $final_load_limit }	
	if { $question == "load_force_limit"} { return $final_load_force_limit }

}

# -------------------------------------------- PYTHON IMAGE IMPORT TO PPT  FUNCTIONS----------------------------------------------

proc ::GA_Report::py_load_master_image_import { pic_win1 pic_win2 pic_win3 pic_biw_1 pic_biw_2 out_name tool_max trim_max biw_max trim_perm } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	
	set pic_win3 [regsub -all {/} $pic_win3 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win3'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(6.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_biw_1 [regsub -all {/} $pic_biw_1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_biw_1'"
	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(3.5)"
	puts $::GA_Report::file_head "height = Inches(2.3)"
	puts $::GA_Report::file_head "width = Inches(2.3)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_biw_2 [regsub -all {/} $pic_biw_2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_biw_2'"
	puts $::GA_Report::file_head "left = Inches(15.1)"
	puts $::GA_Report::file_head "top = Inches(3.5)"
	puts $::GA_Report::file_head "height = Inches(2.3)"
	puts $::GA_Report::file_head "width = Inches(2.3)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"



	::GA_Report::py_load_master_values_table $out_name $tool_max $trim_max $biw_max $trim_perm 
	::GA_Report::py_traffic_light
	::GA_Report::py_load_master_summary
	::GA_Report::py_load_master_proposals 
	::GA_Report::py_load_master_biw_boxes
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
	::GA_Report::py_animation_indicator

}
				
				
proc ::GA_Report::py_impact_master_image_import { pic_win1 pic_win2  pic_biw_1 pic_biw_2 out_name  trim_max biw_max trim_perm } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	set pic_biw_1 [regsub -all {/} $pic_biw_1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_biw_1'"
	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(3.5)"
	puts $::GA_Report::file_head "height = Inches(2.3)"
	puts $::GA_Report::file_head "width = Inches(2.3)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_biw_2 [regsub -all {/} $pic_biw_2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_biw_2'"
	puts $::GA_Report::file_head "left = Inches(15.1)"
	puts $::GA_Report::file_head "top = Inches(3.5)"
	puts $::GA_Report::file_head "height = Inches(2.3)"
	puts $::GA_Report::file_head "width = Inches(2.3)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	::GA_Report::py_impact_master_values_table $out_name  $trim_max $biw_max $trim_perm 
	::GA_Report::py_trimmax_traffic_light
	::GA_Report::py_load_master_summary
	::GA_Report::py_load_master_proposals 
	::GA_Report::py_load_master_biw_boxes
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
	::GA_Report::py_animation_indicator

}




proc ::GA_Report::py_retainer_master_image_import { pic_win1 pic_win2 pic_win3 out_name } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win3 [regsub -all {/} $pic_win3 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win3'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(6.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_failure {C:\\REPORT\\CONNECTOR_FAILURE_CALCULATION.JPG}
	puts $::GA_Report::file_head "img_path = '$pic_failure'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height = Inches(1.47)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"




	::GA_Report::py_plain_traffic_light
	::GA_Report::py_retainer_master_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
	

}


proc ::GA_Report::py_localimpact_master_image_import { pic_win1 pic_win2 out_name local_max_strain strain_local_impact_breakage } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	::GA_Report::py_localimpact_values_table $out_name  $local_max_strain  
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_localimpact_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name

	::GA_Report::py_local_impact_boxes $strain_local_impact_breakage 

	::GA_Report::py_confidential
	::GA_Report::py_animation_indicator



}


proc ::GA_Report::py_partwise_stress_master_image_import { pic_win1 pic_win2 out_name stress_parts_local stress_parts_yield_local stress_parts_ultimate_local material_name_note } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	

	::GA_Report::py_partwise_stress_values_table $out_name  $stress_parts_local  
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_partwise_stress_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_stress_parts_boxes $stress_parts_yield_local $stress_parts_ultimate_local $material_name_note
	
	::GA_Report::py_confidential
	
}



proc ::GA_Report::py_partwise_strain_master_image_import { pic_win1  out_name strain_parts_local  strain_parts_ultimate_local material_name_note } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(12)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	


	::GA_Report::py_partwise_strain_values_table $out_name  $strain_parts_local  
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_partwise_strain_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_strain_parts_boxes  $strain_parts_ultimate_local $material_name_note
	
	::GA_Report::py_confidential
	
}

proc ::GA_Report::py_partwise_strain_master_image_import_vonmises { pic_win1 pic_win2 out_name strain_parts_local  strain_parts_ultimate_local material_name_note } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	
	::GA_Report::py_partwise_strain_values_table $out_name  $strain_parts_local  
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_partwise_strain_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_strain_parts_boxes  $strain_parts_ultimate_local $material_name_note
	
	::GA_Report::py_confidential

}
				
proc ::GA_Report::py_asurface_strain_master_image_import { pic_win1  out_name asurface_parts_local  strain_parts_ultimate_asurface } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(12)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	::GA_Report::py_asurface_strain_values_table $out_name  $asurface_parts_local  
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_asurface_strain_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_asurface_parts_boxes  $strain_parts_ultimate_asurface
	
	::GA_Report::py_confidential
	

}
				

proc ::GA_Report::py_sunexposure_image_import { pic_win1 pic_win2 out_name max_loading_disp_all  max_unloading_disp_all data_comp_contour } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	::GA_Report::py_sunexposure_values_table $out_name  $max_loading_disp_all  $max_unloading_disp_all  
	
	::GA_Report::py_sunexposure_summary $max_loading_disp_all  $max_unloading_disp_all
	::GA_Report::py_sunexposure_traffic_light
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_sunexposure_boxes $data_comp_contour
	::GA_Report::py_sunexposure_general_box
	
	::GA_Report::py_confidential
	::GA_Report::py_animation_indicator

}			

proc ::GA_Report::py_sunexposure_assembly_image_import { pic_win1 pic_win2 out_name max_loading_disp_all  max_unloading_disp_all min_loading_disp_all min_unloading_disp_all data_comp_contour } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	::GA_Report::py_sunexposure_assembly_values_table $out_name  $max_loading_disp_all  $max_unloading_disp_all  $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	
	::GA_Report::py_sunexposure_assembly_summary $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all
	::GA_Report::py_sunexposure_traffic_light
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_sunexposure_boxes $data_comp_contour
	::GA_Report::py_sunexposure_side_boxes $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	
	::GA_Report::py_sunexposure_general_box
	
	::GA_Report::py_confidential
	
}				

proc ::GA_Report::py_sunexposure_parts_image_import { pic_win1 pic_win2 out_name max_loading_disp_all  max_unloading_disp_all min_loading_disp_all min_unloading_disp_all data_comp_contour } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	::GA_Report::py_sunexposure_parts_values_table $out_name  $max_loading_disp_all  $max_unloading_disp_all  $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	
	::GA_Report::py_sunexposure_parts_summary $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all
	::GA_Report::py_sunexposure_traffic_light
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	::GA_Report::py_sunexposure_boxes $data_comp_contour
	::GA_Report::py_sunexposure_side_boxes $max_loading_disp_all  $max_unloading_disp_all $min_loading_disp_all $min_unloading_disp_all $data_comp_contour
	::GA_Report::py_sunexposure_general_box
	
	::GA_Report::py_confidential

}		

proc ::GA_Report::py_fdenergy_master_image_import { pic_win1 pic_win2 out_name  } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"


	::GA_Report::py_fdenergy_values_table $out_name   
	::GA_Report::py_plain_traffic_light

	::GA_Report::py_fdenergy_summary
	::GA_Report::py_general_master_proposals
	::GA_Report::py_top_image $out_name
	
	#::GA_Report::py_fdenergy_boxes $stress_parts_yield_local $stress_parts_ultimate_local
	
	::GA_Report::py_confidential
}

proc ::GA_Report::py_wr_master_page_image_import { pic_win1 pic_win2 pic_win3  out_name max_loading_disp_all } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	
	set pic_win3 [regsub -all {/} $pic_win3 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win3'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(6.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	

	::GA_Report::py_wr_master_page_values_table $out_name $max_loading_disp_all 
	::GA_Report::py_traffic_light
	::GA_Report::py_wr_master_summary 
	
	::GA_Report::py_general_master_proposals
	
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
	::GA_Report::py_animation_indicator

}


proc ::GA_Report::py_wr_master_page_2_image_import { pic_win1 pic_win2 pic_win3  out_name max_loading_disp_all } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	
	set pic_win3 [regsub -all {/} $pic_win3 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win3'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(6.3)"
	puts $::GA_Report::file_head "height = Inches(3)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	::GA_Report::py_wr_master_page_2_values_table $out_name $max_loading_disp_all 
	::GA_Report::py_traffic_light
	::GA_Report::py_wr_master_summary

	::GA_Report::py_general_master_proposals
	
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
}




proc ::GA_Report::py_wr_biw_page_image_import { pic_win1 pic_win2  out_name max_biw_disp max_biw_stress } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"



	::GA_Report::py_wr_biw_page_values_table $out_name $max_biw_disp $max_biw_stress
	::GA_Report::py_traffic_light
	
	::GA_Report::py_wr_biw_summary
	 
	
	::GA_Report::py_general_master_proposals
	
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
}


proc ::GA_Report::py_wr_biw_page_2_image_import { pic_win1 pic_win2  out_name max_biw_tensile_stress max_biw_compressive_stress } { 

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"



	::GA_Report::py_wr_biw_page_2_values_table $out_name $max_biw_tensile_stress $max_biw_compressive_stress 
	::GA_Report::py_traffic_light

	::GA_Report::py_wr_biw_summary
	 

	::GA_Report::py_general_master_proposals

	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential

}


proc ::GA_Report::py_wr_parts_master_page_image_import { pic_win1 pic_win2  out_name max_part_tensile_stress max_part_compressive_stress } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"



	::GA_Report::py_wr_parts_page_values_table $out_name $max_part_tensile_stress $max_part_compressive_stress 
	::GA_Report::py_traffic_light
	
	
	::GA_Report::py_wr_parts_summary $max_part_tensile_stress $max_part_compressive_stress
	
	::GA_Report::py_general_master_proposals
	
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential
}


proc ::GA_Report::py_wr_parts_master_page_2_image_import { pic_win1 pic_win2  out_name max_part_tensile_stress max_part_compressive_stress } {

	set pic_win1 [regsub -all {/} $pic_win1 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win1'"
	puts $::GA_Report::file_head "left = Inches(0.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	set pic_win2 [regsub -all {/} $pic_win2 {\\\\}]
	puts $::GA_Report::file_head "img_path = '$pic_win2'"
	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(3.3)"
	puts $::GA_Report::file_head "height = Inches(6)"
	puts $::GA_Report::file_head "width = Inches(6)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"



	::GA_Report::py_wr_parts_page_values_table  $out_name $max_part_tensile_stress $max_part_compressive_stress 
	 
	::GA_Report::py_traffic_light
	
	
	::GA_Report::py_wr_parts_summary $max_part_tensile_stress $max_part_compressive_stress
	
	::GA_Report::py_general_master_proposals
	
	::GA_Report::py_top_image $out_name
	::GA_Report::py_confidential

}

				
# -------------------------------------------- PYTHON VALUES TABLE  FUNCTIONS-----------------------------------------------------


proc ::GA_Report::py_load_master_values_table { py_out_name py_tool_max py_trim_max py_biw_max py_trim_perm } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {d Structure(mm)} {d Tool(mm)}"
	set cell_value 0		


	set ::GA_Report::trim_max $py_trim_max
	set ::GA_Report::tool_max $py_tool_max
	set ::GA_Report::biw_max $py_biw_max
	set ::GA_Report::trim_perm $py_trim_perm



	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $py_trim_max} { $py_tool_max}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}




proc ::GA_Report::py_impact_master_values_table { py_out_name  py_trim_max py_biw_max py_trim_perm } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 4, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {d Structure(mm)} "
	set cell_value 0		


	set ::GA_Report::trim_max $py_trim_max
	set ::GA_Report::biw_max $py_biw_max
	set ::GA_Report::trim_perm $py_trim_perm

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $py_trim_max} "
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}





proc ::GA_Report::py_localimpact_values_table { py_out_name py_local_max_strain } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 4, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {Strain(%)} "
	set cell_value 0

	set ::GA_Report::localimpact_max_strain $py_local_max_strain

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $py_local_max_strain} "
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}


proc ::GA_Report::py_partwise_stress_values_table { py_out_name py_stress_parts_local } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 3, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Stress($::GA_Report::stress_unit)} "
	set cell_value 0		


	set local_entry $py_out_name
	append local_entry " "
	append local_entry $py_stress_parts_local
	lappend ::GA_Report::partwise_stress $local_entry

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $py_stress_parts_local} "
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}


proc ::GA_Report::py_partwise_strain_values_table { py_out_name py_strain_parts_local } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 3, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description}  {Strain(%)} "
	set cell_value 0		


	set local_entry $py_out_name
	append local_entry " "
	append local_entry $py_strain_parts_local
	#lappend ::GA_Report::partwise_stress $local_entry

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	
	set py_strain_parts_local [ expr { $py_strain_parts_local * 100 } ]
	
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr}  { $py_strain_parts_local} "
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}
				
proc ::GA_Report::py_asurface_strain_values_table { py_out_name py_asurface_parts_local } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 3, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description}  {Strain(%)} "
	set cell_value 0		


	set local_entry $py_out_name
	append local_entry " "
	append local_entry $py_asurface_parts_local
	#lappend ::GA_Report::partwise_stress $local_entry

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	
	set py_asurface_parts_local [ expr { $py_asurface_parts_local * 100 } ]
	
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr}  { $py_asurface_parts_local} "
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}
				
proc ::GA_Report::py_sunexposure_values_table { py_out_name  py_max_loading_disp_all  py_max_unloading_disp_all } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {d Loading (mm)} {d UnLoading (mm)}"
	set cell_value 0		


	set ::GA_Report::sunexp_all_loading_max $py_max_loading_disp_all
	set ::GA_Report::sunexp_all_unloading_max $py_max_unloading_disp_all

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $py_max_loading_disp_all} { $py_max_unloading_disp_all}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}				
	
proc ::GA_Report::py_sunexposure_assembly_values_table { py_out_name  py_max_loading_disp_all  py_max_unloading_disp_all py_min_loading_disp_all py_min_unloading_disp_all data_comp_contour } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {d Loading (mm)} {d UnLoading (mm)}"
	set cell_value 0		


	if { $py_max_loading_disp_all > $py_min_loading_disp_all } { 
		set maximum_loading_displacement $py_max_loading_disp_all

	} else {
		set maximum_loading_displacement $py_min_loading_disp_all
	
	}


	if { $py_max_unloading_disp_all > $py_min_unloading_disp_all } { 
		set maximum_unloading_displacement $py_max_unloading_disp_all

	} else {
		set maximum_unloading_displacement $py_min_unloading_disp_all
	}

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value
	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $maximum_loading_displacement} { $maximum_unloading_displacement}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}


proc ::GA_Report::py_sunexposure_parts_values_table { py_out_name  py_max_loading_disp_all  py_max_unloading_disp_all py_min_loading_disp_all py_min_unloading_disp_all data_comp_contour } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Description} {Target(mm)} {d Loading (mm)} {d UnLoading (mm)}"
	set cell_value 0		


	if { $py_max_loading_disp_all > $py_min_loading_disp_all } { 
	
		set maximum_loading_displacement $py_max_loading_disp_all

	} else {
	
		set maximum_loading_displacement $py_min_loading_disp_all
	
	}


	if { $py_max_unloading_disp_all > $py_min_unloading_disp_all } { 
	
		set maximum_unloading_displacement $py_max_unloading_disp_all

	} else {
	
		set maximum_unloading_displacement $py_min_unloading_disp_all
	
	}

	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{$::GA_Report::loc_num} {$::GA_Report::tool_descr} { $::GA_Report::load_limit} { $maximum_loading_displacement} { $maximum_unloading_displacement}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}
	
	
proc ::GA_Report::py_fdenergy_values_table { py_out_name  } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 7, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Mass of Tool} {Impact Velocity} {Target Limits} {RF @ Target} { E Absorbed @ Target} "
	set cell_value 0		


	set local_entry $py_out_name
	#append local_entry " "
	#append local_entry $py_stress_parts_local
	#lappend ::GA_Report::partwise_stress $local_entry
	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {val1} {val1} {val1}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}




}	

proc ::GA_Report::py_wr_master_page_values_table { py_out_name max_loading_disp_all } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Load} {Target Limits} {Displacement(mm)} "
	set cell_value 0		


	set local_entry $py_out_name
	
	set ::GA_Report::tool_max $max_loading_disp_all


	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {$max_loading_disp_all}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}


proc ::GA_Report::py_wr_master_page_2_values_table { py_out_name max_loading_disp_all } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 5, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Load} {Target Limits} {Displacement(mm)} "
	set cell_value 0		


	set local_entry $py_out_name
	
	set ::GA_Report::tool_max $max_loading_disp_all


	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {$max_loading_disp_all}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}	



proc ::GA_Report::py_wr_biw_page_values_table { py_out_name max_biw_disp max_biw_stress } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 6, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Load} {Target Limits(mm)} { BIW Displacement (mm)} { BIW Stress(MPa)}"
	set cell_value 0		


	set local_entry $py_out_name
	
	set ::GA_Report::tool_max 0


	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {$max_biw_disp} {$max_biw_stress}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}





proc ::GA_Report::py_wr_biw_page_2_values_table { py_out_name max_biw_tensile_stress max_biw_compressive_stress } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 6, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Load} {Target Limits(mm)} {Tensile Stress (MPa)} {Compressive Stress (MPa) } "
	set cell_value 0		


	set local_entry $py_out_name
	
	set ::GA_Report::tool_max 0


	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {$max_biw_tensile_stress} {$max_biw_compressive_stress}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0,0,0)"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

}

proc ::GA_Report::py_wr_parts_page_values_table { py_out_name max_part_tensile_stress max_part_compressive_stress } {

	set com_para {p = text_frame.paragraphs[0]}
	puts $::GA_Report::file_head "x, y, cx, cy = Inches(0.5), Inches(1.75), Inches(6), Inches(1.5)"
	puts $::GA_Report::file_head "shape = slide.shapes.add_table(2, 6, x,y, cx, cy)"
	puts $::GA_Report::file_head "table = shape.table"

	set heading_list [list]
	set heading_list "{Point} {Location} {Load} {Target Limits(mm)}  {Tensile Stress (MPa)} {Compressive Stress (MPa) }"
	set cell_value 0		


	set local_entry $py_out_name
	
	set ::GA_Report::tool_max 0


	foreach caption $heading_list {

		puts $::GA_Report::file_head "cell = table.cell(0, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}

	set values_list [list]
	set values_list "{val1} {val1} {val1} {val1} {$max_part_tensile_stress} {$max_part_compressive_stress}"
	set cell_value 0
	foreach caption $values_list {

		puts $::GA_Report::file_head "cell = table.cell(1, $cell_value)"
		puts $::GA_Report::file_head "text_frame = cell.text_frame"
		puts $::GA_Report::file_head $com_para
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.CENTER"
		puts $::GA_Report::file_head "run = p.add_run()"
		puts $::GA_Report::file_head "run.text = '$caption'"
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		incr cell_value

	}
}


# -------------------------------------------- PYTHON LIGHT FUNCTIONS ------------------------------------------------------------

proc ::GA_Report::py_traffic_light {  } {	

	puts $::GA_Report::file_head "left = Inches(16.4)"
	puts $::GA_Report::file_head "top = Inches(2.5)"
	puts $::GA_Report::file_head "height1 = Inches(0.9)"
	puts $::GA_Report::file_head "width1 = Inches(0.9)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,1,1)"
	puts $::GA_Report::file_head "left = Inches(16.55)"
	puts $::GA_Report::file_head "top = Inches(2.65)"
	puts $::GA_Report::file_head "height1 = Inches(0.6)"
	puts $::GA_Report::file_head "width1 = Inches(0.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.OVAL, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"

	if { $::GA_Report::tool_max < $::GA_Report::load_limit } { 
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,255,1)" 
		set ::GA_Report::observation1 "meets"
		set ::GA_Report::observation2 "less than"
	}
	if { $::GA_Report::tool_max > $::GA_Report::load_limit } { 
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(255,1,1)" 
		set ::GA_Report::observation1 "does not meet"
		set ::GA_Report::observation2 "more than"
	}

}


proc ::GA_Report::py_trimmax_traffic_light {  } {

	puts $::GA_Report::file_head "left = Inches(16.4)"
	puts $::GA_Report::file_head "top = Inches(2.5)"
	puts $::GA_Report::file_head "height1 = Inches(0.9)"
	puts $::GA_Report::file_head "width1 = Inches(0.9)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,1,1)"
	puts $::GA_Report::file_head "left = Inches(16.55)"
	puts $::GA_Report::file_head "top = Inches(2.65)"
	puts $::GA_Report::file_head "height1 = Inches(0.6)"
	puts $::GA_Report::file_head "width1 = Inches(0.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.OVAL, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"

	if { $::GA_Report::trim_max < $::GA_Report::load_limit } { 
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,255,1)" 
		set ::GA_Report::observation1 "meets"
		set ::GA_Report::observation2 "less than"
	}
	if { $::GA_Report::trim_max > $::GA_Report::load_limit } { 
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(255,1,1)" 
		set ::GA_Report::observation1 "does not meet"
		set ::GA_Report::observation2 "more than"
	}
}	


proc ::GA_Report::py_plain_traffic_light {  } {	

	puts $::GA_Report::file_head "left = Inches(16.4)"
	puts $::GA_Report::file_head "top = Inches(2.5)"
	puts $::GA_Report::file_head "height1 = Inches(0.9)"
	puts $::GA_Report::file_head "width1 = Inches(0.9)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,1,1)"
	puts $::GA_Report::file_head "left = Inches(16.55)"
	puts $::GA_Report::file_head "top = Inches(2.65)"
	puts $::GA_Report::file_head "height1 = Inches(0.6)"
	puts $::GA_Report::file_head "width1 = Inches(0.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.OVAL, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,255,1)"

}	
	

proc ::GA_Report::py_sunexposure_traffic_light {  } {	

	puts $::GA_Report::file_head "left = Inches(16.4)"
	puts $::GA_Report::file_head "top = Inches(2.5)"
	puts $::GA_Report::file_head "height1 = Inches(0.9)"
	puts $::GA_Report::file_head "width1 = Inches(0.9)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,1,1)"
	puts $::GA_Report::file_head "left = Inches(16.55)"
	puts $::GA_Report::file_head "top = Inches(2.65)"
	puts $::GA_Report::file_head "height1 = Inches(0.6)"
	puts $::GA_Report::file_head "width1 = Inches(0.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.OVAL, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"

   if { ($::GA_Report::sunexp_loading_status == "pass") && ($::GA_Report::sunexp_unloading_status == "pass") } { puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(1,255,1)" }
   if { ($::GA_Report::sunexp_loading_status == "fail") || ($::GA_Report::sunexp_unloading_status == "fail") } { puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(255,1,1)" }
   
}	
# -------------------------------------------- PYTHON SUMMARY FUNCTIONS ----------------------------------------------------------				
				
proc ::GA_Report::py_load_master_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Test point }
	set value "$::GA_Report::observation1"
	set end " the Target    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Displacement is }
	set value "$::GA_Report::observation2"
	set end " the Target    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Structure Permanent deformation is }
	set value "$::GA_Report::trim_perm$::GA_Report::length_unit"
	set end " .    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}
				
				

proc ::GA_Report::py_retainer_master_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}


	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum forces observed in connector are  }
	set value "_________"
	set end " limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Risk of breakage is  }
	set value "____________"
	set end " in the assembly"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"



}
				
				
				
proc ::GA_Report::py_localimpact_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.9)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum strain observed in part are  }
	set value "_________"
	set end " limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Risk of breakage is  }
	set value "____________"
	set end " in the assembly"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}		
				
proc ::GA_Report::py_partwise_stress_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum stress observed in part are  }
	
	set value "_________"
	set end " Yield limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum stress observed in part are   }
	set value "____________"
	set end "  the Ultimate Stress Values"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}		
				
				
proc ::GA_Report::py_partwise_strain_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum strain observed in part are  }
	set value "_________"
	set end "  than Breakage limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	


}
				
proc ::GA_Report::py_asurface_strain_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum strain observed in A-Surface are  }
	set value "_________"
	set end "  than the limit to produce Breakage"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

}
				
				
proc ::GA_Report::py_sunexposure_summary { max_loading_disp_all  max_unloading_disp_all } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	
	if { $max_loading_disp_all < 3 } { 
		set load_finding " which is less than Target" 
		set ::GA_Report::sunexp_loading_status "pass"
	}
	if { $max_loading_disp_all > 3 } { 
	set load_finding " which is more than Target" 
	set ::GA_Report::sunexp_loading_status "fail"
	
	}
	if { $max_unloading_disp_all < 1 } { 
		set unload_finding " which is less than Target" 
		set ::GA_Report::sunexp_unloading_status "pass"
	
	}
	if { $max_unloading_disp_all > 1 } { 
		set unload_finding " which is more than Target" 
		set ::GA_Report::sunexp_unloading_status "fail"
	}
	
	
	
	set begin {run.text = 'Maximum Displacement observed during loading is  }
	set value "$max_loading_disp_all"
	set end " $load_finding    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Displacement observed during unloading is   }
	set value "$max_unloading_disp_all"
	set end "  $unload_finding"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}		


proc ::GA_Report::py_sunexposure_assembly_summary { max_loading_disp_all  max_unloading_disp_all min_loading_disp_all min_unloading_disp_all } {

	if { $max_loading_disp_all > $min_loading_disp_all } { 
	
		set maximum_loading_displacement $max_loading_disp_all

	} else {
	
		set maximum_loading_displacement $min_loading_disp_all
	
	}


	if { $max_unloading_disp_all > $min_unloading_disp_all } { 
	
		set maximum_unloading_displacement $max_unloading_disp_all

	} else {
	
		set maximum_unloading_displacement $min_unloading_disp_all
	
	}

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	
	if { $maximum_loading_displacement < 3 } { 
		set load_finding " which is less than Target" 
		set ::GA_Report::sunexp_loading_status "pass"
	}
	if { $maximum_loading_displacement > 3 } { 
		set load_finding " which is more than Target" 
		set ::GA_Report::sunexp_loading_status "fail"
	
	}
	if { $maximum_unloading_displacement < 1 } { 
		set unload_finding " which is less than Target" 
		set ::GA_Report::sunexp_unloading_status "pass"
		
	}
	if { $maximum_unloading_displacement > 1 } { 
		set unload_finding " which is more than Target" 
		set ::GA_Report::sunexp_unloading_status "fail"
	}
	
	
	
	set begin {run.text = 'Maximum Displacement observed during loading is  }
	set value "$maximum_loading_displacement"
	set end " $load_finding    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Displacement observed during unloading is   }
	set value "$maximum_unloading_displacement"
	set end "  $unload_finding"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"

}


proc ::GA_Report::py_sunexposure_parts_summary { max_loading_disp_all  max_unloading_disp_all min_loading_disp_all min_unloading_disp_all } {



	if { $max_loading_disp_all > $min_loading_disp_all } { 
		set maximum_loading_displacement $max_loading_disp_all
	} else {
		set maximum_loading_displacement $min_loading_disp_all
	
	}

	if { $max_unloading_disp_all > $min_unloading_disp_all } { 
		set maximum_unloading_displacement $max_unloading_disp_all

	} else {
		set maximum_unloading_displacement $min_unloading_disp_all
	
	}

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	
	if { $maximum_loading_displacement < 3 } { 
		set load_finding " which is less than Target" 
		set ::GA_Report::sunexp_loading_status "pass"
	}
	if { $maximum_loading_displacement > 3 } { 
		set load_finding " which is more than Target" 
		set ::GA_Report::sunexp_loading_status "fail"
	
	}
	if { $maximum_unloading_displacement < 1 } { 
		set unload_finding " which is less than Target" 
		set ::GA_Report::sunexp_unloading_status "pass"
	
	}
	if { $maximum_unloading_displacement > 1 } { 
		set unload_finding " which is more than Target" 
		set ::GA_Report::sunexp_unloading_status "fail"
	}
	
	set begin {run.text = 'Maximum Displacement observed during loading is  }
	set value "$maximum_loading_displacement"
	set end " $load_finding    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Displacement observed during unloading is   }
	set value "$maximum_unloading_displacement"
	set end "  $unload_finding"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}


proc ::GA_Report::py_fdenergy_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Test point }
	set value "$::GA_Report::observation1"
	set end " the Target    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Displacement is }
	set value "$::GA_Report::observation2"
	set end " the Target    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Structure Permanent deformation is }
	set value "$::GA_Report::trim_perm$::GA_Report::length_unit"
	set end " .    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"


}	

proc ::GA_Report::py_wr_master_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Displacement observed in assembly is  }
	set value "_________"
	set end "  than Target limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

}	



proc ::GA_Report::py_wr_biw_summary {  } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Stress observed in BIW is  }
	set value "_________"
	set end "  than Target limit    "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"
	
}	

proc ::GA_Report::py_wr_parts_summary { max_part_tensile_stress max_part_compressive_stress } {

	puts $::GA_Report::file_head "left = Inches(6.5)"
	puts $::GA_Report::file_head "top = Inches(1.75)"
	puts $::GA_Report::file_head "height1 = Inches(1.48)"
	puts $::GA_Report::file_head "width1 = Inches(6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	#set text_string {run.text = 'Observations \n'}

	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Tesile Stress observed in part is  }
	set value "$max_part_tensile_stress"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Maximum Compressive Stress observed in part is  }
	set value "$max_part_compressive_stress"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"

}
				
# -------------------------------------------- PYTHON PROPOSALS FUNCTIONS --------------------------------------------------------				
				

proc ::GA_Report::py_load_master_proposals {  } {


	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(6.5)"
	puts $::GA_Report::file_head "height1 = Inches(2.4)"
	puts $::GA_Report::file_head "width1 = Inches(4.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set text_string {run.text = ' Proposals \n'}

	puts $::GA_Report::file_head $text_string
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.22)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"
	puts $::GA_Report::file_head "run.text = ' 1) .......'"
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"


}	
				
				
				

proc ::GA_Report::py_general_master_proposals {  } {


	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(6.5)"
	puts $::GA_Report::file_head "height1 = Inches(2.4)"
	puts $::GA_Report::file_head "width1 = Inches(4.6)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set text_string {run.text = ' Proposals \n'}

	puts $::GA_Report::file_head $text_string
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.22)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"
	puts $::GA_Report::file_head "run.text = ' 1) .......'"
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"



}	
				
# -------------------------------------------- STRESS,STRAIN,A-SURFACE BOXES  ----------------------------------------------------
proc ::GA_Report::py_local_impact_boxes { strain_local_impact_breakage } {

	set mat_grill "_GRILL_MAT"
	
	puts $::GA_Report::file_head "left = Inches(3.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Material - MATXX }
	set value "$mat_grill"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set strain_local_impact_breakage [ expr { $strain_local_impact_breakage * 100 }]

	set begin {run.text = 'Breakage strain of  - }
	set value "$strain_local_impact_breakage"
	set end "%"
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"


	  

}
				
				
proc ::GA_Report::py_stress_parts_boxes { stress_parts_yield_local stress_parts_ultimate_local material_name_note } {

                    
	puts $::GA_Report::file_head "left = Inches(3.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = '\nMaterial - }
	set value "$material_name_note"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Yield Stress - }
	set value "$stress_parts_yield_local$::GA_Report::stress_unit"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"






	puts $::GA_Report::file_head "left = Inches(9.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = '\nMaterial - }
	set value "$material_name_note"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Ultimate Stress - }
	set value "$stress_parts_ultimate_local$::GA_Report::stress_unit"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"
	

	incr ::GA_Report::mat_counter  

}
				
proc ::GA_Report::py_strain_parts_boxes { strain_parts_ultimate_local material_name_note } {

                    
	puts $::GA_Report::file_head "left = Inches(9.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	
	

	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = '\nMaterial - }
	set value "$material_name_note"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Breaking limit - }
	set value "$strain_parts_ultimate_local"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	incr ::GA_Report::mat_counter  

}
				
proc ::GA_Report::py_asurface_parts_boxes {  strain_parts_ultimate_asurface } {

	puts $::GA_Report::file_head "left = Inches(9.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Material - MATXX }
	set value "$::GA_Report::mat_counter"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = 'Breakage Strain - }
	set value "$strain_parts_ultimate_asurface"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"
	

	incr ::GA_Report::mat_counter  

}
				
				
proc ::GA_Report::py_sunexposure_boxes { data_comp_contour } {

                    
	puts $::GA_Report::file_head "left = Inches(3.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text =  }
	set value "LOADING "
	set end "Result Type: $data_comp_contour'"
	set slash_N {'\n}
	set combined [concat $begin$slash_N$value$end]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

	puts $::GA_Report::file_head "left = Inches(9.5)"
	puts $::GA_Report::file_head "top = Inches(8.8)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(3.0)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(196,235,250)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text =  }
	set value "UNLOADING "
	set end "Result Type: $data_comp_contour' "
	set slash_N {'\n}
	set combined [concat $begin$slash_N$value$end]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.18)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"

}			


proc ::GA_Report::py_sunexposure_side_boxes { max_loading_disp_all  max_unloading_disp_all min_loading_disp_all min_unloading_disp_all data_comp_contour } {

	if { $data_comp_contour == "Z" } { 
		set direction_max "Top direction of the car is "
		set direction_min "Bottom direction of the car is "
	}
	if { $data_comp_contour == "Y" } { 
		set direction_max "Inside of the car is "
		set direction_min "Outside of the car is "
	
	}
	if { $data_comp_contour == "X" } { 
	
		set direction_max "Rear of the car is "
		set direction_min "Front of the car is "
	
	}
	
	
	
	if { $data_comp_contour == "Mag" } {
	
	
		puts $::GA_Report::file_head "left = Inches(12.8)"
		puts $::GA_Report::file_head "top = Inches(3.5)"
		puts $::GA_Report::file_head "height1 = Inches(2.3)"
		puts $::GA_Report::file_head "width1 = Inches(4.6)"
		puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
		puts $::GA_Report::file_head "shape1.fill.solid()"
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

		set com_string {p = text_frame1.paragraphs[0]}
		puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		
		set begin {run.text = 'Loading : Displacement during thermal load is  }
		set value " "
		set end "$max_loading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
		

		
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"

		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		set begin {run.text = 'Loading : Displacement during thermal unload is }
		set value " "
		set end "$max_unloading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
		
							
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"

	} else {
	
	
	
		puts $::GA_Report::file_head "left = Inches(12.8)"
		puts $::GA_Report::file_head "top = Inches(3.5)"
		puts $::GA_Report::file_head "height1 = Inches(2.3)"
		puts $::GA_Report::file_head "width1 = Inches(4.6)"
		puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
		puts $::GA_Report::file_head "shape1.fill.solid()"
		puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

		set com_string {p = text_frame1.paragraphs[0]}
		puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		
		set begin {run.text = 'Loading : Displacement towards }
		set value "$direction_max"
		set end "$max_loading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
	

	
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"

		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		set begin {run.text = 'Loading : Displacement towards }
		set value "$direction_min"
		set end "$min_loading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
	
						
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"

		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		set begin {run.text = 'Unloading : Displacement towards }
		set value "$direction_max"
		set end "$max_unloading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
	
						
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"
		
		puts $::GA_Report::file_head $com_string
		puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
		puts $::GA_Report::file_head "p.level = 1"
		puts $::GA_Report::file_head "run = p.add_run()"
		
		set begin {run.text = 'Unloading : Displacement towards }
		set value "$direction_min"
		set end "$min_unloading_disp_all mm"
		set slash_N {\n'}
		set combined [concat $begin$value$end$slash_N]
		puts $::GA_Report::file_head $combined
		
							
		puts $::GA_Report::file_head "font = run.font"
		puts $::GA_Report::file_head "font.name = 'Calibri'"
		puts $::GA_Report::file_head "font.size = Inches(0.18)"
		puts $::GA_Report::file_head "font.bold = True"
		puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
		puts $::GA_Report::file_head "font.italic = False"



	}

}				
				
# -------------------------------------------- PYTHON BIW BOX , CONFID , ANIMBOX, TOP IMAGE  -------------------------------------

proc ::GA_Report::py_load_master_biw_boxes {  } {

	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(5.9)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = ' BIW deformation is }
	set value "$::GA_Report::biw_max"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"


	puts $::GA_Report::file_head "left = Inches(15.1)"
	puts $::GA_Report::file_head "top = Inches(5.9)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = ' Trim Permanent deformation is }
	set value "$::GA_Report::trim_perm"
	set end " "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"



}

proc ::GA_Report::py_sunexposure_general_box {  } {

	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(5.9)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = ' Loading Limit is }
	set value " "
	set end "3mm "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined

	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"


	puts $::GA_Report::file_head "left = Inches(15.1)"
	puts $::GA_Report::file_head "top = Inches(5.9)"
	puts $::GA_Report::file_head "height1 = Inches(0.5)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(204,207,218)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"

	set begin {run.text = ' Unloading Limit is }
	set value " "
	set end "1mm "
	set slash_N {\n'}
	set combined [concat $begin$value$end$slash_N]
	puts $::GA_Report::file_head $combined


	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(0x00, 0x00, 0x00)"
	puts $::GA_Report::file_head "font.italic = False"



}               

proc ::GA_Report::py_confidential {  } {

	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(9.0)"
	puts $::GA_Report::file_head "height1 = Inches(0.3)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(0,32,96)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"
	
	set text_string {run.text = 'CONFIDENTIAL'}

	puts $::GA_Report::file_head $text_string
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.15)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(255, 255, 255)"
	puts $::GA_Report::file_head "font.italic = False"
	

}
				
				

proc ::GA_Report::py_animation_indicator {  } {

	puts $::GA_Report::file_head "left = Inches(15.1)"
	puts $::GA_Report::file_head "top = Inches(9.0)"
	puts $::GA_Report::file_head "height1 = Inches(0.3)"
	puts $::GA_Report::file_head "width1 = Inches(2.3)"
	puts $::GA_Report::file_head "shape1 = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left,top, height = height1,width=width1)"
	puts $::GA_Report::file_head "shape1.fill.solid()"
	puts $::GA_Report::file_head "shape1.fill.fore_color.rgb = RGBColor(21,69,138)"

	set com_string {p = text_frame1.paragraphs[0]}
	puts $::GA_Report::file_head "text_frame1 = shape1.text_frame"
	puts $::GA_Report::file_head $com_string
	puts $::GA_Report::file_head "p.alignment = PP_ALIGN.LEFT"
	puts $::GA_Report::file_head "p.level = 1"
	puts $::GA_Report::file_head "run = p.add_run()"
	
	set text_string {run.text = 'VIDEO IN PAGE'}

	puts $::GA_Report::file_head $text_string
	puts $::GA_Report::file_head "font = run.font"
	puts $::GA_Report::file_head "font.name = 'Calibri'"
	puts $::GA_Report::file_head "font.size = Inches(0.17)"
	puts $::GA_Report::file_head "font.bold = True"
	puts $::GA_Report::file_head "font.color.rgb = RGBColor(255,255,255)"
	puts $::GA_Report::file_head "font.italic = False"
	

}








proc ::GA_Report::py_top_image { out_name_image } {

	set slash_110 "/"
	set dir_name_for_image $::GA_Report::dir_for_parts_list
	set image_last "_topimage_window_1.jpeg"
	set top_image_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$out_name_image$slash_110$out_name_image$image_last"
	puts " top image add path is $top_image_path"
		
		
	set top_image_path [regsub -all {/} $top_image_path {\\\\}]
	puts $::GA_Report::file_head "img_path = '$top_image_path'"
	puts $::GA_Report::file_head "left = Inches(12.8)"
	puts $::GA_Report::file_head "top = Inches(0.1)"
	puts $::GA_Report::file_head "height = Inches(3.3)"
	puts $::GA_Report::file_head "width = Inches(3.3)"
	puts $::GA_Report::file_head "pic = slide.shapes.add_picture(img_path, left,top, height = height,width=width)"
	puts $::GA_Report::file_head "line = pic.line"
	puts $::GA_Report::file_head "line.color.rgb = RGBColor(0x00, 0x00, 0x00)"

}
				
				

proc ::GA_Report::top_image_optional_to_do { } {

	if {![info exists ::GA_Report::top_image_file_list]} {
		tk_messageBox -message "Please execute the tool" -icon error
		return
	}	

	 if { $::GA_Report::tool_element_id == "" } { set ::GA_Report::tool_element_id 10001 }
	 
	#.mytoplevel.a.c.labelFrame002.rbe62 configure -background green
	set ::GA_Report::top_image_final_list [list]       
	
	foreach top_image_item $::GA_Report::top_image_file_list {

		set page_num_current [lindex $top_image_item 0]
		set op_file_cur_extension [lindex $top_image_item 1]
		set op_file_cur [ string trim $op_file_cur_extension "$::GA_Report::solver_extension" ]
		
		if { $::GA_Report::c3var == "PamCrash" } {
			set op_file_cur [ string map {".erfh5" ""} $op_file_cur_extension ]

		}
		
		set win_counter 1
		set i 0
		set k 1
		set biw_dir_name_to_read $::GA_Report::dir_for_parts_list
		set biw_formatcsv200 ".csv"
		set biw_slash_200 "/"
		set solver_choice $::GA_Report::c3var
		
		if { $::GA_Report::c3var == "LsDyna" } {
			set cut_string {d3plot} 
			set cut_slash {/}
			set op_file_cur_name_only [ string trim $op_file_cur "$cut_string" ]
			set op_file_cur_name_only [ string trim $op_file_cur_name_only "$cut_slash" ]
			set op_file_cur $op_file_cur_name_only
			#set op_file_cur [ string map {"d3plot" "$op_file_cur_name_only"} $op_file_cur ]
		}
		
		if { $::GA_Report::top_image_counter > 20 } {
		
			master_project SetActivePage $page_num_current
		
		}
		
		if { $::GA_Report::top_image_counter < 20 } {
		
			set biw_read_parts_path "$biw_dir_name_to_read$biw_slash_200$::GA_Report::data_folder$biw_slash_200$op_file_cur$biw_formatcsv200"

			set biw_only_comps_id [list]
			set biw_only_comps_name [list]

			set file_all_comps [open $biw_read_parts_path]
			set filevalues_all_comps [read $file_all_comps ]
			set all_comp_length [ llength $filevalues_all_comps ]
			set end_length [ expr { $all_comp_length * 2}]

			master_project SetActivePage $page_num_current
			

			master_project GetPageHandle page_handle$op_file_cur$page_num_current $page_num_current
			page_handle$op_file_cur$page_num_current SetLayout 1
			page_handle$op_file_cur$page_num_current SetActiveWindow 1
			page_handle$op_file_cur$page_num_current GetWindowHandle win_of$page_num_current$win_counter $win_counter
			win_of$page_num_current$win_counter GetClientHandle anim_handle_$page_num_current$win_counter
			anim_handle_$page_num_current$win_counter GetModelHandle model_handle_$page_num_current$win_counter 1
			model_handle_$page_num_current$win_counter GetResultCtrlHandle result_control_handle_$page_num_current$win_counter
			result_control_handle_$page_num_current$win_counter GetContourCtrlHandle contour_handle_$page_num_current$win_counter


			set selection_set_id_impactor [ model_handle_$page_num_current$win_counter AddSelectionSet element]
			model_handle_$page_num_current$win_counter GetSelectionSetHandle selection_handle_impactor_$page_num_current$win_counter $selection_set_id_impactor
			selection_handle_impactor_$page_num_current$win_counter SetVisibility true
			selection_handle_impactor_$page_num_current$win_counter SetSelectMode displayed
			selection_handle_impactor_$page_num_current$win_counter Add "id $::GA_Report::tool_element_id"
			#selection_handle_impactor_$page_num_current$win_counter Add "Attached"
			#selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 1"
			#selection_handle_impactor_$page_num_current$win_counter Subtract "dimension 0"
			set impactor_attached_list [ selection_handle_impactor_$page_num_current$win_counter GetList]


			model_handle_$page_num_current$win_counter GetQueryCtrlHandle query_handle_$page_num_current$win_counter
			query_handle_$page_num_current$win_counter SetSelectionSet [ selection_handle_impactor_$page_num_current$win_counter  GetID ]
			query_handle_$page_num_current$win_counter SetDataSourceProperty result datatype Displacement;
			query_handle_$page_num_current$win_counter SetQuery "component.id"


			query_handle_$page_num_current$win_counter GetIteratorHandle iterator_handle_$page_num_current$win_counter
			set comp_id_value [ iterator_handle_$page_num_current$win_counter GetDataList]
			
			
			selection_handle_impactor_$page_num_current$win_counter Subtract "id $::GA_Report::tool_element_id"
			selection_handle_impactor_$page_num_current$win_counter Add "dimension 1"
			selection_handle_impactor_$page_num_current$win_counter Add "dimension 0"
			model_handle_$page_num_current$win_counter Mask [selection_handle_impactor_$page_num_current$win_counter GetID]
			selection_handle_impactor_$page_num_current$win_counter Clear
		
			puts $comp_id_value
			puts "all comp length $all_comp_length "
			#set all_comp_length [ expr { $all_comp_length / 2 } ]

			while { $i < $all_comp_length } {

				set biw_each_line [ lindex $filevalues_all_comps  $i ]
				set biw_each_lineid [ lindex $filevalues_all_comps  $k ]
				set biw_each_line_split [ split $biw_each_line  , ]
				set biw_each_lineid_split [ split $biw_each_lineid  , ]

				set comp_name_check [lindex $biw_each_line_split 0]
				set comp_id_check [lindex $biw_each_lineid_split 0]

				if { $comp_id_value == $comp_id_check } {
				
					set comp_id_check100 [ expr { $comp_id_check * 100 }]
						set page_num_current100  [ expr { $page_num_current * 100 }]
						model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current100$win_counter$comp_id_check100 $comp_id_check 
						part_handle_$page_num_current100$win_counter$comp_id_check100 SetColor Red
						puts " id found $comp_id_check $op_file_cur"

					} else {
				
						if { $comp_id_check > 0 } {
						set page_num_current100  [ expr { $page_num_current * 100 }]
						set comp_id_check100 [ expr { $comp_id_check * 100 }]
						model_handle_$page_num_current$win_counter GetPartHandle part_handle_$page_num_current100$win_counter$comp_id_check100 $comp_id_check 
						part_handle_$page_num_current100$win_counter$comp_id_check100 SetColor "191 191 191"
					
						}
				}

				incr i 2
				incr k 2
			}

			close $file_all_comps

			#part_handle_$page_num_current$win_counter$comp_id_check100 ReleaseHandle;
			
			
			model_handle_$page_num_current$win_counter SetMeshMode features
			anim_handle_$page_num_current$win_counter Draw
			win_of$page_num_current$win_counter GetViewControlHandle fit_control_$page_num_current$win_counter
			fit_control_$page_num_current$win_counter Fit

			
			anim_handle_$page_num_current$win_counter GetNoteHandle note_handle_$page_num_current$win_counter 1
			note_handle_$page_num_current$win_counter SetVisibility False

			hwc result scalar clear
			puts " result scalar cleared"
			anim_handle_$page_num_current$win_counter Draw

			set output_split [split $op_file_cur _]
			set side_code [ lindex $output_split 5]

			if { $side_code == "LH" } {  set side_val "right" }
			if { $side_code == "RH" } {  set side_val "left" }
			if { $side_code == "FT" } {  set side_val "back" }
			if { $side_code == "BK" } {  set side_val "front" }
			
			if { $side_code == "TP" } {  set side_val "bottom" }
			if { $side_code == "BT" } {  set side_val "top" }
			if { $side_code == "CT" } {  set side_val "back" }
			

			if { $::GA_Report::top_image_counter < 20 } {
				fit_control_$page_num_current$win_counter SetOrientation $side_val

			}
		}


		set slash_110 "/"
		set dir_name_for_image $::GA_Report::dir_for_parts_list
		puts " dir for parts list is $::GA_Report::dir_for_parts_list"

		set s1 $top_image_item 
		set res_file_name [ string trim $s1 "$::GA_Report::solver_extension" ]
		
		if { $::GA_Report::c3var == "PamCrash" } {
			set res_file_name [ string map {".erfh5" ""} $s1 ]

		}
		
		set img_folder_path "$dir_name_for_image$slash_110$::GA_Report::data_folder$slash_110$op_file_cur$slash_110"

		set w1 "_window_1"

		set win1 1

		set anim_ext ".gif"
		set img_ext ".jpeg"
		set us "_"
		set page_type_img "topimage"


		

		set window_top_image $img_folder_path$op_file_cur$us$page_type_img$w1$img_ext
		puts "image folder is $window_top_image"

		master_session CaptureWindow 0 JPEG $window_top_image percent 100 100

		set top_item $op_file_cur
		append top_item " "
		append top_item $window_top_image
		
		
		lappend ::GA_Report::top_image_final_list $top_item
	}
	set ::GA_Report::top_image_counter 100
	
	.mytoplevel.a.c.labelFrame002.rbe62 configure -background green

}

# -------------------------------------------- RESULTS ALL SUMMARY  ----------------------------------------------------------



# -------------------------------------------- PYTHON EXECUTE AND LOGS FUNCTION  ----------------------------------------------------------	

proc ::GA_Report::py_save_execute {  } {

	puts $::GA_Report::file_head "print('Report Generator Version 2 - 03-2023')"
	puts $::GA_Report::file_head "print('CAE report will be printed at C-Report folder once you press enter.')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "print('If CAE report is not updated ,Please double click on the report_01 python file')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "print('1 - System will throw an error if CAE-Report is already open, In Such case - Just double click the python file after you close the file')"
	puts $::GA_Report::file_head "print('2 - If there Are NA values on plots , Update the plots to show values ,Then you might have to click the python file again')"
	puts $::GA_Report::file_head "print('3 - If you have re-generated top Image files , There is no need to generate report again ,Just click the python file')"
	puts $::GA_Report::file_head "print('4 - You Can Re-Publish Report any number of times')"
	puts $::GA_Report::file_head "print('5 - When you have to replace just an image - Its easier if you replace just the image from Hyperview and double click the python file')"
	puts $::GA_Report::file_head "print('6 - d3plot is a binary file , if you have a Cprd3plot file - Please rename it to d3plot')"
	puts $::GA_Report::file_head "print('7 - A source code error pops up generally when automation does not find something - Please check master node , contact name , inputs etc')"
	puts $::GA_Report::file_head "print('8 - Use with Altair 2021.2 or 2021.1 with windows 10 ,Please have enough RAM , Disk space and a decent GPU that supports OpenGL')"
	puts $::GA_Report::file_head "print('9 - Please update part code and load code files to support arbitary namings')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "print('If you Run into errors Please contact GA automation department')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "print('Logs are printed at C-report-logs folder - Please send the logs to GA every month - Please sort by created date to find logs of each month')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "print('The Automation creats formats that are Standard and approved by GA , For Deviations please get approval from HQ')"
	puts $::GA_Report::file_head "print('--------------------------------------------------------------------------------------------------------------------------------------------')"
	puts $::GA_Report::file_head "wait = input('Press Enter to continue.')"
	set slash_110 "/"
	set output_report_name "CAE_REPORT.pptx"
	set output_path $::GA_Report::report_folder_path$slash_110$output_report_name
	set output_path [regsub -all {/} $output_path {\\\\}]
	
	puts $::GA_Report::file_head "prs.save('$output_path')"
	close $::GA_Report::file_head
	set curr_dir [pwd]

	set pathis [regsub -all {/} $::GA_Report::report_folder_path "\\"] 

	#set pathis [regsub -all {/} $::GA_Report::report_folder_path "\\"]
	exec cmd.exe /c "$pathis/report_01.py"
	puts "Report generation completed."
	set ::GA_Report::publish_end_time [clock seconds]
	
	::GA_Report::log_files_write
	
	# unsetiing and setting again the summary list for republish
	
	if { $::GA_Report::cbState(empty1) == 1} { 
	
		set MASTER_SUMMARY "LOADS_MASTER_SUMMARY"
		set formatcsv ".csv"
		set dirName $::GA_Report::dir_for_parts_list$slash_110$::GA_Report::data_folder
		#set dirName $::GA_Report::dir_for_parts_list
		set fileName [file join "$dirName" "$MASTER_SUMMARY$formatcsv"]
		set summary_file [open "$fileName" w]
	
		foreach list_val $::GA_Report::load_master_list { 	puts $summary_file $list_val 		}
		close $summary_file;
	
		unset ::GA_Report::load_master_list
		set ::GA_Report::load_master_list [list]
		set line1 "LOC_NUM ,FILE_NAME ,TEMP, AREA ,LOAD , TOOL, FORCE, LIMIT, X ,Y ,Z, TOOL_MAX ,TRIM_MAX ,PERM_TRIM ,BIW_MAX" 
		lappend ::GA_Report::load_master_list $line1

	} 

	if { $::GA_Report::cbState(empty2) == 1} { 
	
		set MASTER_SUMMARY "IMPACT_MASTER_SUMMARY"
		set formatcsv ".csv"
		set dirName $::GA_Report::dir_for_parts_list
		set fileName [file join "$dirName" "$MASTER_SUMMARY$formatcsv"]
		set summary_file [open "$fileName" w]
	
		foreach list_val $::GA_Report::impact_master_list { 	puts $summary_file $list_val 		}
		close $summary_file;
	
		unset ::GA_Report::impact_master_list
		set ::GA_Report::impact_master_list [list]
		set line1 "LOC_NUM ,FILE_NAME ,TEMP, AREA, LOAD , TOOL ,FORCE ,LIMIT, X ,Y ,Z ,TRIM_MAX ,PERM_TRIM ,BIW_MAX" 
		lappend ::GA_Report::impact_master_list $line1

	}

	if { $::GA_Report::cbState(empty11) == 1} { 
	
		set MASTER_SUMMARY "SUN_EXPOSURE_MASTER_SUMMARY"
		set formatcsv ".csv"
		set dirName $::GA_Report::dir_for_parts_list
		set fileName [file join "$dirName" "$MASTER_SUMMARY$formatcsv"]
		set summary_file [open "$fileName" w]
	
	
		set line1 "FILENAME, AREA , LOAD_CASE_DESCRIPTION , LOADING_TARGET , UNLOADING_TARGET ,LOADING_DISPLACEMENT ,UNLOADING_DISPLACEMENT,LOADING_MAX_DIRECTION,UNOADING_MAX_DIRECTION,DIRECTION,"
		puts $summary_file $line1 
		
		foreach list_val $::GA_Report::sunexposure_master_list { 	puts $summary_file $list_val 		}
		close $summary_file;
	
		unset ::GA_Report::sunexposure_master_list
		
		set ::GA_Report::sunexposure_master_list [list]
		set line1 "FILENAME, AREA , LOAD_CASE_DESCRIPTION , LOADING_TARGET , UNLOADING_TARGET ,LOADING_DISPLACEMENT ,UNLOADING_DISPLACEMENT, LOADING_DISPLACEMENT_X , UNLOADING_DISPLACEMENT_X , LOADING_DISPLACEMENT_Y , UNLOADING_DISPLACEMENT_Y,LOADING_DISPLACEMENT_Z ,UNLOADING_DISPLACEMENT_Z" 
		lappend ::GA_Report::sunexposure_master_list $line1
	}

}

# -------------------------------------------- PYTHON EXECUTE AND LOGS FUNCTION  ----------------------------------------------------------
               
proc ::GA_Report::log_files_write {  } {
				
	if { $::GA_Report::supplier_name == ""} { 
		set ::GA_Report::supplier_name "internal"
	}
	#variable  $tcl_platform(user)
	#set userdata $tcl_platform(user)
	set userdata [ exec whoami]
	#set userdata [ whoami ]
	#set userdata  $env(USERNAME) 
	#set userdata "roopesh"
	
	set first_line $::GA_Report::supplier_name
	append first_line " "
	append first_line $userdata
	append first_line " "
	
	append first_line $::GA_Report::file_open_start_time
	append first_line " "
	append first_line $::GA_Report::file_open_finish_time 
	append first_line " "
	append first_line $::GA_Report::publish_start_time
	append first_line " "
	append first_line $::GA_Report::publish_end_time
	append first_line " "
				
	#puts "The time is: [clock format $systemTime -format %H:%M:%S]"
	
	lappend ::GA_Report::log_file_list $first_line
	foreach line $::GA_Report::page_list_loaded {
		lappend ::GA_Report::log_file_list $line
	}
	
	set log_name log_file_$::GA_Report::file_open_start_time 
	set formattext ".txt"

	if { $::GA_Report::supplier_name == "internal" } {
		set dirName {\\punnscaddata01\PUN_CAE\2022\20_AUTOMATION_AI\LOGS}
		# just to test - need to change this 
		#set dirName {C:\\REPORT\LOGS} 
	} else {
		set dirName {C:\\REPORT\LOGS} 
		#set dirName  $::GA_Report::dir_for_parts_list
	}

	puts "dir name is $dirName"
	
	set fileName [file join "$dirName" "$log_name$formattext"]
	set log_file_head [open $fileName w+];
	
	
	foreach linevalue $::GA_Report::log_file_list {
		set coded_line [::GA_Report::encode $linevalue ]
		puts $log_file_head $coded_line
	
	}
		
	close $log_file_head
				
}

proc ::GA_Report::ping_dax_server {  } {			
	#set user [whoami]
	#set systemTime [clock seconds]
	#puts "The time is: [clock format $systemTime -format %H:%M:%S]"			
}
				
proc ::GA_Report::to_ascii {char} {
	 #
	set value 0
	scan $char %c value
	return $value

}

proc ::GA_Report::encode {str} {
							
	set enc_string "password"
	set enc_idx 0
	set crypt_str ""
	for {set i 0} {$i < [string length $str]} {incr i 1} {

		set curnum [expr {[to_ascii [string index $str $i]] + [::GA_Report::to_ascii [string index $enc_string $enc_idx]]}]
		if {$curnum > 255} {
			set curnum [expr {$curnum - 256}]
		}
		set crypt_char [format %c $curnum]
		set crypt_str "$crypt_str$crypt_char"
		set enc_idx [incr enc_idx 1]
		if {$enc_idx == [string length $enc_string]} {
			set enc_idx 0
		}
	
	}
		
	return $crypt_str

}

proc ::GA_Report::decode {str} {
								
	set enc_string "password"
	set enc_idx 0
	set crypt_str ""
	set strlen [string length $str]
		if {$strlen == 0} {return}
		for {set testx 0} {$testx < $strlen} {incr testx 1} {
			set curnum [expr {[to_ascii [string index $str $testx]]-[::GA_Report::to_ascii [string index $enc_string $enc_idx]]}]
				if {$curnum < 0} {set curnum [expr {$curnum + 256}]}
			set crypt_str "$crypt_str[format %c $curnum]"
			set enc_idx [incr enc_idx 1]
				if {$enc_idx == [string length $enc_string]} {set enc_idx 0}
			}
	return $crypt_str
}
				
proc ::GA_Report::Help_open { } {
							
	# set report_dir $::GA_Report::report_folder_path
	# set slash "\\"

	# set helpDocName {C:\\REPORT\\REPORT_AUTOMATION_USER_MANUAL.pdf}
	# #set helpDocPath "$::GA_Report::report_folder_path$slash$helpDocName"

	# #exec cmd.exe /c "$helpDocPath"
	# #eval exec [auto_execok start \"\" [list $helpDocPath]	]
	# eval exec [auto_execok start] $helpDocName	
	
	#set helpDoc [file join [file dirname [info script]] REPORT_AUTOMATION_USER_MANUAL_V_1_0.pdf];
	if {[file exists $::GA_Report::helpDoc]} {
		eval exec [auto_execok start] $::GA_Report::helpDoc
	} else {
		tk_messageBox -message "Report Automation help does not exists in installation directory.\
		Kindly confirm and try launching help" -icon info
	}
}				
				
# -------------------------------------------- PYTHON STYLE CODE  ----------------------------------------------------------------

proc ::GA_Report::table_style_data {  } {

	tbl =  shape._element.graphic.graphicData.tbl
	style_id = '{1FECB4D8-DB02-4DC6-A0A2-4F2EBAE1DC90}'
	tbl[0][-1].text = style_id

	NoStyleNoGrid = '{2D5ABB26-0587-4C30-8999-92F81FD0307C}'
	ThemedStyle1Accent1 = '{3C2FFA5D-87B4-456A-9821-1D50468CF0F}'
	ThemedStyle1Accent2 = '{284E427A-3D55-4303-BF80-6455036E1DE7}'
	ThemedStyle1Accent3 = '{69C7853C-536D-4A76-A0AE-DD22124D55A5}'
	ThemedStyle1Accent4 = '{775DCB02-9BB8-47FD-8907-85C794F793BA}'
	ThemedStyle1Accent5 = '{35758FB7-9AC5-4552-8A53-C91805E547FA}'
	ThemedStyle1Accent6 = '{08FB837D-C827-4EFA-A057-4D05807E0F7C}'
	NoStyleTableGrid = '{5940675A-B579-460E-94D1-54222C63F5DA}'
	ThemedStyle2Accent1 = '{D113A9D2-9D6B-4929-AA2D-F23B5EE8CBE7}'
	ThemedStyle2Accent2 = '{18603FDC-E32A-4AB5-989C-0864C3EAD2B8}'
	ThemedStyle2Accent3 = '{306799F8-075E-4A3A-A7F6-7FBC6576F1A4}'
	ThemedStyle2Accent4 = '{E269D01E-BC32-4049-B463-5C60D7B0CCD2}'
	ThemedStyle2Accent5 = '{327F97BB-C833-4FB7-BDE5-3F7075034690}'
	ThemedStyle2Accent6 = '{638B1855-1B75-4FBE-930C-398BA8C253C6}'
	LightStyle1 = '{9D7B26C5-4107-4FEC-AEDC-1716B250A1EF}'
	LightStyle1Accent1 = '{3B4B98B0-60AC-42C2-AFA5-B58CD77FA1E5}'
	LightStyle1Accent2 = '{0E3FDE45-AF77-4B5C-9715-49D594BDF05E}'
	LightStyle1Accent3 = '{C083E6E3-FA7D-4D7B-A595-EF9225AFEA82}'
	LightStyle1Accent4 = '{D27102A9-8310-4765-A935-A1911B00CA55}'
	LightStyle1Accent5 = '{5FD0F851-EC5A-4D38-B0AD-8093EC10F338}'
	LightStyle1Accent6 = '{68D230F3-CF80-4859-8CE7-A43EE81993B5}'
	LightStyle2 = '{7E9639D4-E3E2-4D34-9284-5A2195B3D0D7}'
	LightStyle2Accent1 = '{69012ECD-51FC-41F1-AA8D-1B2483CD663E}'
	LightStyle2Accent2 = '{72833802-FEF1-4C79-8D5D-14CF1EAF98D9}'
	LightStyle2Accent3 = '{F2DE63D5-997A-4646-A377-4702673A728D}'
	LightStyle2Accent4 = '{17292A2E-F333-43FB-9621-5CBBE7FDCDCB}'
	LightStyle2Accent5 = '{5A111915-BE36-4E01-A7E5-04B1672EAD32}'
	LightStyle2Accent6 = '{912C8C85-51F0-491E-9774-3900AFEF0FD7}'
	LightStyle3 = '{616DA210-FB5B-4158-B5E0-FEB733F419BA}'
	LightStyle3Accent1 = '{BC89EF96-8CEA-46FF-86C4-4CE0E7609802}'
	LightStyle3Accent2 = '{5DA37D80-6434-44D0-A028-1B22A696006F}'
	LightStyle3Accent3 = '{8799B23B-EC83-4686-B30A-512413B5E67A}'
	LightStyle3Accent4 = '{ED083AE6-46FA-4A59-8FB0-9F97EB10719F}'
	LightStyle3Accent5 = '{BDBED569-4797-4DF1-A0F4-6AAB3CD982D8}'
	LightStyle3Accent6 = '{E8B1032C-EA38-4F05-BA0D-38AFFFC7BED3}'
	MediumStyle1 = '{793D81CF-94F2-401A-BA57-92F5A7B2D0C5}'
	MediumStyle1Accent1 = '{B301B821-A1FF-4177-AEE7-76D212191A09}'
	MediumStyle1Accent2 = '{9DCAF9ED-07DC-4A11-8D7F-57B35C25682E}'
	MediumStyle1Accent3 = '{1FECB4D8-DB02-4DC6-A0A2-4F2EBAE1DC90}'
	MediumStyle1Accent4 = '{1E171933-4619-4E11-9A3F-F7608DF75F80}'
	MediumStyle1Accent5 = '{FABFCF23-3B69-468F-B69F-88F6DE6A72F2}'
	MediumStyle1Accent6 = '{10A1B5D5-9B99-4C35-A422-299274C87663}'
	MediumStyle2 = '{073A0DAA-6AF3-43AB-8588-CEC1D06C72B9}'
	MediumStyle2Accent1 = '{5C22544A-7EE6-4342-B048-85BDC9FD1C3A}'
	MediumStyle2Accent2 = '{21E4AEA4-8DFA-4A89-87EB-49C32662AFE0}'
	MediumStyle2Accent3 = '{F5AB1C69-6EDB-4FF4-983F-18BD219EF322}'
	MediumStyle2Accent4 = '{00A15C55-8517-42AA-B614-E9B94910E393}'
	MediumStyle2Accent5 = '{7DF18680-E054-41AD-8BC1-D1AEF772440D}'
	MediumStyle2Accent6 = '{93296810-A885-4BE3-A3E7-6D5BEEA58F35}'
	MediumStyle3 = '{8EC20E35-A176-4012-BC5E-935CFFF8708E}'
	MediumStyle3Accent1 = '{6E25E649-3F16-4E02-A733-19D2CDBF48F0}'
	MediumStyle3Accent2 = '{85BE263C-DBD7-4A20-BB59-AAB30ACAA65A}'
	MediumStyle3Accent3 = '{EB344D84-9AFB-497E-A393-DC336BA19D2E}'
	MediumStyle3Accent4 = '{EB9631B5-78F2-41C9-869B-9F39066F8104}'
	MediumStyle3Accent5 = '{74C1A8A3-306A-4EB7-A6B1-4F7E0EB9C5D6}'
	MediumStyle3Accent6 = '{2A488322-F2BA-4B5B-9748-0D474271808F}'
	MediumStyle4 = '{D7AC3CCA-C797-4891-BE02-D94E43425B78}'
	MediumStyle4Accent1 = '{69CF1AB2-1976-4502-BF36-3FF5EA218861}'
	MediumStyle4Accent2 = '{8A107856-5554-42FB-B03E-39F5DBC370BA}'
	MediumStyle4Accent3 = '{0505E3EF-67EA-436B-97B2-0124C06EBD24}'
	MediumStyle4Accent4 = '{C4B1156A-380E-4F78-BDF5-A606A8083BF9}'
	MediumStyle4Accent5 = '{22838BEF-8BB2-4498-84A7-C5851F593DF1}'
	MediumStyle4Accent6 = '{16D9F66E-5EB9-4882-86FB-DCBF35E3C3E4}'
	DarkStyle1 = '{E8034E78-7F5D-4C2E-B375-FC64B27BC917}'
	DarkStyle1Accent1 = '{125E5076-3810-47DD-B79F-674D7AD40C01}'
	DarkStyle1Accent2 = '{37CE84F3-28C3-443E-9E96-99CF82512B78}'
	DarkStyle1Accent3 = '{D03447BB-5D67-496B-8E87-E561075AD55C}'
	DarkStyle1Accent4 = '{E929F9F4-4A8F-4326-A1B4-22849713DDAB}'
	DarkStyle1Accent5 = '{8FD4443E-F989-4FC4-A0C8-D5A2AF1F390B}'
	DarkStyle1Accent6 = '{AF606853-7671-496A-8E4F-DF71F8EC918B}'
	DarkStyle2 = '{5202B0CA-FC54-4496-8BCA-5EF66A818D29}'
	DarkStyle2Accent1Accent2 = '{0660B408-B3CF-4A94-85FC-2B1E0A45F4A2}'
	DarkStyle2Accent3Accent4 = '{91EBBBCC-DAD2-459C-BE2E-F6DE35CF9A28}'
	DarkStyle2Accent5Accent6 = '{46F890A9-2807-4EBB-B81D-B2AA78EC7F39}'

}

# -------------------------------------------- GUI LOAD  -------------------------------------------------------------------------


proc ::GA_Report::cget {optionname} {
    return [configure $optionname]
}


proc ::GA_Report::configure {args} {
    variable options
    set r {}
    set cget 0

    if {[llength $args] < 1} {
        foreach opt [lsort [array names options]] {
            lappend r $opt $options($opt)
        }
        return $r
    }

    if {[llength $args] == 1} {
        set cget 1
    }

    while {[string match -* [set option [lindex $args 0]]]} {
        switch -glob -- $option {
            -port     { set r [SetOrGet -port $cget] }
            -timeout  { set r [SetOrGet -timeout $cget] }
            -protocol { set r [SetOrGet -protocol $cget] }
            -command  { set r [SetOrGet -command $cget] }
            -loglevel {
                if {$cget} {
                    return $options(-loglevel)
                } else {
                    set options(-loglevel) [Pop args 1]
                    #log::lvSuppressLE emergency 0
                   # log::lvSuppressLE $options(-loglevel) 1
                   # log::lvSuppress $options(-loglevel) 0
                }
            }
            --        { Pop args ; break }
            default {
                set err [join [lsort [array names options -*]] ", "]
                return -code error "bad option \"$option\": must be $err"
            }
        }
        Pop args
    }
    
    return $r
}


proc ::GA_Report::SetOrGet {option {cget 0}} {
    upvar options options
    upvar args args
    if {$cget} {
        return $options($option)
    } else {
        set options($option) [Pop args 1]
    }
    return {}
}



proc ::GA_Report::getsntp {args} {
    set token [eval [linsert $args 0 CommonSetup -port 123]]
    upvar #0 $token State
    set State(rfc) 2030
    return [QueryTime $token]
}

proc ::GA_Report::gettime {args} {
    set token [eval [linsert $args 0 CommonSetup -port 37]]
    upvar #0 $token State
    set State(rfc) 868
    return [QueryTime $token]
}

proc ::GA_Report::CommonSetup {args} {
    variable options
    variable uid
    set token [namespace current]::[incr uid]
    variable $token
    upvar 0 $token State

    array set State [array get options]
    set State(status) unconnected
    set State(data) {}
    
    while {[string match -* [set option [lindex $args 0]]]} {
        switch -glob -- $option {
            -port     { set State(-port) [Pop args 1] }
            -timeout  { set State(-timeout) [Pop args 1] }
            -proto*   { set State(-protocol) [Pop args 1] }
            -command  { set State(-command) [Pop args 1] }
            --        { Pop args ; break }
            default {
                set err [join [lsort [array names State -*]] ", "]
                return -code error "bad option \"$option\":\
                    must be $err."
            }
        }
        Pop args
    }

    set len [llength $args]
    if {$len < 1 || $len > 2} {
        if {[catch {info level -1} arg0]} {
            set arg0 [info level 0]
        }
        return -code error "wrong # args: should be\
              \"[lindex $arg0 0] ?options? timeserver ?port?\""
    }

    set State(-timeserver) [lindex $args 0]
    if {$len == 2} {
        set State(-port) [lindex $args 1]
    }

    return $token
}

proc ::GA_Report::QueryTime {token} {
    variable $token
    upvar 0 $token State

    if {[string equal $State(-protocol) "udp"]} {
        if {[llength [package provide ceptcl]] == 0 \
                && [llength [package provide udp]] == 0} {
            set State(status) error
            set State(error) "udp support is not available, \
                either ceptcl or tcludp required"
            return $token
        }
    }

    if {[catch {
        if {[string equal $State(-protocol) "udp"]} {
            if {[llength [package provide ceptcl]] > 0} {
                # using ceptcl
                set State(sock) [cep -type datagram \
                                     $State(-timeserver) $State(-port)]
                fconfigure $State(sock) -blocking 0
            } else {
                # using tcludp
                set State(sock) [udp_open]
                udp_conf $State(sock) $State(-timeserver) $State(-port)
            }
        } else {
            set State(sock) [socket $State(-timeserver) $State(-port)]
        }
    } sockerr]} {
        set State(status) error
        set State(error) $sockerr
        return $token
    }

    # setup the timeout
    if {$State(-timeout) > 0} {
        set State(after) [after $State(-timeout) \
                              [list [namespace origin reset] $token timeout]]
    }

    set State(status) connect
    fconfigure $State(sock) -translation binary -buffering none

    # SNTP wants a 48 byte request while TIME doesn't care and is happy
    # to accept any old rubbish. If protocol is TCP then merely connecting
    # is sufficient to elicit a response.
    if {[string equal $State(-protocol) "udp"]} {
        set len [expr {($State(rfc) == 2030) ? 47 : 3}]
        puts -nonewline $State(sock) \x0b[string repeat \0 $len]
    }

    fileevent $State(sock) readable \
        [list [namespace origin ClientReadEvent] $token]

    if {$State(-command) == {}} {
        wait $token
    }

    return $token
}

proc ::GA_Report::unixtime {{token {}}} {
    variable $token
    variable epoch
    upvar 0 $token State
    if {$State(status) != "ok"} {
        return -code error $State(error)
    }
    
    # SNTP returns 48+ bytes while TIME always returns 4.
    if {[string length $State(data)] == 4} {
        # RFC848 TIME
        if {[binary scan $State(data) I r] < 1} {
            return -code error "Unable to scan data"
        }
        return [expr {int($r - $epoch(unix))&0xffffffff}]
    } elseif {[string length $State(data)] > 47} {
        # SNTP TIME
        if {[binary scan $State(data) c40II -> sec frac] < 1} {
            return -code error "Failed to decode result"
        }
        return [expr {int($sec - $epoch(unix))&0xffffffff}]
    } else {
        return -code error "error: data format not recognised"
    }
}

proc ::GA_Report::status {token} {
    variable $token
    upvar 0 $token State
    return $State(status)
}

proc ::GA_Report::error {token} {
    variable $token
    upvar 0 $token State
    set r {}
    if {[info exists State(error)]} {
        set r $State(error)
    }
    return $r
}

proc ::GA_Report::wait {token} {
    variable $token
    upvar 0 $token State

    if {$State(status) == "connect"} {
        vwait [subst $token](status)
    }

    return $State(status)
}

proc ::GA_Report::reset {token {why reset}} {
    variable $token
    upvar 0 $token State
    set reason {}
    set State(status) $why
    catch {fileevent $State(sock) readable {}}
    if {$why == "timeout"} {
        set reason "timeout ocurred"
    }
    Finish $token $reason
}


proc ::GA_Report::cleanup {token} {
    variable $token
    upvar 0 $token State
    if {[info exists State]} {
        unset State
    }
}

proc ::GA_Report::ClientReadEvent {token} {
    variable $token
    upvar 0 $token State

    append State(data) [read $State(sock)]
    set expected [expr {($State(rfc) == 868) ? 4 : 48}]
    if {[string length $State(data)] < $expected} { return }

    #FIX ME: acquire peer data?

    set State(status) ok
    Finish $token
    return
}

proc ::GA_Report::Finish {token {errormsg {}}} {
    variable $token
    upvar 0 $token State
    global errorInfo errorCode

    if {[string length $errormsg] > 0} {
	set State(error) $errormsg
	set State(status) error
    }
    catch {close $State(sock)}
    catch {after cancel $State(after)}
    if {[info exists State(-command)] && $State(-command) != {}} {
        if {[catch {eval $State(-command) {$token}} err]} {
            if {[string length $errormsg] == 0} {
                set State(error) [list $err $errorInfo $errorCode]
                set State(status) error
            }
        }
        if {[info exists State(-command)]} {
            unset State(-command)
        }
    }
}

proc ::GA_Report::Pop {varname {nth 0}} {
    upvar $varname args
    set r [lindex $args $nth]
    set args [lreplace $args $nth $nth]
    return $r
}


# check internet connectivity and current data and time in world time web	
proc ::GA_Report::getTimeFromInternet {} {
	
	set url "http://worldtimeapi.org/api/ip"

	set internet_status [catch {set response [http::geturl $url]} internet_error]

	if {$internet_status == 0} {
		set data [http::data $response];
		#"utc_datetime":"2023-08-03T05:40:16.630698+00:00"
		set curret_date [string range $data [expr 259+15] [expr 259+24]];
		set unix_time [clock scan $curret_date];
		 http::cleanup $response;
	} else {
		set unix_time 0;
	}

	return $unix_time
}

proc ::GA_Report::internal_security { } {
	
	# ping to http://utcnist.colorado.edu/  time server 
	set ::GA_Report::supplier_function_activate 5
	set security [exec ping 10.30.241.59 -4]
	set recieved [lindex $security 45]
	set ::GA_Report::supplier_name "internal"
	
	#bypass above 
	# set recieved "(0%" 
	
	if { $recieved == "(0%" } {
		puts "security cleared" 
		set ::GA_Report::security_tocken 100
		::GA_Report::GUI_Launch 
	} else {
		set tok [::GA_Report::gettime utcnist.colorado.edu]
		set curtime [::GA_Report::unixtime $tok]
		#puts "The date is: [clock format $curtime -format %D]"
	
		if { $curtime < 1693000000 } {
			#Friday, August 25, 2023
			puts "security cleared"
			set ::GA_Report::security_tocken 200
			::GA_Report::GUI_Launch 
	
		}  else {

			puts "please check your internet connection and try again , if unsuccessful contact roopesh.puthalath@grupoantolin.com"
			tk_messageBox -message "please check your internet connection and try again , if unsuccessful contact roopesh.puthalath@grupoantolin.com" -type yesno
	
		}
	}
}


proc ::GA_Report::supplier_security { } {
	
	set ::GA_Report::supplier_function_activate 10 
	set recieved 5
	
	if { $recieved == "(0%" } {
		puts "security cleared" 
		set ::GA_Report::security_tocken 100
		
		::GA_Report::GUI_Launch 
	
	} else {
		#set tok [::GA_Report::gettime utcnist.colorado.edu]
		#set curtime [::GA_Report::unixtime $tok]
		set curtime [::GA_Report::getTimeFromInternet]
		if {$curtime <= 0} {
			tk_messageBox -message "Please check your internet connections" -icon error
			return
		}
		#1699000000
		if { $curtime < 1693000000 } {
			#Friday, August 25, 2023
			puts "security cleared"
			set ::GA_Report::security_tocken 200
			
			::GA_Report::GUI_Launch 
	
		}  else {
			tk_messageBox -message "Package validity is over. Kindly contact 'Grupo Antolin Design and Business Services Pvt Ltd'" -icon error
		}
	}

}

# ::GA_Report::internal_security
	
::GA_Report::supplier_security 