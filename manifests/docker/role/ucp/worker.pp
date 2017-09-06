class docker_ee_cvd::docker::role::ucp::worker(
  $package_source_location = $docker_ee_cvd::docker::params::package_source_location,
  $package_key_source      = $docker_ee_cvd::docker::params::package_key_source,
  $package_repos           = $docker_ee_cvd::docker::params::package_repos,
  $ntp_server              = $docker_ee_cvd::docker::params::ntp_server,
) inherits docker_ee_cvd::docker::params {

  $ucp_ipaddress_query= 'facts {
    name = "ipaddress" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'
  
  $ucp_controller_port_query = 'facts {
    name = "ucp_controller_port" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_fingerprint_query = 'facts {
    name = "ucp_fingerprint" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_worker_token_query = 'facts {
    name = "ucp_worker_token" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_version_query = 'facts {
    name = "ucp_version" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'
  
  $ucp_hostname_query= 'facts {
    name = "hostname" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master"
    }
  }'
  
  $worker_address      = $facts['networking']['ip']
  $ucp_version         = puppetdb_query($ucp_version_query)[0]['value']
  $ucp_ipaddress       = puppetdb_query($ucp_ipaddress_query)[0]['value']
  $ucp_controller_port = puppetdb_query($ucp_controller_port_query)[0]['value']
  $ucp_worker_token    = puppetdb_query($ucp_worker_token_query)[0]['value']
  $ucp_fingerprint     = puppetdb_query($ucp_fingerprint_query)[0]['value']
  $ucp_controller_node = puppetdb_query($ucp_hostname_query)[0]['value']
  
  class { 'docker_ee_cvd::docker::engine':
    package_source_location  => $package_source_location,
    package_key_source       => $package_key_source,
    package_repos            => $package_repos,
    ntp_server               => $ntp_server,
    }

  class { 'docker_ddc::ucp':
    version           => $ucp_version,
    token             => $ucp_worker_token,
    listen_address    => $worker_address,
    advertise_address => $worker_address,
    fingerprint       => $ucp_fingerprint,
    ucp_manager       => $ucp_ipaddress,
    ucp_url           => 'https://${$ucp_ipaddress}:$ucp_controller_port',
    require           => Class['docker_ee_cvd::docker::engine'],
    local_client      => $docker_ee_cvd::docker::params::local_client,
    }
}
