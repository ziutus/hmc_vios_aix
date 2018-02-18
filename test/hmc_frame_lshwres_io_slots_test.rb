$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/FrameIOSlots'
require 'test/unit'

class TestFrameIOSlots < Test::Unit::TestCase


	def test_validation

		slot = FrameIOSlots.new(File.read('data/hmc_frame_lshwres_io_slots.txt'))
		slot.get_lpar('vios2')
	end
end
