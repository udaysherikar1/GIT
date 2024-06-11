
catch {namespace delete ::update_fonts}

namespace eval ::update_fonts {

	#set font_size 14;
	#set font_style "72 Black"

}

proc ::update_fonts::updateFontsMain {font_size font_style} {

	set t [clock click];
	hwi OpenStack;
	hwi GetSessionHandle sessionH$t;
	sessionH$t GetProjectHandle projH$t;
	set num_pages [projH$t GetNumberOfPages ];

	for {set n_page 1} {$n_page <= $num_pages} {incr n_page} {

		set t1 [clock click];
		projH$t SetActivePage $n_page
		projH$t GetPageHandle pageH$t1 [projH$t GetActivePage];
		set num_windows [pageH$t1 GetNumberOfWindows];
		
		for {set n_window 1} {$n_window <= $num_windows} {incr n_window} { 
		
			set t2 [clock click];
			pageH$t1 SetActiveWindow $n_window
			pageH$t1 GetWindowHandle winH$t2 [pageH$t1 GetActiveWindow ];
			winH$t2 GetClientHandle clientH$t2
			set clientType [winH$t2 GetClientType ];
			
			if {$clientType == "Animation"} {
				#HV
				::update_fonts::updateHVfonts $t2 $font_size $font_style;
			}
			if { $clientType == "Plot" } {
				#HG
				::update_fonts::updateHGfonts $t2 $font_size $font_style;
			}
		}
	}	

	hwi CloseStack;
}

proc ::update_fonts::updateHVfonts {t2 font_size font_style} {

	if {[clientH$t2 GetActiveModel ] == 0} {
		return
	}
	clientH$t2 GetModelHandle modH$t2 [clientH$t2 GetActiveModel ];
	modH$t2 GetResultCtrlHandle resH$t2;
	set active_counter [resH$t2 GetCurrentContour];
	if {$active_counter == ""} {
		#no counter applied
		return
	}
			
	#clientH$t2 GetNoteList 1
	set note_id [clientH$t2 GetNoteList [clientH$t2 GetActiveModel ]];
	clientH$t2 GetNoteHandle noteH$t2 $note_id
	noteH$t2 GetFontHandle note_font_H$t2
				
	resH$t2 GetContourCtrlHandle contourH$t2;
	contourH$t2 GetLegendHandle legendH$t2;
	#legendH$t GetHeaderAttributeHandle header_attributes_H$t;
	legendH$t2 GetTitleAttributeHandle title_attributes_H$t2;
	legendH$t2 GetNumberAttributeHandle	number_attributes_H$t2;

	title_attributes_H$t2 SetSize $font_size;
	#title_attributes_H$t2 SetSlant "regular";
	title_attributes_H$t2 SetFamily $font_style;
	
	number_attributes_H$t2 SetSize $font_size;
	#number_attributes_H$t2 SetSlant "regular";
	number_attributes_H$t2 SetFamily $font_style;
	
	note_font_H$t2 SetSize $font_size;
	#note_font_H$t2 SetSlant "regular";
	note_font_H$t2 SetFamily $font_style;
	
	
	if {$::GA_Report::cb_BoldFont == 1} {
		title_attributes_H$t2 SetWeight "Bold";
		number_attributes_H$t2 SetWeight "Bold";
		note_font_H$t2 SetWeight "Bold";
	} else {
		title_attributes_H$t2 SetWeight "regular";
		number_attributes_H$t2 SetWeight "regular";
		note_font_H$t2 SetWeight "regular";
	}

	set num_measures [clientH$t2 GetMeasureList [clientH$t2 GetActiveModel ]];
	foreach n_measure $num_measures {
		set t4 [clock click];
		clientH$t2 GetMeasureHandle measureH$t4 $n_measure;
		measureH$t4 GetFontHandle measure_fontH$t4;
		measure_fontH$t4 SetSize $font_size;
		#measure_fontH$t4 SetSlant "regular";
		measure_fontH$t4 SetFamily $font_style;
		
		if {$::GA_Report::cb_BoldFont == 1} {
			measure_fontH$t4 SetWeight "Bold";
		}  else {
			measure_fontH$t4 SetWeight "regular";
		}
	}

	winH$t2 Draw;

}

proc ::update_fonts::updateHGfonts {t2 font_size font_style} {
	#HG
	clientH$t2 GetHorizontalAxisHandle x_axisH$t2 1;
	clientH$t2 GetVerticalAxisHandle y_axisH$t2 1;
	clientH$t2 GetLegendHandle legendH$t2;
	
	set num_notes [clientH$t2 GetNumberOfNotes];
	
	x_axisH$t2 GetLabelFontHandle x_fontH$t2;
	y_axisH$t2 GetLabelFontHandle y_fontH$t2;
	
	x_axisH$t2 GetTicsFontHandle x_tics_fontH$t2;
	y_axisH$t2 GetTicsFontHandle y_tics_fontH$t2;
	
	legendH$t2 GetFontHandle legendFontH$t2;
	
	x_fontH$t2 SetSize $font_size;
	#x_fontH$t2 SetSlant "regular";
	x_fontH$t2 SetFamily $font_style
	
	y_fontH$t2 SetSize $font_size;
	#y_fontH$t2 SetSlant "regular";
	y_fontH$t2 SetFamily $font_style
	
	x_tics_fontH$t2 SetSize $font_size;
	#x_tics_fontH$t2 SetSlant "regular";
	x_tics_fontH$t2 SetFamily $font_style
	
	y_tics_fontH$t2 SetSize $font_size;
	#y_tics_fontH$t2 SetSlant "regular";
	y_tics_fontH$t2 SetFamily $font_style
	
	legendFontH$t2 SetSize $font_size;
	#legendFontH$t2 SetSlant "regular";
	legendFontH$t2 SetFamily $font_style
	
	if {$::GA_Report::cb_BoldFont == 1} {
		x_fontH$t2 SetWeight "Bold";
		y_fontH$t2 SetWeight "Bold";
		x_tics_fontH$t2 SetWeight "Bold";
		y_tics_fontH$t2 SetWeight "Bold";
		legendFontH$t2 SetWeight "Bold";
	} else {
		x_fontH$t2 SetWeight "regular";
		y_fontH$t2 SetWeight "regular";
		x_tics_fontH$t2 SetWeight "regular";
		y_tics_fontH$t2 SetWeight "regular";
		legendFontH$t2 SetWeight "regular";
	}
	
	for {set n_note 1} {$n_note <= $num_notes} {incr n_note} {
		set t3 [clock click];
		clientH$t2 GetNoteHandle noteH$t3 $n_note;
		noteH$t3 GetFontHandle note_fontH$t3;
		
		note_fontH$t3 SetSize $font_size;
		#note_fontH$t3 SetSlant "regular";
		note_fontH$t3 SetFamily $font_style
		if {$::GA_Report::cb_BoldFont == 1} {
			note_fontH$t3 SetWeight "Bold";
		} else {
			note_fontH$t3 SetWeight "regular";
		}
	}
	winH$t2 Draw;
}

# ::update_fonts::updateFontsMain $font_size
