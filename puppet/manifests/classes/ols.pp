class ols {

   # group { "puppet":
   #     ensure => "present",
   # }

    file { "/vagrant/ols":
        ensure => directory,
        before => Exec["download_ols"]
    }

    exec { "download_ols":
        command => "git clone https://github.com/EBISPOT/OLS.git",
        cwd => "/vagrant",
        user => "vagrant",
        require => Package["git"],
        logoutput => true,
        timeout => '0'
    }


}