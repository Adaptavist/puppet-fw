# = Class: fw::post
#
# Helper class for the fw class
#
class fw::post(
  $fw_on = $fw::on,
) {
  $action = $fw_on ? {
    true  => 'drop',
    false => 'accept',
  }
  firewall { "999 $action all":
    proto   => 'all',
    action  => $action,
    before  => undef,
  }

}
