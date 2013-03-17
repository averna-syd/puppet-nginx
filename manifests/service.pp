class nginx::service ( $ensure = "" ) {

    service { "nginx":
        enable      => true,
        ensure      => $ensure,
        hasstatus   => true,
        hasrestart  => true,
        require     => Class[ "nginx::packages", "nginx::configs",
                              "nginx::scripts" ],
    }
}

