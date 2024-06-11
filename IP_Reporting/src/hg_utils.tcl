catch {namespace delete ::hg_utils}
namespace eval ::hg_utils {
	
	set ::hg_utils::scriptDir [file dirname [info script]];
	
	if {[file exists [file join $::hg_utils::scriptDir utils.tbc]]} {
		source [file join $::hg_utils::scriptDir utils.tbc];
	} else {
		source [file join $::hg_utils::scriptDir utils.tcl];
	}
}

proc ::hg_utils::AddVerticalDatum {t1 pageId winId targetValue} {
	
	#work only in unity
	#hwc xy datumvertical create range="p:$pageId w:$winId" position=$targetValue;

	set datumId [postH$t1 AddVerticalDatum];
	postH$t1 GetVerticalDatumHandle VdatumH$t1 $datumId;
	VdatumH$t1 SetPosition $targetValue;
	VdatumH$t1 SetLabel "Target Line";
	VdatumH$t1 SetLineColor 2;
	VdatumH$t1 SetLineStyle 5;
	VdatumH$t1 SetLineThickness 3;
	
	VdatumH$t1 ReleaseHandle;
}

proc ::hg_utils::AddNode { t1 cureve_max_x cureve_max_y} {
	
	set noteId [postH$t1 AddNote];
	postH$t1 GetNoteHandle noteH$t1 $noteId;
	#noteH$t1 SetAttachment "curve";
	noteH$t1 SetAttachment "point";
	noteH$t1 SetCoordinateXExpression $cureve_max_x;
	noteH$t1 SetCoordinateYExpression $cureve_max_y;
	noteH$t1 SetText "Max Displacement=$cureve_max_x";
	

}


proc ::hg_utils::changeCurveMetadata {t1 curveId x_axesLabel y_axesLabel curveLabel} {

	#here meta data are axis labels, cureve names, window name ..etc 
	curveH$t1 SetLabel $curveLabel;
	postH$t1 GetHorizontalAxisHandle XaxisH$t1 1;
	postH$t1 GetVerticalAxisHandle YaxisH$t1 1;
	
	XaxisH$t1 SetLabel $x_axesLabel;
	YaxisH$t1 SetLabel $y_axesLabel;
	
	postH$t1 Autoscale;
	postH$t1 Recalculate;
	postH$t1 Draw;
	
	XaxisH$t1 ReleaseHandle;
	YaxisH$t1 ReleaseHandle;

}

