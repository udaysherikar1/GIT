
catch {namespace delete ::antolin::decodeLogs}

namespace eval ::antolin::decodeLogs {


}

proc ::antolin::decodeLogs::gui {} {

	catch {destroy .decodeLogs};
	set decodeMainFrm [toplevel .decodeLogs];
	wm geometry $decodeMainFrm +500+400;
	wm title $decodeMainFrm "Antolin - Decode Logs";
	wm maxsize  $decodeMainFrm 700 120;
	wm minsize  $decodeMainFrm 700 120;
	wm transient .decodeLogs .
	
	set mainFrm1 [hwtk::frame $decodeMainFrm.mainFrm1 ];
	pack $mainFrm1 -side top -pady 4 -padx 4 -anchor nw;
	
	set log_labelFrm [hwtk::label $mainFrm1.log_labelFrm -text "Log Directory" -width 14];
	pack $log_labelFrm -side left -pady 4 -padx 4 -anchor nw;
	
	set ::antolin::decodeLogs::logFileDir ""
	set logpath_frm [hwtk::choosedirentry $mainFrm1.logpath_frm -width 110 -buttonpos left\
				-textvariable ::antolin::decodeLogs::logFileDir]
	pack $logpath_frm -side top -fill both -expand true -padx 4 -pady 4 -anchor nw;
	
	
	set mainFrm2 [hwtk::frame $decodeMainFrm.mainFrm2 ];
	pack $mainFrm2 -side top -pady 4 -padx 4 -anchor e;
	
	set apply1_frm [hwtk::button $mainFrm2.apply1_frm -text "Decode" -width 10 -command ::antolin::decodeLogs::decodeLogFiles];
	pack $apply1_frm -side top -expand false -padx 10 -pady 4 -anchor nw ;
	puts $apply1_frm
}


proc ::antolin::decodeLogs::decodeLogFiles {} {

	set b_slash {/}
	set f_slash {\\}
	set text_extension {.txt}
	set log_extension {log_file_}
	set decode_string "report_"
	
	set log_list_name_only [glob -nocomplain -directory $::antolin::decodeLogs::logFileDir *.txt] 
	
	foreach log_file_path $log_list_name_only  {
	
		set corrected_path [ regsub "$b_slash" $log_file_path "$f_slash" ]
		set text_file_name [file tail $corrected_path]
		set rest_of_path [ string trim $corrected_path "$text_file_name" ]
		
		set just_name [ string trim $text_file_name "$text_extension" ]
		##puts $just_name
		set time_only [ string trim $just_name "$log_extension" ]
		##puts $time_only
		set timestr [clock format $time_only -format "%y-%m-%d %H:%M:%S"]
		##puts $timestr 
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
			set decode_line [::antolin::decodeLogs::decode $each_line]
			puts $decoded_file_current $decode_line
			
			incr i	
		}
		#set page_saving [ expr { ( ($count_page -1) * 15 )   } ]
		##puts $decoded_file_current " savings_with_15min [format { %7g} $page_saving ] "
		
		close $decoded_file_current;
		close $enc_file_val;
		set count_page 0
	
	}
}


proc ::antolin::decodeLogs::to_ascii {char} {
 #
	set value 0
	scan $char %c value
	return $value
					
}

proc ::antolin::decodeLogs::decode {str} {
			
	set enc_string "password"
	set enc_idx 0
	set crypt_str ""
	set strlen [string length $str]
	if {$strlen == 0} {return}
	for {set testx 0} {$testx < $strlen} {incr testx 1} {
		set curnum [expr {[to_ascii [string index $str $testx]]-[::antolin::decodeLogs::to_ascii [string index $enc_string $enc_idx]]}]
		if {$curnum < 0} {set curnum [expr {$curnum + 256}]}
		set crypt_str "$crypt_str[format %c $curnum]"
		set enc_idx [incr enc_idx 1]
		if {$enc_idx == [string length $enc_string]} {set enc_idx 0}
	}
	return $crypt_str
}


proc ::antolin::decodeLogs::encode {str} {
							
	set enc_string "password"
	set enc_idx 0
	set crypt_str ""
	for {set i 0} {$i < [string length $str]} {incr i 1} {

		set curnum [expr {[to_ascii [string index $str $i]] + [::antolin::decodeLogs::to_ascii [string index $enc_string $enc_idx]]}]
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

::antolin::decodeLogs::gui


