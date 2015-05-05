# *** auto deploy component package ***
# 2013.12.16 by Lorne

define autodeploycomponent( $product_version, $service_provider, $component_name, $package_filename, 
							$component_config_filename,$kit_config_filename,$kit_package_filename,$kit_name,
							$kit_version) {
	# local autodeploy system root path
	$root_path="C:\\AutoDeploy"
	
	# following path should keep consistent with /etc/puppet/fileserve.conf
	$component_config = 'component_config'
	$component_package = 'component_package'
	$deploy_kit = 'deploy_kit'
	$product_config = 'product_config'
	$product_package = 'product_package'
	
# **************************** create folder to store deploy package *******************************
	if ! defined(File["$root_path"]) {
	   file { "$root_path": ensure => directory, mode => 777, }
	}
	
	# make deploy config directory tree
	if ! defined(File["$root_path\\$product_config\\$service_provider\\$product_version"]) {
		file { ["$root_path\\$product_config", "$root_path\\$product_config\\$service_provider",
				"$root_path\\$product_config\\$service_provider\\$product_version" ]:
			ensure => "directory",
			mode => 777,
			require => File[$root_path],
		}
	}
	# make component package directory tree
	if ! defined(File["$root_path\\$product_package\\$product_version"]) {
		file { ["$root_path\\$product_package", "$root_path\\$product_package\\$product_version",]:
			ensure => "directory",
			mode => 777,
			require => File[$root_path],
		}
	}
	# make deploy kit directory
	if ! defined(File["$root_path\\$deploy_kit\\$kit_name"]) {
		file { ["$root_path\\$deploy_kit","$root_path\\$deploy_kit\\$kit_name"]:
			ensure => directory,
			mode => 777,
			require => File[$root_path],
		}
	}
	
	# start copy deployment files
	if ! defined(File["$root_path\\$package_filename"]) {
		file {"$root_path\\$package_filename":
				source => "puppet:///$package_filename",
				ensure => present,
				mode => 777,
				require => File["$root_path\\$product_package\\$product_version"],
		}
	}
	if ! defined(File["$root_path\\$component_config_filename"]) {
		file {"$root_path\\$component_config_filename":
				source => "puppet:///$component_config_filename",
				ensure => present,
				mode => 777,
				require => File["$root_path\\$product_config\\$service_provider\\$product_version"],
		}
	}
	if ! defined(File["$root_path\\$kit_config_filename"]) {
		file {"$root_path\\$kit_config_filename":
				source => "puppet:///$kit_config_filename",
				ensure => present,
				mode => 777,
				require => File["$root_path\\$product_config\\$service_provider\\$product_version"],
		}
	}
	if ! defined(File["$root_path\\$kit_package_filename"]) {
		file {"$root_path\\$kit_package_filename":
			source => "puppet:///$kit_package_filename",
			ensure => present,
			mode => 777,
			require => File["$root_path\\$deploy_kit\\$kit_name"],
		}
	}
	
	if ! defined(File["$root_path\\$deploy_kit\\extracted_kit"]) {
		file {"$root_path\\$deploy_kit\\extracted_kit":
			ensure => directory,
			mode => 777,
			require => File["$root_path\\$deploy_kit"],
		}
	}
	
	# extract deploy kit package
	if ! defined(Exec["extract_kit"]) {
		exec { "extract_kit":
			command => "\"C:\Program Files\7-Zip\7z.exe\" x \"$root_path\\$kit_package_filename\" -y -aoa -o\"$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version\"",
			require => [File["$root_path\\$kit_package_filename"]],
			subscribe => File["$root_path\\$kit_package_filename"],
			refreshonly => true,
		}
	}
	
	# elevate kit folder privliage
	if ! defined(File["$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version"]) {
		file {"$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version":
			ensure => directory,
			mode => 777,
			recurse => true,
			require => Exec["extract_kit"],
		}
	}
	
	# run deploy kit
	exec { "run_kit_for_$component_name":
		cwd => "$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version\\",
		command => "$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version\\$kit_name.exe $root_path\\$kit_config_filename",
		logoutput => true,
		require => [File["$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version"],
			Exec["extract_kit"]],
		subscribe => [File["$root_path\\$kit_config_filename"],File["$root_path\\$kit_package_filename"],
			File["$root_path\\$component_config_filename"],File["$root_path\\$package_filename"]],
		returns => [0],
		refreshonly => true,
	}
	
	

	#->
	#notify {"run_command_for_$component_name":
		#message => "$root_path\\$deploy_kit\\extracted_kit\\$kit_name-$kit_version\\$kit_name.exe $root_path\\$kit_config_filename",
		#subscribe => [File["$root_path\\$kit_config_filename"],File["$root_path\\$kit_package_filename"],
		#	File["$root_path\\$component_config_filename"],File["$root_path\\$package_filename"]],
		#refreshonly => true,
	#}
	
	
# *** copy package & config to local disk ***
#	exec { 'extract_kit':
#		command => "$zip x $root_path\\$kit_package_filename -r -y -aoa -o$root_path\\temp App",
#		require => Package['7z']
#	}
	
# *** run deploy launcher ***
#	file {"C:\\AutoDeploy\\Launcher\\Launcher.exe":
#			mode => 777,
#        	require => File["C:\\AutoDeploy\\Launcher"],
#	}

#	notify {"C:\\AutoDeploy\\Launcher\\Launcher.exe $kit_config_filename":}
#	exec { 'RunDeployLauncher':
#		command => "C:\\AutoDeploy\\Launcher\\Launcher.exe $kit_config_filename $component_name",
#		logoutput => true,
#		require => File["C:\\AutoDeploy\\Launcher", $local_package, $local_config]
#	}
	

}

