require 'sinatra'

def delete_folder(full_path) 
	puts `powershell remove-item \'\"#{full_path}\'\" -force -recurse`
end

def delete_file(full_path) 
	puts `powershell remove-item \'\"#{full_path}\'\" `
end

def clear_firefox
 firefoxdir1='C:\Users\administrator\AppData\Local\Mozilla\Firefox\Profiles'
 firefoxdir2='C:\Users\administrator\AppData\roaming\Mozilla\Firefox\Profiles'
 firefoxfile='C:\Users\administrator\AppData\roaming\Mozilla\Firefox\Profiles.ini'
 delete_folder(firefoxdir1)
 delete_folder(firefoxdir2)
 delete_file(firefoxfile)
end
 
def clear_opera
	opera1 = 'C:\Users\Administrator\AppData\Roaming\Opera Software\Opera Stable'
	opera2 = 'C:\Users\Administrator\AppData\Local\Opera Software\Opera Stable'
	delete_folder(opera1)
	delete_folder(opera2)
end

def clear_chrome
	chromedir1 = 'C:\Users\administrator\AppData\Local\Google\Chrome\User Data'
	chromedir2 = 'C:\Users\administrator\Local Settings\Application Data\Google\Chrome\User Data\Default'
	delete_folder(chromedir1)
	delete_folder(chromedir2)
end

def clear_safari
	safaridir1='C:\Users\Administrator\AppData\Local\Apple Computer\safari'
	safaridir2='C:\Users\Administrator\AppData\Roaming\Apple Computer\Safari'
	delete_folder(safaridir1)
	delete_folder(safaridir2)
end

def clear_ie
	system("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255")
	system("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351")
end

def clear_yandex
	yandexdir1='C:\Users\Administrator\AppData\Local\Yandex\YandexBrowser\User Data\Default'
	delete_folder(yandexdir1)
end

def clear_browser(browser) 
	case browser
	when "firefox"
		clear_firefox
	when "opera"
		clear_opera
	when "chrome"
		clear_chrome
	when "safari"
		clear_safari
	when "ie"
		clear_ie
	when "yandex"
		clear_yandex
	end
end

def stop_browser(name)
	`powershell "get-process | where processname -like #{name} | stop-process -Force"`
end

def start_browser(name, url) 
	system("start #{name} #{url}")
end
	
get '/start' do
	start_browser(params["browser"],params["url"])
end

get '/stop' do
	stop_browser(params["browser"])
	clear_browser(params["browser"])
end
