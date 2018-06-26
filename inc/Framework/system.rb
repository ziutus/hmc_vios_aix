require 'pp'
require 'HMC/Sys'

require 'Framework/Lpar'

require 'HMC/VirtualEthAdapter'
require 'HMC/VirtualScsiAdapter'
require 'HMC/VirtualSerialAdapter'
require 'HMC/VirtualFCAdapter'

class System < Sys

  attr_reader :lpars
  attr_reader :lpars_by_name
  attr_reader :vioses

  def initialize(name = '', hmc = '')
    super(name, hmc)

    @lpars = {}
    @lpars_by_name = {}
    @vioses = []
  end

  def parse_raw_data(string)
    virtual_eth = VirtualEthAdapter.new
    virtual_scsi = VirtualScsiAdapter.new
    virtual_serial = VirtualSerialAdapter.new
    virtual_fc = VirtualFCAdapter.new

    update_vioses = false

    string.each_line do |line|
      next if line =~ /No results were found./
      if virtual_eth.can_parse?(line)
        lpar_add_adapter('virtual_eth', line)
      elsif virtual_scsi.can_parse?(line)
        lpar_add_adapter('virtual_scsi', line)
      elsif virtual_serial.can_parse?(line)
        lpar_add_adapter('virtual_serial', line)
      elsif virtual_fc.can_parse?(line)
        lpar_add_adapter('virtual_fc', line)
      elsif match = %r{^name=([\w\_\-]+),lpar_id=(\d+),lpar_env=}.match(line)
        lpar_add(match[2], match[1])
        @lpars[match[2]].lssyscfg_decode(line)
        update_vioses = true
      else
        raise Exception, "Can't parse line >#{line}<"
      end
    end

    vioses_list_update if update_vioses
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
    @lpars[id] = Lpar.new(@name, id, name, @hmc)
    @lpars_by_name[name] = id
  end

  def lpar_id_exist?(id)
    @lpars.include?(id)
  end

  def lpar_name_exist?(name)
    @lpars_by_name.include?(name)
  end


  def getLparByName(lparName)
    return @lpars[@lpars_by_name[lparName]] if lpar_name_exist?(lparName)
    false
  end

  private

  def vioses_list_update
    @lpars.each_pair do |lpar_id, lpar|
      @vioses.push(lpar.name) if lpar.lpar_env == 'vioserver' and !@vioses.include?(lpar.name)
    end
    put_vioses_to_lpars
  end

  def put_vioses_to_lpars
    @lpars.each_key do |lpar_id|
      @lpars[lpar_id].vioses = @vioses
    end
  end

end