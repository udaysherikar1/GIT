catch {namespace delete ::imposedisp}

namespace eval ::imposedisp {

}

proc ::imposedisp::write {fo filepath funcId setId nodeId direction line_count} {
	
	if {$line_count == 1} {
		puts $fo "/IMPDISP/$funcId"
	} else {
		puts $fo "\n/IMPDISP/$funcId"
	}
	
	puts $fo "ImposedDispLoadColl_${direction}_${nodeId}"
	
	set space0 1
	set space1 9
	set space2 10
	set space3 19
	set space4 20
	
	puts $fo [format "%*s%*s%*s%*s%*s%*s%*s%*s" $space0 "#" $space1 "Ifunct" $space2 "DIR" $space2 "Iskew" $space2 "Isensor" $space2 "Gnod_id" $space2 "Frame" $space2 "Icoor"]
	puts $fo [format "%*s%*s%*s%*s%*s%*s%*s" $space2 "$funcId" $space2 "$direction" $space2 "0" $space2 "0" $space2 "$setId" $space2 "" $space2 "0"]
	
	puts $fo [format "%*s%*s%*s%*s%*s" $space0 "#" $space3 "Scale_x" $space4 "Scale_y" $space4 "Tstart" $space4 "Tstop"];
	puts -nonewline $fo [format "%*s%*s%*s%*s" $space3 "" $space4 "" $space4 "0.0" $space4 ""];
	
}

# # set filepath {E:\WorkingDir\Models\From_Sandeep\20231116_Intrusion_Data\V2251581700053209689_001_small\test.rad} 
# # set funcId 75001
# # set nodeId 1461926 
# # set setId 75001

# # set direction X;
# # ::imposedisp::write $filepath $funcId $setId $nodeId $direction;
# # set direction Y;
# # ::imposedisp::write $filepath $funcId $setId $nodeId $direction;
# # set direction Z;
# # ::imposedisp::write $filepath $funcId $setId $nodeId $direction;
