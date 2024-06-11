#source [file normalize [file join $::env(HWTK_ROOT) demos customeditors.tcl]]

package require hwtk;

catch {namespace delete ::inputTable}
namespace eval ::inputTable {

}

proc ::inputTable::ReadInputCSV {csvFilePath} {
	
	catch {array unset ::inputTable::arr_inputCsvFile}
	array set ::inputTable::arr_inputCsvFile "";
	
	set fr [open $csvFilePath r]
	set data [read $fr]
	close $fr
	
	set i 1;	
	foreach line [split $data "\n"] {
		if {[llength $line] == 0} {
			continue
		}
		set info [split $line ,]
		set ::inputTable::arr_inputCsvFile($i) [list [lindex $info 1] [lindex $info 2]];
		
		incr i;
	}

}

proc ::inputTable::ValidateValue {args} {
    puts [info level 0];
    return 1;
}

proc ::inputTable::SetValue {args} {
    puts [info level 0];
    return 1;
}

proc ::inputTable::GetValue {} {
	
	catch {array unset ::inputTable::arr_tableValues}
	array set ::inputTable::arr_tableValues "";
	
	set rowList [$::inputTable::table_frm rowlist];
	set columnlist [$::inputTable::table_frm columnlist];
	foreach n_row $rowList {
		set table_name [$::inputTable::table_frm cellget $n_row,name];
		set table_value [$::inputTable::table_frm cellget $n_row,value];
		set ::inputTable::arr_tableValues($table_name) $table_value;
	}
}

proc ::inputTable::CreateColumns {w} {

    $w columncreate name -text "Name" -validatecommand ::inputTable::ValidateValue \
        -valueaccept "::inputTable::SetValue %W %I %C %V %P" -editable 0 -expand 0 -width 300;
		
	$w columncreate value -text "Value" -validatecommand ::inputTable::ValidateValue \
        -valueaccept "::inputTable::SetValue %W %I %C %V %P" -expand 1;	
}	

proc ::inputTable::Populate {} {
		
	set j 1;
	foreach key [lsort -real [array names ::inputTable::arr_inputCsvFile]] {
		set name $key;
		set arr_value [set ::inputTable::arr_inputCsvFile($key)];
				
		set name [lindex $arr_value 0];
		set value [lindex $arr_value 1];
		set table_values [list name $name value $value];
		$::inputTable::table_frm rowinsert end row$j -values $table_values;
		
		incr j;
	}
}

proc ::inputTable::deleteTable {} {

	set rowList [$::inputTable::table_frm rowlist];
	foreach n_row $rowList {
		$::inputTable::table_frm rowdelete $n_row;
	}
	catch {array unset ::inputTable::arr_inputCsvFile}

}

proc ::inputTable::createTable {frm} {
	
	set table_labelFrm [hwtk::label $frm.table_labelFrm -text "Report Inputs" -width 14 ];
	pack $table_labelFrm -side top -pady 4 -padx 4 -anchor nw;
	
	set ::inputTable::table_frm [::hwtk::table $frm.table_frm -closeeditor 1];
	pack $::inputTable::table_frm -fill both -expand true -side left -pady 4 -padx 4;

	::inputTable::CreateColumns $::inputTable::table_frm;
	#::inputTable::Populate $t;
}
