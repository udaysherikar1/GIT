catch {namespace delete ::captureImages}

namespace eval ::captureImages {

}

proc ::captureImages::Main {image_name slide_Title ppt_template dirPath} {

	set t [clock click];
	hwi GetSessionHandle sess$t;
	sess$t GetProjectHandle proj$t;
	set n_pages [proj$t GetNumberOfPages];
	
	set imageCsv [file join $dirPath reportAutomationImages.csv];
	set fo [open $imageCsv w];
	
	puts $fo "Title,${slide_Title}"
	puts $fo "Template,${ppt_template}"
		
	for {set i 1} {$i <= $n_pages} {incr i} {
		
		proj$t SetActivePage $i;
		proj$t GetPageHandle page$t [proj$t GetActivePage];
		set n_win [page$t GetNumberOfWindows];
		
		for {set j 1} {$j <= $n_win} {incr j} {
			
			page$t GetWindowHandle winH$t $j;
			set winType [winH$t GetClientType];
						
			page$t SetActiveWindow $j;	
			page$t SetActiveWindowExpanded true;
						
			if {$winType == "Plot"} {
				set imagePath [file join $dirPath "${image_name}_${i}_${j}.jpg"];
				sess$t CaptureActiveWindow JPEG $imagePath percent 150 150;	
			} else {
				set imagePath [file join $dirPath "${image_name}_${i}_${j}.gif"];
				sess$t CaptureAnimation gif $imagePath percent 100 100;
			}

			
			#define window namespace
			if {[expr $i%2] == 1 && [expr $j%2] == 1} {
				#page-1, win-1
				set win_name "Contour";
			} elseif {[expr $i%2] == 1 && [expr $j%2] == 0} {
				#page-1,win-2
				set win_name "F-D Curve";
			} elseif {[expr $i%2] == 0 && [expr $j%2] == 1} {
				#page-2, win-1
				set win_name "Animation";
			} else {
				#
				set win_name "";
			}
			
			
			if {[expr $j%2] == 0} {
				#win-1 .. odd
				puts $fo "$imagePath,$win_name,9,2.5,7.5,6.0,0";
				#puts $fo "$imagePath,9,2.5,7.5,6.0,0";
			} else {
				#win-2 .. even
				puts $fo "$imagePath,$win_name,1,2.5,7.5,6.0,1";
				#puts $fo "$imagePath,1,2.5,7.5,6.0,1";
			}
			
			page$t SetActiveWindowExpanded false;
			winH$t ReleaseHandle;
		}
		page$t ReleaseHandle;
	}
	proj$t ReleaseHandle;
	
	close $fo;
}

