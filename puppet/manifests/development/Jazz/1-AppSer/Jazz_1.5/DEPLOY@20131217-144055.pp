node 'cnemoptestapp2'{
    
    class {"autodeploycomponent":
        component_name => 'DataImport',
        package_filename => 'product_package/Jazz/DataImport/DataImport_1.4.zip',
        component_config_filename => 'product_config/[SP1]SE_China/Jazz[1.4]/[1]DataImport@cnemoptestapp2.config',
        kit_config_filename => 'product_config/[SP1]SE_China/Jazz[1.4]/[1]DataImport@cnemoptestapp2.xml',
        kit_package_filename =>'deploy_kit/Tango/Tango_1.4.zip',
        kit_name =>'Tango',
    }

}

node 'cnkaradev-it'{

	file { "C:\\test2":
		ensure => "directory",
		mode => 777,
	}
	file { ["C:\AutoDeploy","C:\AutoDeploy\product_config", "C:\AutoDeploy\product_config\1-AppSer","C:\AutoDeploy\product_config\1-AppSer\Jazz_1.5",
            "C:\AutoDeploy\deploy_kit", "C:\AutoDeploy\deploy_kit\Tango","C:\AutoDeploy\deploy_kit\Tango\Tango_1.5.zip",]:
        ensure => directory,
        mode => 777,
    }

}
node 'cnkaradev-it2'{
    
    class {"autodeploycomponent":
        component_name => 'App',
        package_filename => 'product_package/Jazz/App/App_1.4.zip',
        component_config_filename => 'product_config/[SP1]SE_China/Jazz[1.4]/[1]App@cnkaradev-it.config',
        kit_config_filename => 'product_config/[SP1]SE_China/Jazz[1.4]/[1]App@cnkaradev-it.xml',
        kit_package_filename =>'deploy_kit/Tango/Tango_1.4.zip',
        kit_name =>'Tango',
    }

}

