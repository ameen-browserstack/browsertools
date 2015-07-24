require 'sinatra'

def delete_item(full_path)
  full_path =  '/Users/' + `id -un`.chomp + full_path[1..-1]
  system("rm -rf \"#{full_path}\"")
end



def clear_firefox
  firefoxdir1='~/Library/Application Support/Firefox/profiles'
  firefoxdir2='~/Library/Application Support/Firefox/profiles.ini'
  firefoxdir3='~/Library/Caches/Firefox/Profiles'
  delete_item(firefoxdir1)
  delete_item(firefoxdir2)
  delete_item(firefoxdir3)
end

def clear_opera
  operadir1='~/Library/Application Support/com.operasoftware.Opera'
  operadir2='~/Library/Caches/com.operasoftware.Opera'
  operadir3='~/Library/Saved Application State/com.operasoftware.Opera.savedState'
  delete_item(operadir1)
  delete_item(operadir2)
  delete_item(operadir3)
end

def clear_chrome
  chromedir1 = '~/Library/Application Support/Google'
  chromedir2 = '~/Library/Caches/com.google.*'
  chromedir3 = '~/Library/Google'
  chromedir4 = '~/Library/Saved Application State/com.google.Chrome.savedState'
  chromedir5 = '~/Library/Caches/Google'
  delete_item chromedir1
  delete_item chromedir2
  delete_item chromedir3
  delete_item chromedir4
  delete_item chromedir5
end

def clear_safari
  safaridir1 = 'rm -rf ~/Library/Safari; rm -Rf ~/Library/Caches/Apple\ -\ Safari\ -\ Safari\ Extensions\ Gallery; rm -Rf ~/Library/Caches/Metadata/Safari; rm -Rf ~/Library/Caches/com.apple.Safari; rm -Rf ~/Library/Caches/com.apple.WebKit.PluginProcess; rm -Rf ~/Library/Cookies/Cookies.binarycookies; rm -Rf ~/Library/Preferences/Apple\ -\ Safari\ -\ Safari\ Extensions\ Gallery; rm -Rf ~/Library/Preferences/com.apple.Safari.LSSharedFileList.plist; rm -Rf ~/Library/Preferences/com.apple.Safari.RSS.plist; rm -Rf ~/Library/Preferences/com.apple.Safari.plist; rm -Rf ~/Library/Preferences/com.apple.WebFoundation.plist; rm -Rf ~/Library/Preferences/com.apple.WebKit.PluginHost.plist; rm -Rf ~/Library/Preferences/com.apple.WebKit.PluginProcess.plist; rm -Rf ~/Library/PubSub/Database; rm -Rf ~/Library/Saved\ Application\ State/com.apple.Safari.savedState';
  system(safaridir1)
end




def clear_browser(browser)
  clear_opera
  clear_chrome
  clear_safari
  clear_firefox
=begin
  case browser
  when "firefox"
  clear_firefox
  when "opera"
  clear_opera
  when "chrome"
  clear_chrome
  when "safari"
  clear_safari
  end
=end
end

def stop_browser(name)
  name = name.downcase
  if name == "chrome"
    system('killall -9 "Google Chrome"')
  elsif name == "firefox"
    system("killall -9 firefox")
  elsif name == "opera"
    system('killall -9 Opera')
  elsif name == "safari"
    system('killall -9 Safari')
  end
end


def start_browser(name, url)
  name = name.downcase
  case name
  when "chrome"
    system("open -a \"Google Chrome\" 'http://'#{url}")
  when "firefox"
    system("open -a firefox 'http://'#{url}")
  when "opera"
    system("open -a Opera 'http://'#{url}")
  when "safari"
    system("open -a Safari 'http://'#{url}")
  end
end

get '/start' do
  start_browser(params["browser"],params["url"])
end

get '/stop' do
  stop_browser(params["browser"])
  clear_browser(params["browser"])
end



