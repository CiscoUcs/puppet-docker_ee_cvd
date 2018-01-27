class docker_ee_cvd::docker::params inherits docker_ddc::params {
    $ucp_username            = 'admin'
    $ucp_password            = 'puppetlabs'
    $ucp_controller_port     = '19002'
    # $ucp_version             = '2.2.5'
    $ucp_version             = '2.1.4'
    # $dtr_version             = '2.4.1'
    $dtr_version             = 'latest'
    $docker_socket_path      = '/var/run/docker.sock'
    $license_file            = '/etc/docker/subscription.lic'
    $external_ca             = false
    $package_source_location = 'https://storebits.docker.com/ee/m/sub-4fc3291d-85c6-4f54-8cd0-cc3cdcd9ae5a/centos/7/x86_64/stable-17.06/'
    $package_key_source      = 'https://storebits.docker.com/ee/m/sub-4fc3291d-85c6-4f54-8cd0-cc3cdcd9ae5a/centos/gpg'
    $package_repos           = 'stable-17.06'
    #it's a temporary fix
    $local_client            = true
}
