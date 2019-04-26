require 'HMC/HmcString'

include HmcString


class Lssvcenevents_entry

  attr_accessor :hmcs_name
  attr_accessor :hmc_name
  attr_accessor :pmh_num_nice

  attr_accessor :problem_num
  attr_reader :pmh_num
  attr_accessor :refcode
  attr_accessor :status
  attr_accessor :first_time
  attr_accessor :last_time
  attr_accessor :sys_name
  attr_accessor :sys_mtms
  attr_accessor :enclosure_mtms
  attr_accessor :firmware_fix
  attr_accessor :text
  attr_accessor :created_time
  attr_accessor :reporting_name
  attr_accessor :reporting_mtms
  attr_accessor :failing_mtms
  attr_accessor :analyzing_hmc
  attr_accessor :event_time
  attr_accessor :files
  attr_accessor :approval_state
  attr_accessor :callhome_intended
  attr_accessor :duplicate_count
  attr_accessor :event_severity
  attr_accessor :analyzing_mtms
  attr_accessor :ref_code_extn
  attr_accessor :sys_refcode
  attr_accessor :fru_details

  attr_accessor :serial
  attr_accessor :machine_type
  attr_accessor :machine_model

  attr_accessor :priority
  attr_accessor :ticket_number
  attr_accessor :event_status
  attr_accessor :resolution_status
  attr_accessor :action_plan

  def initialize(string = nil, hmc_name = nil)
    @hmcs_name = []

    unless hmc_name.nil?
      @hmc_name = hmc_name
      @hmcs_name.push(hmc_name)
    end

    @problem_num = nil
    @pmh_num = nil
    @pmh_num_nice = nil
    @refcode = nil
    @status = nil
    @first_time = nil
    @last_time = nil
    @sys_name = nil
    @sys_mtms = nil
    @enclosure_mtms = nil
    @firmware_fix = nil
    @text = nil
    @created_time = nil
    @reporting_name = nil
    @reporting_mtms = nil
    @failing_mtms = nil
    @analyzing_hmc = nil
    @event_time = nil
    @files = nil
    @approval_state = nil
    @callhome_intended = nil
    @duplicate_count = nil
    @event_severity = nil
    @analyzing_mtms = nil
    @ref_code_extn = nil
    @sys_refcode = nil
    @fru_details = nil

    @serial = nil
    @machine_type = nil
    @machine_model = nil

    @priority = nil
    @ticket_number = nil
    @event_status = nil
    @resolution_status = nil
    @action_plan = nil


    @_allowed_cols = %w[problem_num pmh_num refcode status first_time last_time sys_name sys_mtms enclosure_mtms firmware_fix
text created_time reporting_name reporting_mtms failing_mtms analyzing_hmc event_time files
approval_state callhome_intended duplicate_count event_severity analyzing_mtms ref_code_extn sys_refcode fru_details
]

    @_allowed_cols_csv = @_allowed_cols + %w[serial machine_type machine_model priority ticket_number event_status resolution_status action_plan]

    parse(string) unless string.nil?
  end

  def to_s
    string = ''

    @_allowed_cols.each do |col|
      string += "#{col}=" + instance_variable_get("@#{col}") + ','
    end

    string
  end

  def parse(string)
    HmcString.parse(string).each_pair do |key, value|
      if @_allowed_cols.include?(key)
        instance_variable_set("@#{key}", value)
        if key == 'failing_mtms'
          mtms_to_serial_type_model(value)
        end
      elsif key =~ /^fru_details/
        @fru_details = key + value
      else
        pp key
        pp value
        raise 'wrong key'
      end
    end
  end

  def mhp_num=(string)
    @mhp_num = string
    @pmh_num_nice = @pmh_num.tr(',', ' ')
  end

  def compare(other, cols = nil)

    # in case of network issue (problem with connection from second or third HMC),
    # sys_name and reporting_name would be the IP address
    cols = @_allowed_cols - %w[analyzing_hmc sys_name reporting_name] if cols.nil?

    cols.each do |cal|
      return false unless instance_variable_get("@#{cal}") == other.instance_variable_get("@#{cal}")
    end

    true
  end

  def mtms_to_serial_type_model(string)
    unless string.nil?

      regexp = %r{(\d{4})-(\w{3})\/(\w{7})}
      matched = regexp.match(string)
      if matched
        @serial = matched[3]
        @machine_type = matched[1]
        @machine_model = matched[2]
      else
        pp string
        raise 'wrong regexp'
      end
    end
  end

  def hmc_add(hmc_name)
    @hmcs_name.push(hmc_name) unless @hmcs_name.include?(hmc_name)
  end

  def parse_from_csv(header_line, value_line, headers_map = nil)

    headers = header_line.split(';')
    values = value_line.split(';')

    headers.map!{ |x| x.strip }

    if headers_map.nil?
      headers_map = {
        'HMC' => 'hmcs_name',
        'event time' => 'last_time',
        'ID' => 'problem_num',
        'PHM' => 'pmh_num',
        'refcode' => 'refcode',
        'system serial' => 'serial',
        'sys name' => 'sys_name',
        'failing mtms' => 'failing_mtms',
        'machine type' =>  'machine_type',
        'model' => 'machine_model',
        'priority' => 'priority',
        'ticket number' => 'ticket_number',
        'event status' => 'status',
        'Resolution Status' => 'resolution_status',
        'text' => 'text',
        'action plan' => 'action_plan'
    }
    end

    (0..(headers.count - 1)).each do |i|
      if headers_map.key?(headers[i])
        header_name = headers_map[headers[i]]
      else
        raise "wrong column name in headers_map >#{headers[i]}<"
      end

      if header_name == 'hmcs_name'
        values[i].split(',').each do |hmc_name|
         hmc_add(hmc_name)
        end
      elsif header_name == 'phm_num'
        instance_variable_set("@#{header_name}", values[i]) unless values[i] == ''
      else
       instance_variable_set("@#{header_name}", values[i])
      end
    end

    true # useful for running debug
  end
end