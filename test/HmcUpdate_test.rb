$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'test/unit'
require 'HMC/Hmc_upgrade'

class HmcUpdateTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_hmc_update_1
    upgradeCmd = HmcUpgrade.new
    upgradeCmd.hostname = '192.168.200.20'
    upgradeCmd.user = 'ziutus'
    upgradeCmd.password = 'password'
    upgradeCmd.filename = '/hmc/HMC_Update_V7R790_SP1.iso'

    expected = 'updhmc -t s -h 192.168.200.20 -u ziutus -p password -f /hmc/HMC_Update_V7R790_SP1.iso'
    assert_equal(expected,upgradeCmd.cmd)

  end
end