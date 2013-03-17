class nginx::packages( $ensure = "" ) {

    $packages = [ "nginx", "perl", ]
    package { $packages: ensure => $ensure }
}
