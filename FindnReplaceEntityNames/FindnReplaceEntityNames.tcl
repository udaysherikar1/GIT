###################################################################################################################################
## $Author : praveen.kumark@altair.com
## $Discription : Replace various entity names. Work as efficiently like "find and replace" function of excel, word, etc.,
###################################################################################################################################
global mytable
catch {destroy $w}
set w .wif
toplevel $w
wm title $w "Find & Replace with .."
wm maxsize $w 800 700               
::hwt::KeepOnTop $w
set fr3 [frame $w.fr3 -borderwidth .1c -relief ridge]
pack $fr3 -fill both -expand 0
set fr1 [frame $fr3.fr1]
pack $fr1 -fill both -expand 0
set labelt [frame $fr1.labelt]
pack $labelt -fill both -side top
# pack [label $labelt.lab -text "This Option helps you to replace text in all Entity Type Names. " -font {rockwell 10 bold}] -side top -padx 10 -pady 10
set lbfrm [labelframe $labelt.lbfrm -text "Replace in what : " -font {rockwell 10 bold}]
pack $lbfrm -side left -padx 5 -pady 10 -ipadx 20
 
set lbfr1 [frame $lbfrm.lbfr1]
pack $lbfr1 -side left -expand 0
set lbfr2 [frame $lbfrm.lbfr2]
pack $lbfr2 -side left -expand 0
set lbfr3 [frame $lbfrm.lbfr3]
pack $lbfr3 -side left -expand 0
set lbfr4 [frame $lbfrm.lbfr4]
pack $lbfr4 -side left -anchor n -expand 0
set lbfr5 [frame $lbfrm.lbfr5]
pack $lbfr5 -side left -anchor n -expand 0
pack [checkbutton $lbfr1.comps -text "Components" -variable compcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10  -anchor w
pack [checkbutton $lbfr1.props -text "Properties" -variable propcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr1.mats -text "Materials" -variable matcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr1.asscols -text "Assemblies" -variable assemcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr3.groups -text "Groups" -variable groupcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr3.sets -text "Sets" -variable setcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr3.contactsurfs -text "Contact_Surfs" -variable csurfcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr3.blocks -text "Blocks" -variable blockcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr2.loadCols -text "Load_Cols" -variable loadcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr2.syscols -text "System_Cols" -variable syscheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr2.veccols -text "Vector_Cols" -variable vectcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr2.beamsectcols -text "BeamSect_Cols" -variable bsectcheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr4.loadsteps -text "Load_Steps" -variable lscheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [checkbutton $lbfr4.plies -text "Plies" -variable plycheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
# pack [checkbutton $lbfr4.laminates -text "Laminates" -variable lamincheck -font {rockwell 10 bold}] -side top -padx 10 -pady 10 -anchor w
pack [button $lbfr4.but -text "Select all" -width 15 -font {rockwell 8 bold} -bg grey] -side top -padx 10 -pady 10 -anchor w
  
	set compcheck 1
	set propcheck 0
	set matcheck 0
	set assemcheck 0
	set groupcheck 0
	set setcheck 0
	set csurfcheck 0
	set blockcheck 0
	set loadcheck 0
	set syscheck 0
	set vectcheck 0
	set bsectcheck 0
	set lscheck 0
	set plycheck 0

set activate 1
bind $lbfr4.but <Button-1> {
if {$activate == 1} {
		set compcheck 1
		set propcheck 1
		set matcheck 1
		set assemcheck 1
		set groupcheck 1
		set setcheck 1
		set csurfcheck 1
		set blockcheck 1
		set loadcheck 1
		set syscheck 1
		set vectcheck 1
		set bsectcheck 1
		set lscheck 1
		set plycheck 1
		set activate 0
		
} elseif {$activate == 0} {

		set compcheck 0
		set propcheck 0
		set matcheck 0
		set assemcheck 0
		set groupcheck 0
		set setcheck 0
		set csurfcheck 0
		set blockcheck 0
		set loadcheck 0
		set syscheck 0
		set vectcheck 0
		set bsectcheck 0
		set lscheck 0
		set plycheck 0
		set activate 1
	}
	# set activate 0
}	
 
set fr2 [frame $fr1.fr2]
pack $fr2 -fill both -expand 0
set findbtn [frame $fr2.findbtn]
pack $findbtn -fill both -side top
set findtext [list];
set replacetext [list];
pack [label $findbtn.label -text "Find what	:" -anchor w -font {rockwell 10 bold} ] -side left -pady 10 -padx 5
pack [entry $findbtn.entry -textvariable findtext -width 49 -font {rockwell 10 bold}] -side left -pady 10
pack [button $findbtn.preview -text "Find.." -width 8 -font {rockwell 10 bold} -bg grey -command {puts [findnearest]} -padx 10 -anchor w] -side left -padx 10 -pady 10
 
set replacebtn [frame $fr2.replacebtn]
pack $replacebtn -fill both -side top
pack [label $replacebtn.label -text "Replace with	:" -anchor w -font {rockwell 10 bold} ] -side left -padx 5 -pady 10
pack [entry $replacebtn.entry -textvariable replacetext -width 49 -font {rockwell 10 bold}] -side left -pady 10
pack [button $replacebtn.replace -text "Rename.." -width 8 -font {rockwell 10 bold} -bg grey -command {renameentities} -padx 10 -anchor w] -side left -padx 10 -pady 10
 
set options [frame $fr1.options]
pack $options -fill x -side top
set options2 [frame $options.options2]
pack $options2 -fill both -side right -padx 10
set options1 [frame $fr1.options1]
pack $options1 -fill both -side top
set options4 [frame $fr1.options4]
pack $options4 -fill both -side top
pack [button $options2.spaces -text {Replace Spaces in all Entity Types with "_"} -width 40 -font {rockwell 10 bold} -bg grey -command {removespaces} -padx 5] -side right -pady 5 -anchor ne
# pack [checkbutton $options2.matchcase -text {Match Case} -variable matchb -font {rockwell 10 bold} -command {matchbind} -padx 25] -side right 
pack [button $options1.special -text {Replace Special Char in all Entity Types with "_"} -width 40 -font {rockwell 10 bold} -bg grey -command {renamespecialcharacters} -padx 5] -side right -pady 5 -padx 10
pack [label $options4.lbl   -text {{! # @ % ^ & " " ( ) - + ' = : ; $ , . ? / < > [ ] { } _ \ | * ` ~} are special characters.} -font {rockwell 10 bold}] -side right -padx 10 -pady 5 -anchor w


#########################################################################################################################################
#########################################################################################################################################
set entitylst {{compcheck comps} {propcheck props} {matcheck mats} {assemcheck assems} {groupcheck groups} {setcheck sets} {csurfcheck contactsurfs} {blockcheck blocks} {loadcheck loadcols} {syscheck systemcols} {vectcheck vectorcols} {bsectcheck beamsectcols} {lscheck loadsteps} {plycheck plies}}
#########################################################################################################################################
proc findnearest {} {
global findtext replacetext entitylst
set mylstnames [list];
set temp "";
	if {[string length "$findtext"] > 0} {
		foreach ent $entitylst {
			global [lindex $ent 0]
			eval set kent $[lindex $ent 0]
			if {$kent == 1} {
				set enttype [lindex $ent 1]
				set mylstnames "[hm_entitylist $enttype name]"
				set filterlst [list];
				if {[llength $mylstnames] > 0} {
					foreach ename $mylstnames {
						if {[llength [lsearch -all -inline $ename *$findtext*]] > 0} {
							lappend filterlst $ename
						}
					}
					lappend temp "[llength $filterlst] - $enttype Found!!\n"
				}
			}
		}
		if {[llength $temp] > 0} {
			set temp [join $temp {}]
			tk_messageBox -message "$temp"
		}
	} else {
		tk_messageBox -message "Cannot Find the text you're Searching for !!"
	}
}
##########################################################################################################################################
#########################################################################################################################################
proc findmatches {entityname} {
global findtext replacetext 
set mylstnames [list];
set mylstnames [hm_entitylist $entityname name]
puts $mylstnames
set filterlst [list];
    if {[string length "$findtext"] > 0} {
		if {[llength $mylstnames] > 0} {
			foreach ename $mylstnames {
				if {[llength [lsearch -all -inline $ename *$findtext*]] > 0} {
					lappend filterlst $ename
				}
			}
		}
    }
    return $filterlst;
}
##########################################################################################################################################
##########################################################################################################################################
proc renameentities {} {
global findtext entitylst replacetext compcheck propcheck matcheck assemcheck groupcheck setcheck csurfcheck blockcheck loadcheck syscheck vectcheck bsectcheck lscheck plycheck
    set mainlst [list];
	set getmatchlst [list];
	set tempall [list];
	if {[string length "$findtext"] > 0} {
	if {[string length "$replacetext"] > 0} {
	foreach etype $entitylst {
		eval set kent $[lindex $etype 0]
		if {$kent == 1} {
			set enttype [lindex $etype 1]
			set getmatchlst "[findmatches $enttype]"
			puts $getmatchlst
			if {[llength $getmatchlst] > 0} {
				set tempen [list];
				foreach ename $getmatchlst {
					set oldname $ename;
					puts $ename
					set newname $ename
					set j 0
					for {set i 1} {$i > 0} {incr i} {
						set findme [string first "$findtext" "$newname" $j]
						if {$findme > -1} {
							set j [string first "$findtext" "$newname" $j]
							puts $j
							set jj $j
							if {[string length "$findtext"] > 1} {
								set j [expr $j+[string length "$replacetext"]]
								set newname [string replace "$newname" $jj [expr $jj+[string length "$findtext"]-1] "$replacetext"]
							} elseif {[string length "$findtext"] == 1} {
								set j [expr $j+[string length "$replacetext"]]
								set newname [string replace "$newname" $jj $jj "$replacetext"]
							}
						} else {
							break;
						}
					}
					puts $newname
					catch {*renamecollector $enttype "$oldname" "$newname"}
					if {"$oldname" != "$newname"} {
						lappend tempen "$ename"
					}
				}
				 lappend tempall "[llength $tempen] - $enttype Renamed\n"
			}
		}
	} 
	set tempall [join $tempall {}]
	if {[llength $tempall] > 0} {
		tk_messageBox -message "$tempall"
	} else {
		tk_messageBox -message "No match found to rename!!"
	}
	} else {
		tk_messageBox -message "Please enter the rename string !!!"
	}
	} else {
		tk_messageBox -message "Cannot find the string you are searching for !!!"
	}  
}
####################################################################################################################################
proc renamespecialcharacters {} {
	global entitylst
	set alldata [list];
	foreach etype $entitylst {
		set enttype [lindex $etype 1]
		set mylist [hm_entitylist $enttype name]
		set tempc [list];
		if {[llength $mylist] > 0} {
			hm_blockerrormessages 1
			foreach compnals $mylist {
				set oldname $compnals
				set splitdata [split $compnals {! # @ % ^ & " " ( ) - + ' = : ; $ , . ? / < > [ ] { } _ \ | * ` ~}]
				if {[llength $splitdata] > 1} {
					set splitdata [join $splitdata { }]
					lappend tempc $compnals
					set splitdata [join $splitdata _]
					catch {*renamecollector $enttype "$oldname" "$splitdata"}                                                                       
				}
			}
			hm_blockerrormessages 0
		}
		lappend alldata "[llength $tempc] - $enttype Renamed\n"
	}
	set alldata [join $alldata]
	tk_messageBox -message "$alldata"
}       
 
####################################################################################################################################
proc removespaces {} {
	global entitylst
	set alldata [list];
	foreach etype $entitylst {
		set enttype [lindex $etype 1]
		set mylist [hm_entitylist $enttype name]
		set newlst [list];
		if {[llength $mylist] > 0} {
			hm_blockerrormessages 1
			foreach compnals $mylist {
				set oldname $compnals
				set joindata [join $compnals { }]
				set joindata [join $joindata _]
				if {[llength "$oldname"] > 1} {
					lappend newlst $newlst
					catch {*renamecollector $enttype "$oldname" "$joindata"}
				}
			}
			hm_blockerrormessages 0
		}
		lappend alldata "[llength $newlst] - $enttype Renamed\n"
	}
	set alldata [join $alldata]
	tk_messageBox -message "$alldata"
}        