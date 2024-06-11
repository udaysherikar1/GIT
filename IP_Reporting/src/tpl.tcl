catch {namespace delete ::tpl}
namespace eval ::tpl {
	
	set ::tpl::scriptDir [file dirname [info script]];
	if {[file exists [file join $::qualityFeel::scriptDir utils.tbc]]} {
		source [file join $::qualityFeel::scriptDir utils.tbc];
	} else {
		source [file join $::qualityFeel::scriptDir utils.tcl];
	}
	
}

proc ::tpl::saveTPL {outDir} {
	
	set t [clock click];
	
	set tplFilePath [file join $outDir reportAutomation.tpl];
	
	hwi OpenStack;
	hwi GetSessionHandle sessH$t;
	sessH$t SaveReportTemplate $tplFilePath;
	hwi CloseStack;
}


proc ::tpl::loadTPL {tpl_path model_path result_path th_path} {

	set t [clock clicks];
	hwi OpenStack;
	hwi GetSessionHandle s$t;
	s$t LoadReport "$tpl_path";
	set autofit false 
	set report_colors true 
	s$t ApplyReport "reportAutomation" append $autofit $report_colors 3 $model_path $result_path $th_path;
	hwi CloseStack;
	# ::hw::PopulateReportGenerationPanel
}

proc ::tpl::save_main {} {
	
	if {![info exists ::antolin::reportGui::outputDirPath]} {
		tk_messageBox -message  "Select output directory" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::outputDirPath]} {
		tk_messageBox -message  "Select valid output directory" -icon error;
		return
	}
	
	::tpl::saveTPL $::antolin::reportGui::outputDirPath;

}


proc ::tpl::load_main {} {
	
	if {![info exists ::antolin::reportGui::inputDirPath]} {
		tk_messageBox -message  "Select input directory" -icon error;
		return
	}
	if {![file exists $::antolin::reportGui::inputDirPath]} {
		tk_messageBox -message  "Select valid input directory" -icon error;
		return
	}
	
	#get animation and TH files in input directory
	set dir_list [::report::utils::getSubdirectory $::antolin::reportGui::inputDirPath];
	set anim_file_name [file tail $::antolin::reportGui::animationFilePath];
	set th_file_name [file tail $::antolin::reportGui::dataFilePath];
	
	catch {array unset ::tpl::arr_inputResults}
	array set ::tpl::arr_inputResults "";
	
	array set arr_files ""
	foreach dir $dir_list {
		set th_filePath [file join $dir $th_file_name];
		set anim_filePath [file join $dir $anim_file_name];
		
		if {[file exists $anim_filePath] && [file exists $th_filePath]} {
			set ::tpl::arr_inputResults($anim_filePath) $th_filePath;
		}
	}
	
	#delete existing session
	hwc delete session	
	
	#load results using tpl
	set tpl_path [file join $::antolin::reportGui::outputDirPath reportAutomation.tpl];
	foreach str_result [array names ::tpl::arr_inputResults] {
		set anim_filePath $str_result;
		set th_filePath [set ::tpl::arr_inputResults($anim_filePath)];
		
		#count pages before and after
		set n_pages_before [::report::utils::getNumOfPage];
		
		::tpl::loadTPL $tpl_path $anim_filePath $anim_filePath $th_filePath;
		
		set n_pages_after [::report::utils::getNumOfPage];
		
		::report::utils::setPageTitle [file tail [file dir $anim_filePath]] $n_pages_before $n_pages_after
		
		
	}
}