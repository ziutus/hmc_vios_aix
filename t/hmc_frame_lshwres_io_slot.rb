$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/FrameIOSlot'
require "test/unit"

class TestSlotsIO < Test::Unit::TestCase
 
	
	def test_validation 

		string = 'unit_phys_loc=U787F.001.DPM0XLZ,bus_id=4,phys_loc=T5,drc_index=21020004,lpar_id=none,slot_io_pool_id=none,description=PCI 10/100/1000Mbps Ethernet UTP 2-port,feature_codes=5706,pci_vendor_id=8086,pci_device_id=1079,pci_subs_vendor_id=1014,pci_subs_device_id=0289,pci_class=0200,pci_revision_id=03,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-T5,interposer_present=0,interposer_pcie=0'
	
		slot = FrameIOSlot.new(string)
	
#		pp slot 
	
		assert_equal('U787F.001.DPM0XLZ', slot.unit_phys_loc)
		assert_equal(4, slot.bus_id)
		assert_equal('T5', slot.phys_loc)
		assert_equal('21020004', slot.drc_index)
		assert_equal('none', slot.lpar_id)
		assert_equal('none', slot.slot_io_pool_id)
		assert_equal('PCI 10/100/1000Mbps Ethernet UTP 2-port', slot.description)
		assert_equal('5706', slot.feature_codes)
		assert_equal('8086', slot.pci_vendor_id)
		assert_equal('1079', slot.pci_device_id)
		assert_equal('1014', slot.pci_subs_vendor_id)
		assert_equal('0289', slot.pci_subs_device_id)
		assert_equal('0200', slot.pci_class)
		assert_equal('03', slot.pci_revision_id)
		assert_equal("0", slot.bus_grouping)
		assert_equal(0, slot.iop)
		assert_equal('none', slot.parent_slot_drc_index)
		assert_equal('U787F.001.DPM0XLZ-P1-T5', slot.drc_name)
		assert_equal(0, slot.interposer_present)
		assert_equal(0, slot.interposer_pcie)	
	
	end
end



