# *** auto deploy component package ***
# 2013.12.16 by Lorne

class autodeploycomponent($product_version, $service_provider, $component_name, $package_filename, 
							$component_config_filename,$kit_config_filename,$kit_package_filename,$kit_name ) {
	# local autodeploy system root path
	$root_path='C:\\AutoDeploy'
	
	# following path should keep consistent with /etc/puppet/fileserve.conf
	$component_config = 'component_config'
	$component_package = 'component_package'
	$deploy_kit = 'deploy_kit'
	$product_config = 'product_config'
	$product_package = 'product_package'
	
# **************************** create folder to store deploy package *******************************

	file { "$root_path":
		ensure => directory,
		mode => 777,
	}
	
	# make deploy config directory tree
	file { ["$root_path\\$product_config", "$root_path\\$product_config\\$service_provider",
			"$root_path\\$product_config\\$service_provider\\$product_version" ]:
		ensure => "directory",
		mode => 777,
		require => File[$root_path],
	}
	# make component package directory tree
	file { ["$root_path\\$product_package", "$root_path\\$product_package\\$product_version",]:
		ensure => "directory",
		mode => 777,
		require => File[$root_path],
	}
	# make deploy kit directory
	file { ["$root_path\\$deploy_kit","$root_path\\$deploy_kit\\$kit_name"]:
		ensure => directory,
		mode => 777,
		require => File[$root_path],
	}
	
	# start copy deployment files
	file {"$root_path\\$package_filename":
        	source => "puppet:///$package_filename",
        	ensure => present,
			mode => 777,
        	require => File["$root_path\\$product_package\\$product_version"],
	}
	
	file {"$root_path\\$component_config_filename":
        	source => "puppet:///$component_config_filename",
        	ensure => present,
			mode => 777,
        	require => File["$root_path\\$product_config\\$service_provider\\$product_version"],
	}
	
	file {"$root_path\\$kit_config_filename":
        	source => "puppet:///$kit_config_filename",
        	ensure => present,
			mode => 777,
        	require => File["$root_path\\$product_config\\$service_provider\\$product_version"],
	}

    file {"$root_path\\$kit_package_filename":
        	source => "puppet:///$kit_package_filename",
        	ensure => present,
        	require => File["$root_path\\$deploy_kit\\$kit_name"],
	}
	
# *** copy package & config to local disk ***
#	exec { 'extract_kit':
#		command => "$zip x $root_path\\$kit_package_filename -r -y -aoa -o$root_path\\temp App",
#		require => Package['7z']
#	}
	
# *** run deploy launcher ***
#	file {'C:\\AutoDeploy\\Launcher\\Launcher.exe':
#			mode => 777,
#        	require => File['C:\\AutoDeploy\\Launcher'],
#	}

#	notify {"C:\\AutoDeploy\\Launcher\\Launcher.exe $kit_config_filename":}
#	exec { 'RunDeployLauncher':
#		command => "C:\\AutoDeploy\\Launcher\\Launcher.exe $kit_config_filename $component_name",
#		logoutput => true,
#		require => File['C:\\AutoDeploy\\Launcher', $local_package, $local_config]
#	}
	

}

