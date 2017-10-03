$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/FrameIOSlots'
require "test/unit"

class TestFrameIOSlots < Test::Unit::TestCase
 
	
	def test_validation 

		slot = FrameIOSlots.new(DATA.read) 
		
		slot.get_lpar("vios2")
	end
end	

# test data source: own Power5 server		
__END__
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=2,phys_loc=C4,drc_index=21010002,lpar_name=vios2,lpar_id=3,slot_io_pool_id=none,description=PCI-to-PCI bridge,feature_codes=none,pci_vendor_id=12D8,pci_device_id=01A7,pci_subs_vendor_id=0000,pci_subs_device_id=0000,pci_class=0604,pci_revision_id=01,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C4,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=3,phys_loc=T12,drc_index=21010003,lpar_id=none,slot_io_pool_id=none,description=Other Mass Storage Controller,feature_codes=none,pci_vendor_id=105A,pci_device_id=1275,pci_subs_vendor_id=105A,pci_subs_device_id=1275,pci_class=0180,pci_revision_id=01,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-T12,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=3,phys_loc=T10,drc_index=21020003,lpar_name=vios1,lpar_id=2,slot_io_pool_id=none,description=Ultra320 SCSI Disk Controller,feature_codes=5728,pci_vendor_id=1069,pci_device_id=B166,pci_subs_vendor_id=1014,pci_subs_device_id=02D4,pci_class=0104,pci_revision_id=04,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-T10,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=3,phys_loc=C3,drc_index=21030003,lpar_id=none,slot_io_pool_id=none,description=Empty slot,feature_codes=0,pci_vendor_id=FFFF,pci_device_id=FFFF,pci_subs_vendor_id=FFFF,pci_subs_device_id=FFFF,pci_class=FFFF,pci_revision_id=FF,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C3,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=3,phys_loc=C5,drc_index=21040003,lpar_name=vios1,lpar_id=2,slot_io_pool_id=none,description=PCI-to-PCI bridge,feature_codes=none,pci_vendor_id=12D8,pci_device_id=01A7,pci_subs_vendor_id=0000,pci_subs_device_id=0000,pci_class=0604,pci_revision_id=01,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C5,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=3,phys_loc=C6,drc_index=21050003,lpar_name=vios2,lpar_id=3,slot_io_pool_id=none,description=Storage controller,"feature_codes=5702,5705,5710,5712,5715,624",pci_vendor_id=1069,pci_device_id=B166,pci_subs_vendor_id=1014,pci_subs_device_id=0266,pci_class=0100,pci_revision_id=04,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C6,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=4,phys_loc=T7,drc_index=21010004,lpar_id=none,slot_io_pool_id=none,description=Universal Serial Bus UHC Spec,feature_codes=none,pci_vendor_id=1033,pci_device_id=0035,pci_subs_vendor_id=1033,pci_subs_device_id=0035,pci_class=0C03,pci_revision_id=43,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-T7,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=4,phys_loc=T5,drc_index=21020004,lpar_id=none,slot_io_pool_id=none,description=PCI 10/100/1000Mbps Ethernet UTP 2-port,feature_codes=5706,pci_vendor_id=8086,pci_device_id=1079,pci_subs_vendor_id=1014,pci_subs_device_id=0289,pci_class=0200,pci_revision_id=03,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-T5,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=4,phys_loc=C1,drc_index=21030004,lpar_id=none,slot_io_pool_id=none,description=Fibre Channel Serial Bus,feature_codes=none,pci_vendor_id=10DF,pci_device_id=FD00,pci_subs_vendor_id=10DF,pci_subs_device_id=FD00,pci_class=0C04,pci_revision_id=01,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C1,interposer_present=0,interposer_pcie=0
unit_phys_loc=U787F.001.DPM0XLZ,bus_id=4,phys_loc=C2,drc_index=21040004,lpar_name=vios1,lpar_id=2,slot_io_pool_id=none,description=PCI-to-PCI bridge,feature_codes=none,pci_vendor_id=3388,pci_device_id=0021,pci_subs_vendor_id=0000,pci_subs_device_id=0000,pci_class=0604,pci_revision_id=15,bus_grouping=0,iop=0,parent_slot_drc_index=none,drc_name=U787F.001.DPM0XLZ-P1-C2,interposer_present=0,interposer_pcie=0
