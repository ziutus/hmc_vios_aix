require 'AIX/Lsattr'
include Lsattr

class Device

  attr_reader :attr_odm
  attr_reader :attr_default
  attr_reader :attr_running

  attr_reader :warnings
  attr_reader :errors

  def initialize

    @attr_odm     = Array.new
    @attr_default = Array.new
    @attr_running = Array.new

    @warnings = Array.new
    @errors   = Array.new
  end

  def set_attr(string, type='odm')

    array = Array.new

    if (string.include?(':'))
      array = lsattr_O(string)
    else
      array = lsattr(string)
    end

    case type
      when 'odm' then @attr_odm = array
      when 'default' then @attr_default = array
      when 'running' then @attr_running = array
      else
        raise "can't setup attr, unknown type"
    end

  end

  def validate

    result = true

    result = false unless self.validate_attr_odm_running
  end

  #let's compare running settings with those from ODM
  #the idea is taken from: https://www.ibm.com/developerworks/community/blogs/brian/entry/script_to_show_if_aix_device_attributes_are_actually_in_effect?lang=en

  def validate_attr_odm_running

      result = true

      if @attr_odm.size > 0 and @attr_running.size > 0
        @attr_odm.keys.each do |key|
          if @attr_odm[key]['value'] != @attr_running[key]['value']
            @warnings.push("#{key}: ODM value #{@attr_odm[key]['value']} is different from running: #{@attr_running[key]['value']}")
            result = false
          end
        end
    end

    result
  end



end