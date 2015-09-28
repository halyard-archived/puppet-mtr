# == Class: mtr
#
# Install MTR and set it to be run-able by non-root
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
