catch {namespace delete ::report::utils}
namespace eval ::report::utils {

}

proc ::report::utils::getHandles {} {
		
	set t [clock click];
	puts "t -- $t"
	hwi OpenStack;
	hwi GetSessionHandle sessH$t;
	sessH$t GetProjectHandle prjH$t;
		
	return $t;

}

proc ::report::utils::setPageLayout { pageId n_layout} {
		
	hwc hwd page makecurrent $pageId;
	hwc hwd page current layout=$n_layout;

}

proc ::report::utils::addPage {t} {
		
	hwc hwd page add title=Untitled;
	set n_page [prjH$t GetNumberOfPages];
	hwc hwd page makecurrent $n_page;
	
	return $n_page
	
}

proc ::report::utils::change_client {t winId client} {
		
	prjH$t GetPageHandle pageH$t [prjH$t GetActivePage ];
	pageH$t GetWindowHandle winH$t $winId;
	winH$t SetClientType $client;
	winH$t ReleaseHandle;
	pageH$t ReleaseHandle;

}

proc ::report::utils::getSubdirectory {inputDir} {

	set dir_list [glob -directory $inputDir -type d *];
	
}


proc ::report::utils::getNumOfPage {} {

	set t [clock click];
	hwi OpenStack;
	hwi GetSessionHandle sessH$t;
	sessH$t GetProjectHandle prjH$t;
	set n_pages [prjH$t GetNumberOfPages];
	hwi CloseStack;
	
	return $n_pages
}


proc ::report::utils::setPageTitle {title n_page_start n_page_end} {

	set t [clock click];
	hwi OpenStack;
	hwi GetSessionHandle sessH$t;
	sessH$t GetProjectHandle prjH$t;
	
	if {$n_page_start == 1} {
		set n_page 0;
	} else {
		set n_page $n_page_start;
	}
	
	for {set i [expr $n_page+1]} {$i <= $n_page_end} {incr i} {
		#prjH$t GetPageHandle pageH$t [prjH$t GetActivePage];
		prjH$t GetPageHandle pageH$t $i;
		pageH$t SetTitle $title;
		pageH$t SetTitleDisplayed true;
		
		pageH$t ReleaseHandle;
	}
	
	hwi CloseStack;
}


