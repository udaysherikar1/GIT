catch {namespace delete ::images}
namespace eval ::images {
	
	variable username $::env(USERNAME)
	
	set ::images::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::images::scriptDir Auto_email.tbc]]} {
		source [file join $::images::scriptDir Auto_email.tbc];
	} else {
		source [file join $::images::scriptDir Auto_email.tcl];
	}
	
}


proc ::images::GetLogPath {filepath} {
	
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
	set logpath [file join $data ${username}_excelreport_Log_${d_m_y}.txt]

	return $logpath
	
}

proc ::images::CaptureCompImages {} {
	
	set user_home $::env(HOME);
	set temp_dir [file join $user_home "temp_image_dir"];
	
	if {[file exists $temp_dir]} {
		catch {file delete -force $temp_dir}
	}
	
	set log_filepath [::images::GetLogPath [file join $::images::scriptDir log_config.txt]];
	#puts "log_filepath -- $log_filepath"
	if {![file exists $log_filepath]} {
		set fo [open $log_filepath w];
		
		set org_name [exec whoami]
		puts $fo "\[[clock format [clock seconds] -format %D::%H:%M:%S]\] :  $org_name"
		puts $fo "-------------------------------------------------------------"
		puts $fo "-------------------------------------------------------------"
		
	} else {
		set fo [open $log_filepath a];
	}
		
	catch {[file mk dir $temp_dir]}
	
	*createmark comp 1 displayed;
	set lst_Comp [hm_getmark comps 1];
	
	puts $fo "\[[clock format [clock seconds] -format %D::%H:%M:%S]\] no. images captured : [llength $lst_Comp]"
	
	close $fo
	
	set csv_path [file join $temp_dir captureImage.csv];
	set fo [open $csv_path w];
	set i 1;
	foreach compId $lst_Comp {
		set compName [hm_getvalue comp id=$compId dataname=name];
				
		#isolate comps 
		*createmark components 2 $compName
		*createstringarray 2 "elements_on" "geometry_on"
		*isolateonlyentitybymark 2 1 2
		
		#iso
		*view "iso1"
		
		if {[string match -nocase "*/*" $compName]} {
			set compName [string map {/ _} $compName];
		}
		if {[string match -nocase "*.*" $compName]} {
			set compName [string map {. _} $compName];
		}
		if {[string match -nocase "* *" $compName]} {
			set compName [string map {" " _} $compName];
		}
		if {[string match -nocase "*,*" $compName]} {
			set compName [string map {, _} $compName];
		}
		set compName [string map {\n ""} $compName];
		#save images
		set imagePath [file join $temp_dir ${compName}.jpg];
		hm_answernext yes;
		*jpegfilenamed $imagePath;
		
		puts $fo "$i,$compName,$imagePath"
		
		incr i;
	}
	
	close $fo;
	
	
	#write python file to send email 
	#::antolin::autoEmail::SendOutlookEmail $log_filepath;
	
	return $temp_dir;
}

proc ::images::generateExcel {} {
	
	set excel_exe [file join $::images::scriptDir dist writeExcel writeExcel.exe];
	catch {exec $excel_exe}

}


proc ::images::main {} {

	# set feedback [tk_messageBox -message "Generated log will be e-mailed to 'uday.sherikar@antolin.com'. \nDo you agree?" -type yesno -icon info];
	# if {$feedback == "no"} {
		# return
	# }
		
	# set ret [::antolin::autoEmail::ChkPythonInstallation];
	# if {$ret == 1} {
		# tk_messageBox -message "Python is not intalled in your laptop/desktop. " -icon error;
		# return
	# }
	
	# set ret1 [::antolin::autoEmail::check_py_win32com_library];
	# if {$ret1 == 1} {
		# tk_messageBox -message "Required python library is NOT available.  Execute 'pip install pywin32' in windows command prompt and try again" -icon error;
		# return
	# }
	
	set excel_template [file join $::images::scriptDir "ESTIMATION_TRACKING_SHEET_Template.xlsx"];
	
	set temp_dir [::images::CaptureCompImages];
	
	#copy template to user temp location.
	catch {file copy -force $excel_template $temp_dir}
	
	::images::generateExcel;
	
	tk_messageBox -message "Report available at \'$temp_dir\'" -icon info

}
::images::main


