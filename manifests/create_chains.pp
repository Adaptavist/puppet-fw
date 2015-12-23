define fw::create_chains ( $chains = [] ) {
  firewallchain { $chains :
    ensure => present,
  }
}