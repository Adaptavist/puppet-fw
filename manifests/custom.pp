# = Class: fw::custom
#
# Helper class for the fw class
#
class fw::custom(
    $fw_chains = $fw::chains
  ) inherits fw {
  fw::custom::helper { $fw_chains : }
}
