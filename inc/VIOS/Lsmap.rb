require 'pp'
require 'VIOS/Vtd'
require 'VIOS/Vhost'

class Lsmap

  attr_accessor :mapping

  attr_accessor :vios
  attr_accessor :sys



  def initialize(string = '', vios = nil, sys = nil)
    @vios = vios
    @sys = sys

    @mapping = {}

    parse_long(string) unless string.empty?
  end

  def parse_long(string)

    vhost_number = 0
    vtd_number = 0
    vhost = ''
    vhost_value = ''

    regexp_text = /^\s*SVSA\s+Physloc\s+Client\sPartition\sID\s*$/
    regexp_separator = /^\s*[-]+\s+[-]+\s+[-]+\s*$/
    regexp_no_devices = /NO VIRTUAL TARGET DEVICE FOUND/
    regexp_empty = /^\s*$/

    regexp_mirrored = /^\s*Mirrored\s+(true|false)\s*$/
    regexp_status = /^\s*Status\s+(Available|Defined)\s*$/
    regexp_physloc = /Physloc/
    regexp_lun_id = /^\s*LUN\s+(0x\w+)\s*$/
    regexp_b_device = /Backing\sdevice\s+([\w\-\_]+)/
    regexp_vtd = /^\s*VTD\s+([\w\_\-]+)\s*$/

    regexp_vhost = /^\s*(vhost\d+)\s+([\w\-\.]+)\s+(\w+)\s*$/

    string.each_line do |line|
      next if line =~ /#{regexp_empty}|#{regexp_text}|#{regexp_separator}|#{regexp_no_devices}/

      if line =~ /#{regexp_vhost}/
        if vhost_number > 0
          vhost.vtds.push(Vtd.new(vhost_value)) unless vhost_value.empty?
          @mapping[vhost.name] = vhost
        end

        vhost = Vhost.new(line)
        vhost_number += 1
        vhost_value = ''
        vtd_number = 0

      elsif line =~ /#{regexp_vtd}/
        vhost.vtds.push(Vtd.new(vhost_value)) if vtd_number > 0
        vtd_number += 1
        vhost_value = line
      elsif line =~ /#{regexp_status}|#{regexp_lun_id}|#{regexp_b_device}|#{regexp_physloc}|#{regexp_mirrored}/
        vhost_value += line
      else
        raise "Class:VIOS:lsmap, function: parse_long, RegExp couldn't decode line >>#{line}<<"
      end
    end

    vhost.vtds.push(Vtd.new(vhost_value)) if vtd_number > 0
    @mapping[vhost.name] = vhost if vhost_number > 0
  end

  def lpars
    result = []
    @mapping.each_value do |vhost|
      result.push(vhost.client_partition_id_nice)
    end
    result.uniq
  end

  def mapping_for_lpar(lpar_id)
    result = []
    @mapping.each_value do |vhost|
      result.push(vhost) if vhost.client_partition_id_nice == lpar_id
    end
    result
  end

  def backing_devices_for_lpar(lpar_id)
    result = []
    mapping_for_lpar(lpar_id).each do |vhost|
      vhost.vtds.each do |vtd|
        result.push(vtd.backing_device)
      end
    end
    result.sort
  end
end