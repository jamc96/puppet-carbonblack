# Class: carbonblack
# ===========================
#
# Full description of class carbonblack here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'carbonblack':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class carbonblack(
  $package_name     = $::carbonblack::params::package_name,
  $package_ensure   = 'present',
  $package_provider = 'rpm',
  $package_dir      = '/opt/cbsensor/',
  $package_source   = "${package_dir}/${package_name}",
  $repo_name        = 'cb-linux-sensor',
  $repo_ensure      = 'present',
  $repo_provider    = 'rpm',
  $repo_source      = undef,

) inherits carbonblack::params {

    if !$repo_source{
      fail('respository source is required for installation')
    }
  # carbonblack dependencies
  class { '::carbonblack::install': } ->
  class { '::carbonblack::config': } ~>
  class { '::carbonblack::service': } ->
  Class['::carbonblack']
}
