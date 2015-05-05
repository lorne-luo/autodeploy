# *** install 7-zip on windows ***
# 2013.10.31 by Lorne

class windows_7z { 
	$root_path='C:\\AutoDeploy'

	file { ["$root_path\\libs", "$root_path\\libs\\windows_7z",]:
		ensure => "directory",
		mode => 777,
		require => File[$root_path],
	}
	
	if $operatingsystem == "windows" {
		#check 32bit or 64bit
        if $architecture  == 'x64' {
			file { "$root_path\\libs\\windows_7z\\7z920-x64.msi":
				ensure => present,
				source => "puppet:///libs/windows_7z/7z920-x64.msi",
				require => File["$root_path\\libs\\windows_7z"],
				notify => Package["7z"],
			}
			package {"7z":
				ensure => installed,
				provider => "windows",
				source => "$root_path\\libs\\windows_7z\\7z920-x64.msi",
				require => File["$root_path\\libs\\windows_7z\\7z920-x64.msi"],
			}
        }else{
			file { "$root_path\\libs\\windows_7z\\7z920.msi":
				ensure => present,
				source => "puppet:///libs/windows_7z/7z920.msi",
				require => File["$root_path\\libs\\windows_7z"],
				notify => Package["7z"],
			}
			package {"7z":
				ensure => installed,
				provider => "windows",
				source => "$root_path\\libs\\windows_7z\\7z920.msi",
				require => File["$root_path\\libs\\windows_7z\\7z920.msi"],
			}
        }
	}

#	exec { 'extracting':
#		command => "$zip x $local_package -r -y -aoa -oC:\\inetpub\\wwwroot App",
#		require => Package['7z']
#	}
#C:\Program Files\7-Zip\7z.exe

}
