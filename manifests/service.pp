# == Class: carbonblack::config
#
class carbonblack::service(
  $service_name       = $::carbonblack::service_name,
  $service_ensure     = $::carbonblack::service_ensure,
  $service_enable     = $::carbonblack::service_enable,
  $service_hasrestart = $::carbonblack::service_hasrestart,
  $service_hasstatus  = $::carbonblack::hasstatus,
  ) {
  # resources
  service { $service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => $service_hasrestart,
    hasstatus  => $service_hasstatus,
  }
}
