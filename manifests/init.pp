class nginx ( 
                $workers         = "4", 
                $nginx_user      = "nginx", 
                $ensure_service  = "running",
                $ensure_packages = "installed",
                $ensure_configs  = "present",
                $service_path    = "/etc/init.d/nginx",
            )
{

    case $operatingsystem {
        centos, redhat: { }
        default: { fail("Uknown operating system. This currently
                         only supports rhel & centos.") }
    }

    class { nginx::packages: ensure     => $ensure_packages }
    class { nginx::service:  ensure     => $ensure_service }
    class { nginx::scripts:  service    => $service_path }
    class { nginx::configs:  workers    => $workers, 
                             nginx_user => $nginx_user,
                             ensure     => $ensure_configs, }
}
