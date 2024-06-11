catch {namespace delete ::process}

namespace eval ::process {

}

proc ::process::checkRunningProcess {} {

	set process_list [list];
	
	set platform [set ::tcl_platform(platform)];
		
	if {$platform == "unix"} {
		#linux
		set psOutput [exec ps aux]
		set psLines [split $psOutput "\n"];
		foreach line $psLines {
			set fields [regexp -all -inline {\S+} $line];
			if {[llength $fields] > 1} {
				set pid [lindex $fields 1];
				if {[string match -nocase "*hmopengl*" $fields]} {
					lappend process_list $pid
				} 
			}
		}
	
	
	} else {
	
		set processList [exec tasklist];
		set processList [lrange [split $processList "\n"] 2 end];
		
		foreach process $processList {
			
			set fields [regexp -all -inline {\S+} $process];
			if {[llength $fields] >= 2} {
				set processName [lindex $fields 0];
				set pid [lindex $fields 1];
				
				if {[string match -nocase "hw.exe" $processName]} {
					#puts "Process Name: $processName, Process ID: $pid"
					lappend process_list $pid
				}   
			}
		}
	}
	
	return $process_list

}


#set process_list [::process::checkRunningProcess "hw.exe"];
#puts $process_list





