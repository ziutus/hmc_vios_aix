require 'pp'
require 'HMC/HmcString'
include HmcString


class FrameIOSlot

	attr_reader :unit_phys_loc, :bus_id, :phys_loc, :drc_index, :lpar_name, :lpar_id, :slot_io_pool_id 
	attr_reader :pci_vendor_id, :pci_subs_vendor, :pci_subs_device_id, :pci_class, :pci_revision_id
	attr_reader :bus_grouping, :iop, :parent_slot_drc_index, :drc_name, :interposer_present, :interposer_pcie
	attr_reader :description, :feature_codes, :pci_device_id, :pci_subs_vendor_id

	attr_reader :data_string_raw
	
	def initialize string='' 

		@variables_int    = [ 'bus_id', 'iop', 'interposer_present', 'interposer_pcie' ]
	
		@variables_string = [ 'unit_phys_loc', 'phys_loc', 'lpar_id', 'drc_index', 'lpar_name', 'slot_io_pool_id', 'description',
			'feature_codes', 'pci_vendor_id', 'pci_device_id', 'pci_subs_vendor_id', 'pci_subs_device_id', 
			'pci_class', 'pci_revision_id', 'bus_grouping', 'parent_slot_drc_index', 'drc_name' ]	
		
		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end			
	end
		
		
	def validate
#		raise "virtualSlotNumber not defined" unless (@virtualSlotNumber.is_a? Numeric)
	end
		
	def to_s
	
		self.validate()
		
		result
	end
	
	def parse string

		myHash = HmcString.parse(string)
	
		myHash.each { |name, value| 
		
			if @variables_int.include?(name)
				instance_variable_set("@#{name}", value.to_i) 
			elsif @variables_string.include?(name)
				instance_variable_set("@#{name}", value.to_s) 
			else 
				print "FrameIOSlot: unknown name: #{name} with value #{value}"
				raise 
			end
		}		
	end

end