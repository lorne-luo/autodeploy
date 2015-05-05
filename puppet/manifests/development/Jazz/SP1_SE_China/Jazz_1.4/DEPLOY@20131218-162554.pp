node 'cnkaradev-it'{
    include windows_7z
    
    autodeploycomponent {"4_App@cnkaradev-it":
        product_version => 'Jazz_1.4',
        service_provider => 'SP1_SE_China',
        component_name => 'App',
        package_filename => 'product_package/Jazz_1.4/App_1.4.zip',
        component_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/4_App@cnkaradev-it.config',
        kit_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/4_App@cnkaradev-it.xml',
        kit_package_filename =>'deploy_kit/Tango/Tango_1.4.zip',
        kit_name =>'Tango',
        kit_version =>'1.4',
    }

    autodeploycomponent {"4_DataImport@cnkaradev-it":
        product_version => 'Jazz_1.4',
        service_provider => 'SP1_SE_China',
        component_name => 'DataImport',
        package_filename => 'product_package/Jazz_1.4/DataImport_1.4.zip',
        component_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/4_DataImport@cnkaradev-it.config',
        kit_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/4_DataImport@cnkaradev-it.xml',
        kit_package_filename =>'deploy_kit/Tango/Tango_1.4.zip',
        kit_name =>'Tango',
        kit_version =>'1.4',
    }

}

