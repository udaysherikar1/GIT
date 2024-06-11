
catch {namespace delete ::antolin::utils}
namespace eval ::antolin::utils {

}

proc ::antolin::utils::listDirectories {directory} {
    set result [list]
    
    foreach item [glob -nocomplain -directory $directory *] {
        if {[file isdirectory $item]} {
            lappend result $item
            set subdirs [listDirectories $item]
            foreach subdir $subdirs {
                lappend result $subdir
            }
        }
    }
    
    return $result
}

proc ::antolin::utils::getNestedSubDirs {rootDirectory} {

	set directories [listDirectories $rootDirectory]
	
	#foreach dir $directories {
	#	puts $dir
	#}
	
	
	return $directories

}

# set rootDirectory {C:\WorkingDir\WIP\Mics\Models}
# ::antolin::utils::getNestedSubDirs $rootDirectory
