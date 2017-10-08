$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'VIOS/Vtd2'
require 'test/unit'
require 'pp'

class TestViosVtd < Test::Unit::TestCase

	def test_vtd1

		string='VTD                   vtscsi0
Status                Available
LUN                   0x8100000000000000
Backing device        vtd0-1
Physloc'

		vtd = Vtd2.new(string)

		assert_equal('vtscsi0', 			     vtd.name)
		assert_equal('Available', 			   vtd.status)
		assert_equal('0x8100000000000000', vtd.lun)
		assert_equal('vtd0-1', 				     vtd.backing_device)
		assert_equal('', 					         vtd.physloc)
		

	end

	def test_vtd2

		string ='VTD                   vtscsi1
LUN                   0x8200000000000000
Backing device        vtd0-2
Physloc'

		vtd = Vtd2.new(string)

		assert_equal('vtscsi1', 			     vtd.name)
		assert_equal('0x8200000000000000', vtd.lun)
		assert_equal('vtd0-2', 				     vtd.backing_device)
		assert_equal('', 					         vtd.physloc)


	end

	def test_vtd3
	
		string='VTD                   vtscsi2
Status                Available
LUN                   0x8300000000000000
Backing device        hdisk2
Physloc               U787A.001.0397658-P1-T16-L5-L0
Mirrored              false'

		vtd = Vtd2.new(string)

		assert_equal('vtscsi2', 			                 vtd.name)
		assert_equal('Available', 			               vtd.status)
		assert_equal('0x8300000000000000', 	           vtd.lun)
		assert_equal('hdisk2', 				                 vtd.backing_device)
		assert_equal('U787A.001.0397658-P1-T16-L5-L0', vtd.physloc)
		assert_equal('false',		                       vtd.mirrored)

	end
end	