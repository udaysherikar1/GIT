catch {namespace delete ::antolin::gui_utils}

namespace eval ::antolin::gui_utils {

}

proc ::antolin::gui_utils::getFilters {solverType} {
	
	if {$solverType == "Abaqus"} {
		set model_filter {
			{{Abaqus file}  {*.inp}}
			{{Abaqus file}  {*.pes}}
			{{All Files}        * }
		}
		set result_filter {
			{{Abaqus file}  {*.odb}}
			{{All Files}        * }
		}
	}
	
	if {$solverType == "LsDyna"} {
		set model_filter {
			{{LsDyna file}  {*.k}}
			{{LsDyna file}  {*.key}}
			{{All Files}        * }
		}
		set result_filter {
			{{LsDyna file}  {d3plot}}
			{{LsDyna file}  {*.h3d}}
			{{All Files}        * }
		}
	}
	
	if {$solverType == "PamCrash"} {
		set model_filter {
			{{Pamcrash file}  {*.pc}}
			{{Pamcrash file}  {*.dat}}
			{{Pamcrash file}  {*.inc}}
			{{All Files}        * }
		}
		set result_filter {
			{{Pamcrash file}  {*.erfh5}}
			{{All Files}        * }
		}
	}
	
	if {$solverType == "Radioss"} {
		set model_filter {
			{{Radioss file}  {*.d00}}
			{{Radioss file}  {*.RAD}}
			{{Radioss file}  {*.rad}}
			{{All Files}        * }
		}
		set result_filter {
			{{Radioss file}  {*.h3d}}
			{{All Files}        * }
		}
	}
	
	if {$solverType == "Optistruct"} {
		set model_filter {
			{{Optistruct file}  {*.fem}}
			{{Optistruct file}  {*.parm}}
			{{All Files}        * }
		}
		set result_filter {
			{{Optistruct file}  {*.h3d}}
			{{Optistruct file}  {*.op2}}
			{{All Files}        * }
		}
	}
	
	return [list $model_filter $result_filter];
}
