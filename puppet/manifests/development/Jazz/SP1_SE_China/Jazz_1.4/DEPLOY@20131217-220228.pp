node 'cnkaradev-it'{
    
    class {"autodeploycomponent":
        product_version => 'Jazz_1.4',
        service_provider => 'SP1_SE_China',
        component_name => 'App',
        package_filename => 'product_package/Jazz_1.4/App_1.4.zip',
        component_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/[2]App@cnkaradev-it.config',
        kit_config_filename => 'product_config/SP1_SE_China/Jazz_1.4/[2]App@cnkaradev-it.xml',
        kit_package_filename =>'deploy_kit/Tango/Tango_1.4.zip',
        kit_name =>'Tango',
    }


}

