# == Class: mtr
#
# Full description of class mtr here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class mtr (
  $package = 'mtr'
) {
  package { $package:
    install_options => [
      '--build-from-source',
      '--no-gtk+'
    ],
  }

  file { 'mtr-binary':
    path    => "${boxen::config::home}/homebrew/sbin/mtr",
    links   => 'follow',
    owner   => 'root',
    group   => 'wheel',
    mode    => '4755',
    require => Package[$package]
  }
}