proc ::hg_utils::CreateCurve {t winId curveFile Xsubcase XDataType XRequest XComponent Ysubcase YDataType YRequest YComponent} {
	
	set t1 [clock click];
	puts "t1 -- $t1"
		
	set pageId [prjH$t GetActivePage];
	
	prjH$t GetPageHandle pageH$t1 [prjH$t GetActivePage ];
	pageH$t1 SetActiveWindow $winId;
	pageH$t1 GetWindowHandle winH$t1 [pageH$t1 GetActiveWindow];
	
	winH$t1 GetClientHandle  postH$t1;
	set curveId [ postH$t1 AddCurve];
	postH$t1 GetCurveHandle curveH$t1 $curveId;
	
	curveH$t1 GetVectorHandle xVector$t1 x;
	curveH$t1 GetVectorHandle yVector$t1 y;
	
	xVector$t1 SetFilename $curveFile;
	yVector$t1 SetFilename $curveFile;
	
	#check subcase from table in result file    X-subcase
	if {[info exists ::hg_utils::arr_hg_subcase_dataType($Xsubcase)]} {
		#check for X-types
		set lst_X_types [set ::hg_utils::arr_hg_subcase_dataType($Xsubcase)];
		if {[lsearch -nocase $lst_X_types $XDataType] != -1} {
			#check for x-request and x-component
			set lst_X_req_comp [set ::hg_utils::arr_hg_dataType_request_comp($XDataType)];
			set lst_x_request [lindex $lst_X_req_comp 0];
			set lst_x_component [lindex $lst_X_req_comp 1];
			#x-request
			if {[lsearch -nocase $lst_x_request $XRequest] == -1} {
				tk_messageBox -message  "TH file doesn't have subcase : \"$Xsubcase\", X-dataType : \"$XDataType\" X-request : \"$XRequest\". Please check" -icon error;
				return 1;
			}
			#x-component
			if {[lsearch -nocase $lst_x_component $XComponent] == -1} {
				tk_messageBox -message  "TH file doesn't have subcase : \"$Xsubcase\", X-dataType : \"$XDataType\" X-component : \"$XComponent\". Please check" -icon error;
				return 1;
			}
		} else {
			tk_messageBox -message  "TH file doesn't have subcase : \"$Xsubcase\", X-dataType : \"$XDataType\". Please check" -icon error;
			return 1;
		}
	} else {
		tk_messageBox -message  "TH file doesn't have subcase : \"$Xsubcase\". Please check" -icon error;		
		return 1;
	}
	
	
	
	#check subcase from table in result file    Y-subcase
	if {[info exists ::hg_utils::arr_hg_subcase_dataType($Ysubcase)]} {
		#check for X-types
		set lst_Y_types [set ::hg_utils::arr_hg_subcase_dataType($Ysubcase)];
		if {[lsearch -nocase $lst_Y_types $YDataType] != -1} {
			#check for x-request and x-component
			set lst_Y_req_comp [set ::hg_utils::arr_hg_dataType_request_comp($YDataType)];
			set lst_Y_request [lindex $lst_Y_req_comp 0];
			set lst_Y_component [lindex $lst_Y_req_comp 1];
			#x-request
			if {[lsearch -nocase $lst_Y_request $YRequest] == -1} {
				tk_messageBox -message  "TH file doesn't have subcase : \"$Ysubcase\", Y-dataType : \"$YDataType\" Y-request : \"$YRequest\". Please check" -icon error;
				return 1;
			}
			#x-component
			if {[lsearch -nocase $lst_Y_component $YComponent] == -1} {
				tk_messageBox -message  "TH file doesn't have subcase : \"$Ysubcase\", Y-dataType : \"$YDataType\" Y-component : \"$YComponent\". Please check" -icon error;
				return 1;
			}
		} else {
			tk_messageBox -message  "TH file doesn't have subcase : \"$Ysubcase\", Y-dataType : \"$YDataType\". Please check" -icon error;
			return 1;
		}
	} else {
		tk_messageBox -message  "TH file doesn't have subcase : \"$Ysubcase\". Please check" -icon error;		
		return 1;
	}
	
	
	xVector$t1 SetSubcase $XDataType;
	xVector$t1 SetDataType $XDataType;
	xVector$t1 SetRequest $XRequest;
	xVector$t1 SetComponent $XComponent;
	
	yVector$t1 SetSubcase $YDataType;
	yVector$t1 SetDataType $YDataType;
	yVector$t1 SetRequest $YRequest;
	yVector$t1 SetComponent $YComponent;
	
	postH$t1 Autoscale;
	postH$t1 Recalculate;
	postH$t1 Draw;
	
	hwc xy plot view range="p:$pageId w:$winId" fitaxis=all;
		
	set max_y [curveH$t1 GetCurveMaxValue];
	set max_x [curveH$t1 GetCurveMaxLocation];
	
	#set legend position 
	postH$t1 GetLegendHandle legH$t1;
	legH$t1 SetPosition 0 0;
	legH$t1 ReleaseHandle;
	
	return [list $curveId $t1 $max_x $max_y];
}

proc ::hg_utils::query_results {hg_filePath} {
		
	set t [clock click];
	hwi OpenStack;
	hwi GetSessionHandle sessH$t;
	sessH$t GetDataFileHandle dataFileH$t $hg_filePath;
	
	#rest array
	catch {array unset ::hg_utils::arr_hg_subcase_dataType};
	array set ::hg_utils::arr_hg_subcase_dataType "";
	catch {array unset ::hg_utils::arr_hg_dataType_request_comp};
	array set ::hg_utils::arr_hg_dataType_request_comp "";
	
	set subList [dataFileH$t GetSubcaseList];
	foreach str_subcase $subList {
		dataFileH$t SetSubcase $str_subcase;
		set dataTypeList [dataFileH$t GetDataTypeList];
		foreach str_dataType $dataTypeList {
			if {$str_dataType == "Time" || $str_dataType == "Index"} {
				continue
			}			
			set dataRequestList [dataFileH$t GetRequestList $str_dataType];
			set dataComponentList [dataFileH$t GetComponentList $str_dataType];
			#store hg info to array
			set ::hg_utils::arr_hg_subcase_dataType($str_subcase) $str_dataType;
			set ::hg_utils::arr_hg_dataType_request_comp($str_dataType) [list $dataRequestList $dataComponentList];			
		}
	}

}




