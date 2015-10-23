class solr {

    group { "puppet":
        ensure => "present",
    }


    file { "/vagrant/solr":
        ensure => directory,
        before => Exec["download_solr"]
    }

    exec { "download_solr":
        command => "curl -L http://archive.apache.org/dist/lucene/solr/4.7.1/solr-4.7.1.tgz | tar zx --directory=/vagrant/solr --strip-components 1",
        cwd => "/vagrant",
        user => "vagrant",
        path => "/usr/bin/:/bin/",
        require => Exec["accept_license"],
        logoutput => true,
        timeout => '0'
    }

  file { "/etc/init/solr.conf":
    source => "/vagrant/scripts/etc/init/solr.conf",
    require => Exec["download_solr"]
  }

  file { "/etc/init.d/solr":
    ensure => link,
    target => "/etc/init/solr.conf",
    require => File["/etc/init/solr.conf"],
  }

  service { "solr":
    enable => true,
    ensure => running,
    #path => "/etc/init/solr.conf",
    provider => "upstart",
    #hasrestart => true,
    #hasstatus => true,
    require => [ File["/etc/init/solr.conf"], File["/etc/init.d/solr"], Package["oracle-java8-installer"] ],
  }


}
