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

file {'config-file':
  ensure => present,
  path   => '/tmp/config-file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/yourmodule/config-file',
}
}
