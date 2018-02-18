require 'pp'

class Lssysconn_entry

  attr_reader :resource_type
  attr_reader :type_model_serial_num
  attr_reader :sp
  attr_reader :sp_phys_loc
  attr_reader :ipaddr
  attr_reader :alt_ipaddr
  attr_reader :state
  attr_reader :connection_error_code

  attr_reader :type
  attr_reader :model
  attr_reader :serial_num

  attr_reader :side

  attr_reader :_states
  attr_reader :_errors

  attr_accessor :hmc_real
  attr_accessor :hmc_expected


  def initialize(string = nil)

    @resource_type = nil
    @type_model_serial_num = nil
    @sp = nil
    @ipaddr = nil
    @alt_ipaddr = nil
    @state = nil
    @connection_error_code = nil

    @hmc_real = nil
    @hmc_expected = Array.new()

    @_states = [ 'pending authentication - password updates required', 'No Connection', 'Failed Authentication', 'Connecting', 'Connected', 'Version Mismatch' ]
    @_errors = [ 'Incorrect password \w{4}-\w{4}-\w{8}', 'Connecting\s+\w{4}-\w{4}-\w{8}', 'Connection not allowed\s+\w{4}-\w{4}-\w{8}', 'Already connected\s+\w{4}-\w{4}-\w{8}', 'Firmware Password locked\s+\w{4}-\w{4}-\w{8}' ]

    self.parse(string) unless string.nil?
  end

  def parse(string)

    states = @_states.join('|')
    errors = @_errors.join('|')
    sp = 'primary|secondary|unavailable'
    ip = '\d+\.\d+\.\d+\.\d+'
    tmsn = '\w{4}\-\w{3}\*\w{7,8}|unavailable'


    #resource_type=sys,type_model_serial_num=9117-570*100729E,sp=unavailable,ipaddr=10.0.0.247,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting 0000-0000-00000000
    if match = /resource_type=(sys),type_model_serial_num=(#{tmsn}),sp=(#{sp}),ipaddr=(#{ip}),alt_ipaddr=(unavailable),state=(#{states}),connection_error_code=(Connecting \w{4}-\w{4}-\w{8})/i.match(string)
      @resource_type = match[1]
      @type_model_serial_num = match[2]
      @sp = match[3]
      @ipaddr = match[4]
      @alt_ipaddr  = match[5]
      @state = match[6]
      @connection_error_code = match[7]

      @type, @model, @serial_num = type_model_serial_num_to_array(@type_model_serial_num)

                  #resource_type=sys, type_model_serial_num=unavailable,sp=unavailable,sp_phys_loc=unavailable,ipaddr=128.200.91.5,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting 0000-0000-00000000
      #resource_type=sys,  type_model_serial_num=unavailable,                         sp=unavailable,                    sp_phys_loc=unavailable,  ipaddr=128.200.91.5,         alt_ipaddr=unavailable,  state=No Connection,                        connection_error_code=Connecting 0000-0000-00000000
                  #resource_type=sys,  type_model_serial_num=9131-52A*6535CCG,                    sp=unavailable,                    sp_phys_loc=unavailable,  ipaddr=192.168.200.39,       alt_ipaddr=unavailable,  state=No Connection,                        connection_error_code=Connecting  0000-0000-00000000
    elsif match = /resource_type=(sys),type_model_serial_num=(#{tmsn}),sp=(#{sp}),sp_phys_loc=(unavailable),ipaddr=(#{ip}),alt_ipaddr=(unavailable),state=(#{states}),connection_error_code=(#{errors})/i.match(string)
      @resource_type = match[1]
      @type_model_serial_num = match[2]
      @sp = match[3]
      @sp_phys_loc = match[4]
      @ipaddr = match[5]
      @alt_ipaddr  = match[6]
      @state = match[7]
      @connection_error_code = match[8]

      @type, @model, @serial_num = type_model_serial_num_to_array(@type_model_serial_num)

    elsif match = /resource_type=(sys),type_model_serial_num=(#{tmsn}),sp=(#{sp}),sp_phys_loc=(unavailable),ipaddr=(#{ip}),alt_ipaddr=(unavailable),state=(#{states})/i.match(string)
      @resource_type = match[1]
      @type_model_serial_num = match[2]
      @sp = match[3]
      @sp_phys_loc = match[4]
      @ipaddr = match[5]
      @alt_ipaddr  = match[6]
      @state = match[7]

      @type, @model, @serial_num = type_model_serial_num_to_array(@type_model_serial_num)


    elsif match = /resource_type=(frame),type_model_serial_num=(#{tmsn}),side=(a|b),ipaddr=(#{ip}),state=(#{states})/i.match(string)

      @resource_type = match[1]
      @type_model_serial_num = match[2]
      @side = match[3]
      @ipaddr = match[4]
      @state = match[5]

      @type, @model, @serial_num = type_model_serial_num_to_array(@type_model_serial_num)

    else
      pp string
      raise "wrong string to parse"
    end

  end

  def type_model_serial_num_to_array(string)
    if ( match =/(\w{4})\-(\w{3})\*(\w{7,8})/.match(string) )
        return [match[1], match[2], match[3]]
    end
  end
end