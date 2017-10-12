# == Class: carbonblack::config
#
class carbonblack::params {
  # resources
  case $::kernelversion {
    '2.6.32': {
      $package_name = 'setup-redhat6.rpm'
    }
    '3.10.0':{
      $package_name = 'setup-redhat7.rpm'
    }
    default: {
      fail('kernel version is not supported.')
    }
  }
}
