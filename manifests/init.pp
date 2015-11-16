class vmutil (
  $hosts,
  $xe_path,
  $password_file = "/etc/vmutil-password",
) {

  $packagelist = ['mercurial', 'dialog']

  package {
    $packagelist:
      ensure => installed
  }


  vcsrepo { '/usr/local/lib/vmutil':
    ensure   => present,
    provider => hg,
    source   => 'https://bitbucket.org/mas90/vmutil',
    owner    => 'root',
    group    => 'root'
  }
  file { '/usr/local/bin/vmutil':
    ensure => 'link',
    target => '/usr/local/lib/vmutil/vmutil',
  }
  file { '/usr/local/bin/xe-where-is-my-master':
    ensure => 'link',
    target => '/usr/local/lib/vmutil/xe-where-is-my-master',
  }
  file { '/usr/local/bin/xe':
    ensure => 'link',
    target => $xe_path
  }
  file { '/etc/vmutil.password':
    ensure => 'link',
    target => $password_file,
  }
  file { $password_file:
    mode => 600
  }


  file { '/etc/vmutil.conf':
    content => template("vmutil/vmutil.conf.erb")
  }
}
