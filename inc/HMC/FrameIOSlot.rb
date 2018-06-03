require 'pp'
require 'HMC/HmcString'
include HmcString

class FrameIOSlot

  attr_reader :unit_phys_loc
  attr_reader :bus_id
  attr_reader :phys_loc
  attr_reader :drc_index
  attr_reader :lpar_name
  attr_reader :lpar_id
  attr_reader :slot_io_pool_id
  attr_reader :pci_vendor_id
  attr_reader :pci_subs_vendor
  attr_reader :pci_subs_device_id
  attr_reader :pci_class
  attr_reader :pci_revision_id
  attr_reader :bus_grouping
  attr_reader :iop
  attr_reader :parent_slot_drc_index
  attr_reader :drc_name
  attr_reader :interposer_present
  attr_reader :interposer_pcie
  attr_reader :description
  attr_reader :feature_codes
  attr_reader :pci_device_id
  attr_reader :pci_subs_vendor_id

  attr_reader :data_string_raw

  def initialize(string = '')

    @variables_int    = %w[ bus_id iop interposer_present interposer_pcie ]

    @variables_string = %w[ unit_phys_loc phys_loc lpar_id drc_index lpar_name slot_io_pool_id description
                            feature_codes pci_vendor_id pci_device_id pci_subs_vendor_id pci_subs_device_id
                            pci_class pci_revision_id bus_grouping parent_slot_drc_index drc_name ]

    unless string.empty?
      @data_string_raw = string
      parse(string)
    end
  end

  def validate
   #	raise "virtualSlotNumber not defined" unless (@virtualSlotNumber.is_a? Numeric)
  end

  def to_s
    validate()
    result
  end

  def parse(string)
    HmcString.parse(string).each do |name, value|
      if @variables_int.include?(name)
        instance_variable_set("@#{name}", value.to_i)
      elsif @variables_string.include?(name)
        instance_variable_set("@#{name}", value.to_s)
      else
        print "FrameIOSlot: unknown name: #{name} with value #{value}"
        raise
      end
    end
  end

end