require 'facter'

Facter.add('ucp_fingerprint') do
    setcode do
      Facter::Core::Execution.exec("docker run --rm -i --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:#{Facter.value(:ucp_version)} fingerprint | sed 's/.*=//'")
    end
end
