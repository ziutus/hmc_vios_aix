require 'HMC/HmcString'
require 'pp'

include HmcString

class Lshmcusr

  attr_reader :data
  attr_reader :data_string_raw

  # options are taken from: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mkhmcusr.html
  attr_reader :name
  attr_reader :taskrole
  attr_reader :description
  attr_reader :pwage
  attr_reader :resourcerole
  attr_reader :authentication_type
  attr_reader :remote_webui_access
  attr_reader :remote_ssh_access
  attr_reader :min_pwage
  attr_reader :session_timeout
  attr_reader :verify_timeout
  attr_reader :idle_timeout
  attr_reader :inactivity_expiration
  attr_reader :resources
  attr_reader :password
  attr_reader :password_encryption
  attr_reader :disabled


  def initialize(string)

    @data = Hash.new
    @data_string_raw=''

    @_variables = Hash.new

    @_variables['variables_int']    = [ 'disabled', 'pwage', 'remote_webui_access', 'remote_ssh_access', 'min_pwage', 'session_timeout', 'verify_timeout', 'idle_timeout', 'inactivity_expiration' ]
    @_variables['variables_string'] = [ 'name', 'taskrole', 'description', 'resourcerole', 'authentication_type', 'resources', 'password_encryption' ]

    @name = nil
    @taskrole = nil
    @description = nil
    @pwage = nil
    @resourcerole = nil
    @authentication_type = nil
    @remote_webui_access = nil
    @remote_ssh_access = nil
    @min_pwage = nil
    @session_timeout = nil
    @verify_timeout = nil
    @idle_timeout = nil
    @inactivity_expiration = nil
    @resources = nil
    @password = nil
    @password_encryption = nil
    @disabled = nil


    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    array = HmcString.parse(string)

    array.each_pair { | key, value|
      if @_variables['variables_int'].include?(key)
        instance_variable_set("@#{key}", value.to_i)
      elsif @_variables['variables_string'].include?(key)
        instance_variable_set("@#{key}", value)
      else
        raise Exception "Unknown variable #{key}, #{value}"
      end
    }


  end


end