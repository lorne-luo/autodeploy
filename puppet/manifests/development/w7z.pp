	if $operatingsystem == "windows" {
		#check 32bit or 64bit
        if $architecture  == 'x64' {
			file { "c:\\7z920-x64.msi":
				ensure => present,
				source => "puppet:///libs/windows_7z/7z920-x64.msi",
				notify => Package["7z"],
			}
			package {"7z":
				ensure => installed,
				provider => "windows",
				source => "c:\\7z920-x64.msi",
				require => File["c:\\7z920-x64.msi"],
			}
        }else{
			file { "c:\\7z920.msi":
				ensure => present,
				source => "puppet:///libs/windows_7z/7z920.msi",
				notify => Package["7z"],
			}
			package {"7z":
				ensure => installed,
				provider => "windows",
				source => "c:\\7z920.msi",
				require => File["c:\\7z920.msi"],
			}
        }
	}