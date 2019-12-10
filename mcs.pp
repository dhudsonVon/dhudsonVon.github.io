# == Class: profiles::mcs
# 
# Profile to manage mcs
class profiles::mcs(

  Array $app_dirs          = [],
  Hash  $package_defaults  = {},
  Hash  $packages          = {},
  Hash  $defaults          = {},

) {

  file { $app_dirs:
    ensure      => directory,
    owner       => root,
    group       => root,
    mode        => '0755',
  }


  create_resources(package, $packages, $package_defaults)

file {'mcsconfig':
  ensure => present,
  path   => '/tmp/mcsconfig.txt',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/yourmodule/mcsconfig.txt',
}

Exec {'configure-mcs':
  command => '/usr/local/mcs/mcs_configure.sh </tmp/mcsconfig.txt',
}

# Ensures that the file is created before running the command
File['mcsconfig'] -> Exec['configure-mcs']

}
