class init {

    #group { "puppet":
    #    ensure => "present",
    #}

    # Update the system
    exec { "update-apt":
        command => "sudo apt-get update",
    }

    # Install the first set of dependencies from apt
    package {
        ["mongodb", "maven", "solr-jetty", "tomcat7", "git"]:
        ensure => installed,
        require => Exec['update-apt'] # The system update needs to run first
    }
}
