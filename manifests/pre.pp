# = Class: fw::pre
#
# Helper class for the fw class
#
class fw::pre(
  $fw_chains = $fw::chains) inherits fw {

  Firewall {
    require => undef,
  }

  # ChainName:type:protocol
  $chains = suffix($fw_chains, ':filter:IPv4')

  resources { 'firewall':
    purge => true
  } -> fw::create_chains { 'fw::create_chains':
    chains => $chains,
  }
}

