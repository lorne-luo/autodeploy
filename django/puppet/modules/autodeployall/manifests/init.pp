# *** auto deploy all in one package ***
# 2013.11.1 by Lorne

class autodeployall( $package_filename, $config_filename, $component_name ) { 
	
# *** create folder to store deploy package ***

	file { 'C:\\AutoDeploy':
		ensure => directory,
		mode => 777,
	}
	
	file {'C:\\AutoDeploy\\Launcher':
        	source => 'puppet:///launcher/',
        	ensure => directory,
			recurse => true,
			mode => 777,
        	require => File['C:\\AutoDeploy'],
	}
	
	file {'C:\\AutoDeploy\\Package':
        	source => 'puppet:///package/',
        	ensure => directory,
        	require => File['C:\\AutoDeploy'],
	}
	
	file {'C:\\AutoDeploy\\Config':
        	source => 'puppet:///config/',
        	ensure => directory,
        	require => File['C:\\AutoDeploy'],
	}
	
# *** copy package & config to local disk ***
	$local_package="C:\\AutoDeploy\\Package\\$package_filename"
	file { $local_package:
		ensure => present,
		source => "puppet:///package/$package_filename",
		require => File['C:\\AutoDeploy\\Package'],
	}
	
	$local_config="C:\\AutoDeploy\\Config\\$config_filename"
	file { $local_config:
		ensure => present,
		source => "puppet:///config/$config_filename",
		require => File['C:\\AutoDeploy\\Config'],
	}
	
# *** run deploy launcher ***
#	file {'C:\\AutoDeploy\\Launcher\\Launcher.exe':
#			mode => 777,
#        	require => File['C:\\AutoDeploy\\Launcher'],
#	}

	notify {"C:\\AutoDeploy\\Launcher\\Launcher.exe $config_filename":}	
	exec { 'RunDeployLauncher':
		command => "C:\\AutoDeploy\\Launcher\\Launcher.exe $config_filename $component_name",
		logoutput => true,
		require => File['C:\\AutoDeploy\\Launcher', $local_package, $local_config]
	}
	

}
