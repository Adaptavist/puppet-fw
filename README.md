fw
===
[![Build Status](https://travis-ci.org/Adaptavist/puppet-fw.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-fw)

This module manages basic firewall rules. It is a paramaterised class
which can be driven from hiera. The Adaptavist `$host` variable is also
used when it is present.

Usage
-----

Hiera can be used to configure the module like so:

    fw::on: true
    fw::tcp:
      - 80
      - 443

    fw::udp:
      - 5000
      - 4000

    fw::icmp: 'accept'

When `hosts` is used tcp and udp ports can be added on a per host basis. See:


    hosts:
      'host1':
        fw::tcp:
          - 1024
          - 80
          - 8080
        fw::udp:
          - 53

This will ensure that the host `host1` has tcp ports 80, 443, 1024 and 8080 open
along with udp ports 5000, 4000 and 53.
