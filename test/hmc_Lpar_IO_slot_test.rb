$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'test/unit'
require 'HMC/Lpar_IO_slot'

class TestHmcLparIOSlot < Test::Unit::TestCase

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
  def test_lpar_io_slot

    io_slot = Lpar_IO_slot.new('21010002/none/1')

    assert_equal('21010002', io_slot.slot_DRC_index)
    assert_equal('none', io_slot.slot_IO_pool_ID)
    assert_equal(1, io_slot.is_required)

    assert_equal('21010002/none/1', io_slot.to_s)

  end
end