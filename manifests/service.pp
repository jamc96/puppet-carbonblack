# == Class: carbonblack::config
#
class carbonblack::service(
  $service_name       = $::carbonblack::service_name,
  $service_ensure     = $::carbonblack::service_ensure,
  ) {
  # resources
  service { $service_name:
    ensure     => $service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
