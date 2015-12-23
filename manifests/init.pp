# = Class: fw
#
# This is the fw class for implementing fw rules in the
# Puppetlabs fiewall recommended way. The firewall can be
# switched off, and ports can be opened by passing parameters,
# All traffic except ssh, outbound and established traffic
# is dropped by default
#
# == Parameters
#
# [*on*]
#  Set to false to flip the last rule to accept all
#  Defaults to true
#
# [*chains*]
#  Array of chains to create
#
# [*rules*]
#  Hash of rules
#
# == Hiera
#
# Hiera can be used to provide per host tcp and udp port lists
# e.g.
#
# fw::tcp::my_chain:
#   - 80
#   - 443
#
# fw::rules: &fw_rules
#   '001 accept all icmp':
#       chain: INPUT
#       proto: icmp
#       action: accept
#   '002 allow all loopback traffic':
#       chain: INPUT
#       proto: all
#       iniface: lo
#       action: accept
#
# hosts:
#   'host1':
#     fw:tcp::my_chain:
#       - 80
#       - 8080
#
# Will result in a tcp port list of 80, 443, 8080
#
# == Author
#    Jon Mort <jmort@adaptavist.com>
class fw (
  $on     = true,
  $chains = [],
  $rules  = {},
  ) {
  validate_array($chains)
  validate_hash($rules)
  validate_bool($on)

  contain fw::pre

  Firewall {
    before  => Class['fw::post'],
    require => Class['fw::pre'],
  }

  create_resources(firewall, $rules)

  contain fw::custom
  contain fw::post
  # anchor { 'fw::start': } ->
  # Class['fw::pre'] ~>
  # Class['fw::custom'] ~>
  # Class['fw::post'] ~>
  # anchor { 'fw::end': }
}

