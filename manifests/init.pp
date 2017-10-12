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
  $port                       = '443',
  $config_name                = 'Servers',
  $collect_storefiles         = true,
  $collect_moduleloads        = true,
  $collect_moduleinfo         = true,
  $collect_filemods           = true,
  $collect_regmods            = true,
  $collect_netconns           = true,
  $collect_processes          = true,
  $collect_crossprocess       = true,
  $collect_emetevents         = true,
  $collect_processusercontext = true,
  $collect_datafilewrites     = true,
  $sensor_backendserver       = "https://${server}:${port}",
  $cb_servercert              = undef,
  $sensor_clientcert          = undef,
  $sensor_clientkey           = undef,
  $max_licenses               = '-1',
  $sensor_version             = 'Manual',
  $quota_event_logpercent     = '1',
  $quota_event_logbytes       = '1073741824',
  $quota_store_filebytes      = '1073741824',
  $quota_store_filepercent    = '1',
  $vdi_enabled                = false,
  $tamper_level               = false,
  $alert_criticality          = '3.0',
  $sensor_exename             = '',
  $process_filter_level       = true,
  $filter_known_dlls          = false,
  $dont_ignore_cbserver       = false,
  $paths_to_ignore            = '',
  $users_to_ignore            = '',
  $proxy                      = '',
  $config_dir                 = '/var/lib/cb',
  $owner                      = 'root',
  $group                      = 'root',
  $log_dir                    = '/var/log/',
  $service_name               = 'cbdaemon',
  $service_ensure             = 'running',
  $service_enable             = true,
  $service_hasrestart         = true,
  $service_hasstatus          = true,
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
