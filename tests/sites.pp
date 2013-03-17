    include nginx

    # Setting up a basic virtual host.
    # Please note: "default_vhost" can be "true" or 
    # "false" but only one vhost can be the default.

    nginx::site { "test-1.averna.id.au":
      aliases       => [ "www.test-1.averna.id.au" ],
      default_vhost => true,
      root          => "/var/www/test-1.averna.id.au",
      owner         => "sarah",
      group         => "sarah",
    }


    # "rewrite_missing" is used when using a static site which 
    # rewites requrests from "/some-request" to "/some-request.html".

    nginx::site { "test-2.averna.id.au":
      rewrite_missing => true,
      root            => "/var/www/test-2.averna.id.au",
      owner           => "sarah",
      group           => "sarah",
    }


    # "rewrites" allows you to add rewrites to the "/" location.

    nginx::site { "test-3.averna.id.au":
      rewrites => [ '^(.*)   http://$host/something$1 permanent', ],
      root     => "/var/www/test-3.averna.id.au",
      owner    => "sarah",
      group    => "sarah",
    }


    # Backend application support with either a unix socket or 
    # ip addresses with a port.

    nginx::site { "test-4.averna.id.au":
      aliases   => [ "www.test-4.averna.id.au" ],
      root      => "/var/www/test-4.averna.id.au/static",
      upstreams => [ "unix:/var/run/test-4.sock" ],
      owner     => "sarah",
      group     => "sarah",
    }

    nginx::site { "test-5.averna.id.au":
      aliases   => [ "www.test-5.averna.id.au" ],
      root      => "/var/www/test-5.averna.id.au",
      upstreams => [ "127.0.0.1:8053" ],
      owner     => "sarah",
      group     => "sarah",
    }


    # Provide a statc location & static alias using the static hash.
    # This is used for a directory of static files which will then be 
    # served directly by nginx.
    # Please note: These files will be cached indefinitely.

    nginx::site { "test-6.averna.id.au":
      aliases       => [ "www.test-6.averna.id.au" ],
      root          => "/var/www/test-6.averna.id.au/static",
      static        => [ {
                            location => "/var/www/test-6.averna.id.au/static",
                            alias    => "/static",
                         },
                         {
                            location => "/var/www/test-6.averna.id.au/static2",
                            alias    => "/static2",
                         },
                       ],
      upstreams     => [ "unix:/var/run/test-6.sock" ],
      owner         => "sarah",
      group         => "sarah",
    }


    # Using "ssl" you may also setup vhosts with ssl certs.
    # Please note: This will by default redirect all http requests to https.
    # Also, "ssl_cert" and "ssl_key" apply the path to cert & key in the vhost.
    # So you'll still need to ensure the cert & key are actually present on the
    # server.

    nginx::site { "test-7.averna.id.au":
      root     => "/var/www/test-7.averna.id.au",
      ssl      => true,
      ssl_cert => "/etc/nginx/cert/test-7.averna.id.au.pem",
      ssl_key  => "/etc/nginx/cert/test-7.averna.id.au.key",
      owner    => "sarah",
      group    => "sarah",
    }
