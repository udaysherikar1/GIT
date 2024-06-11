catch {namespace delete ::antolin::autoEmail}
namespace eval ::antolin::autoEmail {

}

proc ::antolin::autoEmail::ChkPythonInstallation {} {
	if {[file exists [auto_execok python]]} {
		puts "Python is installed."
		return 0
	} else {
		puts "Python is not installed."
		return 1
	}
}

proc ::antolin::autoEmail::check_py_win32com_library {} {

	#just build the pythonLibraryCheck text file path 
	set pyLibraryChk_text [file join $::env(HOME) pythonLibraryCheck.txt];
	catch {file delete -force $pyLibraryChk_text};
	
	set pyLibraryChk_Path [file join $::env(HOME) libraryChk.py];
	catch {file delete -force $pyLibraryChk_Path};
	#write python code to check if 
	set fo [open $pyLibraryChk_Path w];
	puts $fo "import os"
	puts $fo "home_directory = os.path.expanduser(\"~\")"
	puts $fo "file_path = os.path.join(home_directory, \"pythonLibraryCheck.txt\")"
	puts $fo "try:"
	puts $fo "\timport win32com.client as win32"
	puts $fo "except ImportError:"
	puts $fo "\twith open(file_path, 'w') as file:"
	puts $fo "\t\tfile.write(\"pywin32 is NOT available\")"
	close $fo
	
	exec cmd.exe /c $pyLibraryChk_Path
	
	#catch {file delete -force $pyLibraryChk_Path};
	
	if {![file exists $pyLibraryChk_text]} {
		puts "python win32com library available "
		return 0
	} else {	
		return 1
	}
}


proc ::antolin::checkOutlookInstallation {} {
		
	#just build the pythonLibraryCheck text file path 
	set outlookChk_text [file join $::env(HOME) outlookCheck.txt];
	catch {file delete -force $outlookChk_text};
	
	set pyOutlook_Path [file join $::env(HOME) checkOutlook.py];
	catch {file delete -force $pyOutlook_Path};
	
	set fo [open $pyOutlook_Path w];
	puts $fo "import os"
	puts $fo "import winreg"
	puts $fo "home_directory = os.path.expanduser(\"~\")"
	puts $fo "file_path = os.path.join(home_directory, \"pythonOutlookCheck.txt\")"
	puts $fo "try:"
	puts $fo "\twith winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, \"Software\\Microsoft\\Office\\Outlook\", 0, winreg.KEY_READ) as key:"
	#puts $fo "\t\treturn True"
	#puts $fo "except FileNotFoundError:"
	puts $fo "except:"
	puts $fo "\twith open(file_path, 'w') as file:"
	puts $fo "\t\tfile.write(\"Outlook is NOT available\")"
	close $fo;
	
	exec cmd.exe /c $pyOutlook_Path
	
	catch {file delete -force $pyOutlook_Path};
	
	if {![file exists $outlookChk_text]} {
		puts "Microsoft Outlook is installed"
		return 0
	} else {	
		return 1
	}

}

proc ::antolin::autoEmail::SendOutlookEmail {log_filepath} {
	
	set username [set ::env(USERNAME)]
		
	set pySendEmail_Path [file join $::env(HOME) sendOutlookEmail.py];
	catch {file delete -force $pySendEmail_Path};
	
	set fo [open $pySendEmail_Path w];
	puts $fo "import win32com.client as win32"
	puts $fo "outlook = win32.Dispatch('outlook.application')"
	puts $fo "mail = outlook.CreateItem(0)"
	puts $fo "mail.To = 'uday.sherikar@grupoantolin.com'"
	puts $fo "mail.Subject = 'Log of Pamcrash - Thickess assignemnt :  $username'"
	#puts $fo "mail.Subject = 'Test message'"
	puts $fo "mail.Body = 'Log generated for Pamcrash - Thickess assignemnt PA tool'"
	puts $fo "attachment = \"$log_filepath\""
	puts $fo "mail.Attachments.Add(attachment)"
	puts $fo "mail.Send()"
	close $fo;
	
	#execute python script to send logfile to uday.sherikar@antolin.com
	exec cmd.exe /c $pySendEmail_Path
	
	catch {file delete -force $pySendEmail_Path};
}