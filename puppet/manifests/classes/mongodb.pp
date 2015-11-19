class mongodb {


   file { "/vagrant/mongodb":
        ensure => directory,
        before => Exec["install_mongodb"]
    }
   

   exec { "install_mongodb":
        command => "sudo apt-get install -y mongodb-org",
        cwd => "/vagrant",
        user => "vagrant",
        path => "/usr/bin/:/bin/",
        logoutput => true,
        timeout => '300'
    } 

    exec { "create_dir_data_db":
    	cwd => "/vagrant",
    	command => "mkdir -p ./data/db",
    	command => ">chmod 755 ./data/db",
    	command => "mongod --dbpath ./data/db",
    	user => "vagrant",
        logoutput => true,
        timeout => '0'
    }



   exec { "start_mongodb":
        command => "sudo service mongod start",
        cwd => "/vagrant",
        user => "vagrant",
        path => "/usr/bin/:/bin/",
        logoutput => true,
        timeout => '0'
   }  

}            