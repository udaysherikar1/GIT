catch {namespace delete ::qualityFeel}
namespace eval ::qualityFeel {
	
	set ::qualityFeel::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::qualityFeel::scriptDir utils.tbc]]} {
		source [file join $::qualityFeel::scriptDir utils.tbc];
	} else {
		source [file join $::qualityFeel::scriptDir utils.tcl];
	}
	
	if {[file exists [file join $::qualityFeel::scriptDir hv_utils.tbc]]} {
		source [file join $::qualityFeel::scriptDir hv_utils.tbc];
	} else {
		source [file join $::qualityFeel::scriptDir hv_utils.tcl];
	}
	
	if {[file exists [file join $::qualityFeel::scriptDir hg_utils.tbc]]} {
		source [file join $::qualityFeel::scriptDir hg_utils.tbc];
	} else {
		source [file join $::qualityFeel::scriptDir hg_utils.tcl];
	}

}

proc ::qualityFeel::main {modelFile resultFile THfile hv_dataType hv_dataComp hv_resultType Xsubcase XDataType XRequest XComponent Ysubcase \
						YDataType YRequest YComponent x_axesLabel y_axesLabel curveLabel ver_datumTarget sectionNodeId sectionAxes sectionName} {
	
	
	hwc delete session;
	
	#slide - 1
	#function get required handles
	set pageId 1;
	set t [::report::utils::getHandles];
	::report::utils::setPageLayout $pageId 1;
	::report::utils::change_client $t 1 "Animation";
	
	#hv model in 1st window
	::hv_utils::loadModel $pageId 1 $modelFile $resultFile;
	#query hyperview results
	::hv_utils::query_results;
	::hv_utils::applyContour $hv_resultType $hv_dataType $hv_dataComp;
	
	#hg plot in 2nd window
	::report::utils::change_client $t 2 "Plot";
	#query hypergraph results
	::hg_utils::query_results $THfile;
	
	#plot Force vs Displacement curve
	set ret [::hg_utils::CreateCurve $t 2 $THfile $Xsubcase $XDataType $XRequest $XComponent $Ysubcase $YDataType $YRequest $YComponent];
	if {$ret != 1} {
		#add curve attributes
		set curveId [lindex $ret 0];
		set t1 [lindex $ret 1];
		set cureve_max_x [lindex $ret 2];
		set cureve_max_y [lindex $ret 3];
		
		::hg_utils::changeCurveMetadata $t1 $curveId $x_axesLabel $y_axesLabel $curveLabel;
		::hg_utils::AddVerticalDatum $t1 $pageId 2 $ver_datumTarget;
		::hg_utils::AddNode $t1 $cureve_max_x $cureve_max_y;
	}
	
	#slide -2 
	set pageId [::report::utils::addPage $t];
	::report::utils::change_client $t 1 "Animation";
	::report::utils::setPageLayout $pageId 1;
	#window-1
	::hv_utils::loadModel $pageId 1 $modelFile $resultFile;
	set cordi [::hv_utils::queryNodes $t $sectionNodeId $resultFile];
	::hv_utils::AddSection $t $cordi $sectionAxes $sectionName;
	::hv_utils::setOrientation front;
	#window-2
	::hv_utils::loadModel $pageId 2 $modelFile $resultFile;
	::hv_utils::AddSection $t $cordi $sectionAxes $sectionName;
	::hv_utils::SetcrossSectionLines;
	::hv_utils::setOrientation front;
	
}


