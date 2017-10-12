# == Class: carbonblack::config
#
class carbonblack::install(
    $package_name     = $::carbonblack::package_name,
    $package_ensure   = $::carbonblack::package_ensure,
    $package_provider = $::carbonblack::package_provider,
    $package_source   = $::carbonblack::package_source,
    $repo_name        = $::carbonblack::repo_name,
    $repo_ensure      = $::carbonblack::repo_ensure,
    $repo_provider    = $::carbonblack::repo_provider,
    $repo_source      = $::carbonblack::repo_source,
  ) {
  # Repository Installation
  package { $repo_name:
    ensure   => $repo_ensure,
    provider => $repo_provider,
    source   => $repo_source,
    before   => Package[$package_name],
  }
  # Package installation
  package { $package_name:
    ensure   => $package_ensure,
    provider => $package_provider,
    source   => $package_source,
    require  => Package[$repo_name],
  }
}
