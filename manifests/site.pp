define nginx::site ( $root, 
                     $owner                = "",
                     $group                = "",
                     $client_max_body_size = "10m",
                     $static               = [],
                     $default_vhost        = false,
                     $autoindex            = false,
                     $rewrite_missing      = false,
                     $upstreams            = [],
                     $aliases              = [],
                     $confs                = [],
                     $rewrites             = [],
                     $ssl                  = false,
                     $ssl_cert             = "",
                     $ssl_key              = ""
                   )
{
    $root_parent          = inline_template( "<%= root.match(%r!(.+)/.+!)[1] %>" )

    if !defined ( File[ $root_parent ] ) {

        file { $root_parent:
            ensure => directory,
            owner  => $owner,
            group  => $group,
        }
    }

    if !defined ( File[ $root ] ) {
        
        file { $root:
            ensure  => directory,
            owner   => $owner,
            group   => $group,
            require => File[ $root_parent ],
        }
    }

    file {
        "/etc/nginx/conf.d/${name}.conf":
        ensure  => "present",
        content => template( "nginx/site.conf.erb" ),
        require => [ File[ $root ], Class[ "nginx::packages" ] ],
        notify  => Class[ "nginx::service" ];
    }
}
