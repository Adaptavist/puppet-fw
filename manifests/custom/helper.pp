define fw::custom::helper(

  ) {
  # Explicitly look up with Hiera the ports for this chain
  # TODO: Only done this way since Puppet doesn't allow for $"fw::tcp::$name"
  $tcp = hiera_array("fw::tcp::${name}", [])
  $udp = hiera_array("fw::udp::${name}", [])

  if $::host != undef {
    # If the host entry exists merge the global ports with it
    $tcp_ports = sort(unique($host["fw::tcp::$name"] ? {
      undef   => $tcp,
      default => concat($tcp, $host["fw::tcp::$name"]),
    }))

    $udp_ports = sort(unique($host["fw::udp::$name"] ? {
      undef   => $udp,
      default => concat($udp, $host["fw::udp::$name"]),
    }))
  } else {
    $tcp_ports = $tcp
    $udp_ports = $udp
  }

  if !empty($tcp_ports) {
    firewall { "006 TCP service ports for ${name}":
      chain  => $name,
      proto  => 'tcp',
      action => 'accept',
      port   => $tcp_ports,
    }
  }

  if !empty($udp_ports) {
    firewall { "007 UDP service ports for ${name}":
      chain  => $name,
      proto  => 'udp',
      action => 'accept',
      port   => $udp_ports,
    }
  }
}
