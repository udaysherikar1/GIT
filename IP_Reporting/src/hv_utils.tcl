catch {namespace delete ::hv_utils}
namespace eval ::hv_utils {
	
	
}


proc ::hv_utils::AddSection {t cordi axis sectionName} {

	hwc section delete $sectionName;
	hwc section create planar $sectionName;
	hwc section $sectionName orientation=$axis;
	#hwc section $sectionName position=947.275024;
	hwc section $sectionName position=[lindex $cordi 0];
	hwc section qualityFeel showsectioncolor=true;
	hwc section qualityFeel deformable=true;
	
}

proc ::hv_utils::SetcrossSectionLines {} {
	hwc section qualityFeel crosssectiononly=true;
	hwc section qualityFeel showsectioncolor=false
}

proc ::hv_utils::queryNodes {t nodeId resultFile} {

	set t2 [clock click];	
	post::GetActiveModelHandle modelH$t2;
	modelH$t2 GetQueryCtrlHandle queryH$t2;
	# queryH$t2 SetQuery "node.id node.coords contour.value";
	queryH$t2 SetQuery "node.id node.coords";
	
	modelH$t2 GetSelectionSetHandle ssetH$t2 [modelH$t2 AddSelectionSet "node"];
	ssetH$t2 Add "id == $nodeId";
	
	queryH$t2 SetSelectionSet [ssetH$t2 GetID];
    queryH$t2 GetIteratorHandle iterH$t2;
	
	set d_queryres  [iterH$t2 GetDataList];
		
	return [lindex $d_queryres 1];

}


proc ::hv_utils::loadModel {pageId winId modelFile resultFile} {

	hwc hwd page makecurrent $pageId;
	hwc hwd page current activewindow=$winId
	
	hwc config resultmathtemplate Advanced;
	hwc open animation modelandresult $modelFile $resultFile;

}


proc ::hv_utils::applyContour {resultType dataType dataComp} {
	
	#get information from gui table
	set table_dataType [set ::inputTable::arr_tableValues(HyperView_DataType)];
	set table_dataComp [set ::inputTable::arr_tableValues(HyperView_DataComponent)];
	
	#check gui enterted results in hv result
	if {[info exists ::hv_utils::arr_hv_resultInfo($table_dataType)]} {
		set result_dataComps [set ::hv_utils::arr_hv_resultInfo($table_dataType)];
		#check result component
		if {[lsearch -nocase $result_dataComps $table_dataComp] != -1} {
			hwc result $resultType load type=$dataType component=$dataComp;
			hwc show legends;
		} else {
			tk_messageBox -message  "Result type \"$table_dataType\" don't have data component \"$table_dataComp\". Please check" -icon error;
		}
	} else {
		tk_messageBox -message  "Results don't have result type : \"$table_dataType\". Please check" -icon error;
	}
}

proc ::hv_utils::setOrientation {side} {
	hwc view orientation $side;
}

proc ::hv_utils::startAnimation {} {
	
	hwc animate start;

}

proc ::hv_utils::stopAnimation {} {
	
	hwc animate stop;

}

proc ::hv_utils::query_results {} {
	
	set t [clock click];
	
	catch {array unset ::hv_utils::arr_hv_resultInfo}
	array set ::hv_utils::arr_hv_resultInfo "";
	
	post::GetActiveModelHandle modelH$t;
	modelH$t GetResultCtrlHandle resH$t;
	set subcaseId [resH$t GetCurrentSubcase];
	set dataTypeList [resH$t GetDataTypeList $subcaseId];
	foreach str_dataType $dataTypeList {
		set dataCompList [resH$t GetDataComponentList $subcaseId $str_dataType];
		set ::hv_utils::arr_hv_resultInfo($str_dataType) $dataCompList;
	}
}

