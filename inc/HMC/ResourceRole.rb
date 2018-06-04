$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Resource'
require 'pp'

class ResourceRole

  attr_reader :name
  attr_reader :resources

  # name=L2support,"resources=cec:root/ibmhscS1_0|9131-52A*6535CCG|IBMHSC_ComputerSystem,lpar:root/ibmhscS1_0|ALL_PARTITIONS*9131-52A*6535CCG|IBMHSC_Partition"
  def initialize(string='')
    @resources = []

    decode(string) unless string.empty?
  end

  def decode(string)
    raise 'new line character in string' if string.include?("\n")

    if match = /^name=([\w\-\_]+),"resources=(.*?)"$/.match(string)

      @name = match[1]
      match[2].split(',').each do |resource|
        @resources.push(Resource.new(resource))
      end
    elsif match = /^name=([\w\-\_]+),resources=$/.match(string)
      @name = match[1]
    elsif match = /^name=([\w\-\_]+),resources=(.*?)$/.match(string)

      @name = match[1]
      match[2].split(',').each do |resource|
        @resources.push(Resource.new(resource))
      end
    else
      puts string
      puts "regexp couldn't decode string"
      raise
    end
  end

  def has_all_partitions?(type_model_serial)
    @resources.each { |resource|
      if resource.type == 'lpar'
        return true if resource.frame == type_model_serial && resource.lpar == 'ALL_PARTITIONS'
      end
    }
    false
  end

  def has_lpar?(type_model_serial, lpar_id)
    @resources.each do |resource|
      if resource.type == 'lpar'
        if resource.frame == type_model_serial && resource.lpar == 'ALL_PARTITIONS'
          return true
        end

        return true if resource.frame == type_model_serial && resource.lpar == lpar_id.to_s
      end
    end

    false
  end

  def has_all_lpars?(type_model_serial)
    @resources.each do |resource|
      if resource.type == 'lpar'
        return true if resource.frame == type_model_serial && resource.lpar == 'ALL_PARTITIONS'
      end
    end
    false
  end
end