class nginx::configs ( $workers = "", $nginx_user = "", $ensure = "" ) {

    file {
        "/etc/nginx/nginx.conf":
            ensure  => $ensure,
            content => template( "nginx/nginx.conf.erb" ),
            require => Class[ "nginx::packages" ];

        "/etc/nginx/mime.types":
            ensure  => $ensure,
            source  => "puppet:///modules/nginx/mime.types",
            require => File[ "/etc/nginx/nginx.conf" ];

        "/etc/logrotate.d/nginx":
            ensure  => $ensure,
            source  => "puppet:///modules/nginx/nginx.logrotate",
            require => File[ "/etc/nginx/nginx.conf" ];

        "/etc/nginx/cert":
            ensure  => "directory",
            require => File[ "/etc/nginx/nginx.conf" ];

        "/etc/nginx/conf.d/default.conf":
            ensure  => absent,
            require => File[ "/etc/nginx/nginx.conf" ];
    }
}
