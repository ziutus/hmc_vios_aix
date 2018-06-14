require 'pp'
require 'HMC/Sys'

require 'Framework/Lpar'

require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'


class System < Sys

  attr_reader :lpars

  def initialize(name = '')
    super(name)

    @lpars = {}
    @lpars_by_name = {}

  end

  def parse_raw_data(string)

    virtual_eth = VirtualEthAdapter.new
    virtual_scsi = VirtualScsiAdapter.new
    virtual_serial = VirtualSerialAdapter.new
    virtual_fc = VirtualFCAdapter.new



    string.each_line do |line|
      if virtual_eth.can_parse?(line)
        lpar_add_adapter('virtual_eth', line)
      elsif virtual_scsi.can_parse?(line)
        lpar_add_adapter('virtual_scsi', line)
      elsif   virtual_serial.can_parse?(line)
        lpar_add_adapter('virtual_serial', line)
      elsif virtual_fc.can_parse?(line)
        lpar_add_adapter('virtual_fc', line)
      elsif match = %r{^name=([\w\_\-]+),lpar_id=(\d+),lpar_env=}.match(line)
        lpar_add(match[2], match[1])
        @lpars[match[2]].parse(line)
      else
        raise Exception, "Can't parse line >#{line}"
      end

      #
    end
  end

  def lpar_add_adapter(type, string)
    adapter = case type
              when 'virtual_eth' then VirtualEthAdapter.new(string)
              when 'virtual_fc' then VirtualFCAdapter.new(string)
              when 'virtual_serial' then VirtualSerialAdapter.new(string)
              when 'virtual_scsi' then VirtualScsiAdapter.new(string)
              else
                raise Exception, 'not supported type of adapter'
              end

    lpar_add(adapter.lpar_id, adapter.lpar_name) unless lpar_id_exist?(adapter.lpar_id)
    @lpars[adapter.lpar_id].virtual_adapter_eth_add(adapter)

  end

  def lpar_add(id, name)
    @lpars[id] = Lpar.new(@name, id, name)
    @lpars_by_name[name] = id
  end

  def lpar_id_exist?(id)
    @lpars.include?(id)
  end

  def lpar_name_exist?(name)
    @lpars_by_name.include?(name)
  end

end