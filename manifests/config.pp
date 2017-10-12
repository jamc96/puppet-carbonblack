# == Class: carbonblack::config
#
class carbonblack::config(
  $config_name                = $::carbonblack::config_name,
  $collect_storefiles         = $::carbonblack::collect_storefiles,
  $collect_moduleloads        = $::carbonblack::collect_moduleloads,
  $collect_moduleinfo         = $::carbonblack::collect_moduleinfo,
  $collect_filemods           = $::carbonblack::collect_filemods,
  $collect_regmods            = $::carbonblack::collect_regmods,
  $collect_netconns           = $::carbonblack::collect_netconns,
  $collect_processes          = $::carbonblack::collect_processes,
  $collect_crossprocess       = $::carbonblack::collect_crossprocess,
  $collect_emetevents         = $::carbonblack::collect_emetevents,
  $collect_processusercontext = $::carbonblack::collect_processusercontext,
  $collect_datafilewrites     = $::carbonblack::collect_datafilewrites,
  $sensor_backendserver       = $::carbonblack::sensor_backendserver,
  $cb_servercert              = $::carbonblack::cb_servercert,
  $sensor_clientcert          = $::carbonblack::sensor_clientcert,
  $sensor_clientkey           = $::carbonblack::sensor_clientkey,
  $max_licenses               = $::carbonblack::max_licenses,
  $sensor_version             = $::carbonblack::sensor_version,
  $quota_event_logpercent     = $::carbonblack::quota_event_logpercent,
  $quota_event_logbytes       = $::carbonblack::quota_event_logbytes,
  $quota_store_filebytes      = $::carbonblack::quota_store_filebytes,
  $quota_store_filepercent    = $::carbonblack::quota_store_filepercent,
  $vdi_enabled                = $::carbonblack::vdi_enabled,
  $tamper_level               = $::carbonblack::tamper_level,
  $sensor_exename             = $::carbonblack::sensor_exename,
  $process_filter_level       = $::carbonblack::process_filter_level,
  $filter_known_dlls          = $::carbonblack::filter_known_dlls,
  $config_dir                 = $::carbonblack::config_dir,
  $owner                      = $::carbonblack::owner,
  $group                      = $::carbonblack::group,
  $config_ensure              = $::carbonblack::config_ensure,
  $log_dir                    = $::carbonblack::log_dir,
) {
  # resources
  File{
    ensure => $config_ensure,
    owner  => $owner,
    group  => $group,
  }
  file {
    $config_dir:
    ensure  => directory,
    recurse => true;
    'sensorsettings':
    mode    => '0644',
    path    => "${$config_dir}/sensorsettings.ini",
    content => template("${module_name}/sensorsettings.ini.erb");
    'oldsensor':
    ensure => absent,
    path   => "${log_dir}/cb/sensor";
    'cbsensor':
    ensure => directory,
    path   => "${log_dir}/cbsensor";
  }
}
