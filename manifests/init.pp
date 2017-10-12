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
  $package_name_flg           = $::carbonblack::params::package_name,
  $package_name               = 'cbsensor',
  $package_ensure             = 'present',
  $package_provider           = 'rpm',
  $package_dir                = '/opt/cbsensor/',
  $package_source             = "${package_dir}/${package_name_flg}",
  $repo_name                  = 'cb-linux-sensor',
  $repo_ensure                = 'present',
  $repo_provider              = 'rpm',
  $repo_source                = undef,
  $server                     = undef,
  $config_name                = 'Servers',
  $collect_storefiles         = '1',
  $collect_moduleloads        = '1',
  $collect_moduleinfo         = '1',
  $collect_filemods           = '1',
  $collect_regmods            = '1',
  $collect_netconns           = '1',
  $collect_processes          = '1',
  $collect_crossprocess       = '1',
  $collect_emetevents         = '1',
  $collect_processusercontext = '1',
  $collect_datafilewrites     = '1',
  $sensor_backendserver       = "https://${server}:443",
  $cb_servercert              = undef,
  $sensor_clientcert          = undef,
  $sensor_clientkey           = undef,
  $max_licenses               = '-1',
  $sensor_version             = 'Manual',
  $quota_event_logpercent     = '1',
  $quota_event_logbytes       = '1073741824',
  $quota_store_filebytes      = '1073741824',
  $quota_store_filepercent    = '1',
  $vdi_enabled                = '0',
  $tamper_level               = '0',
  $alert_criticality          = '3.0',
  $sensor_exename             = '',
  $process_filter_level       = '1',
  $filter_known_dlls          = '0',
  $dont_ignore_cbserver       = '0',
  $paths_to_ignore            = '',
  $users_to_ignore            = '',
  $proxy                      = '',
  $config_dir                 = '/var/lib/cb',
  $owner                      = 'root',
  $group                      = 'root',
  $log_dir                    = '/var/log/',
) inherits carbonblack::params {

    if !$repo_source{
      fail('respository source is required for installation')
    }
    if !$server{
      fail('carbon black server is required')
    }
    if !$cb_servercert{
      fail('carbon black server cert is required')
    }
    if !$sensor_clientcert{
      fail('carbon black sensor client cert is required')
    }
    if !$sensor_clientkey{
      fail('carbon black sensor client key is required')
    }
  # carbonblack dependencies
  class { '::carbonblack::install': } ->
  class { '::carbonblack::config': } ~>
  class { '::carbonblack::service': } ->
  Class['::carbonblack']
}
