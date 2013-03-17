class nginx::packages( $ensure = "" ) {

    $packages = [ "nginx", ]
    package { $packages: ensure => $ensure }
}
