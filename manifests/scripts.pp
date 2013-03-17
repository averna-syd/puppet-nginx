class nginx::scripts ( $service = "" ) {

    file { "check_script":
        owner   => "root",
        group   => "root",
        mode    => "0750",
        path    => "/usr/local/sbin/check_nginx.pl",
        source  => "puppet:///modules/nginx/scripts/check_nginx.pl",
    }

    exec { "check_nginx":
        command => "/usr/local/sbin/check_nginx.pl --service $service",
        require => [ File[ "check_script" ], Class[ "nginx::packages", "nginx::configs" ], ],
    }
}
