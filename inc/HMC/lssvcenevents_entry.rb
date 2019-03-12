require 'HMC/HmcString'

include HmcString


class Lssvcenevents_entry

  attr_accessor :hmcs_name
  attr_accessor :hmc_name
  attr_accessor :problem_num
  attr_accessor :pmh_num
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

  def initialize(string = nil, hmc_name = nil)

    @hmcs_name = []

    unless hmc_name.nil?
      @hmc_name = hmc_name
      @hmcs_name.push(hmc_name)
    end

    @problem_num = nil
    @pmh_num = nil
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

    @_allowed_cols = %w[problem_num pmh_num refcode status first_time last_time sys_name sys_mtms enclosure_mtms firmware_fix
text created_time reporting_name reporting_mtms failing_mtms analyzing_hmc event_time files
approval_state callhome_intended duplicate_count event_severity analyzing_mtms ref_code_extn sys_refcode fru_details
]

    parse(string) unless string.nil?
  end

  def to_s
    cols = %w[problem_num pmh_num refcode status first_time last_time sys_name sys_mtms enclosure_mtms firmware_fix
text created_time reporting_name reporting_mtms failing_mtms analyzing_hmc event_time files
approval_state callhome_intended duplicate_count event_severity analyzing_mtms ref_code_extn sys_refcode fru_details
]
    string = ''

    cols.each do |col|
      string += "#{col}=" + instance_variable_get("@#{col}") + ","
    end

    string
  end

  def parse(string)

    HmcString.parse(string).each_pair do |key, value|
      if @_allowed_cols.include?(key)
        instance_variable_set("@#{key}", value)
      elsif key =~ /^fru_details/
        @fru_details = key + value
      else
        pp key
        pp value
        raise 'wrong key'
      end
    end
  end


  def compare(other)

    cols = %w[problem_num pmh_num refcode status first_time last_time sys_name sys_mtms enclosure_mtms firmware_fix
text created_time reporting_name reporting_mtms failing_mtms event_time files
approval_state callhome_intended duplicate_count event_severity analyzing_mtms ref_code_extn sys_refcode fru_details
]

    cols.each do |cal|
      #puts "#{cal}:  " + self.instance_variable_get("@#{cal}") + ": " + other.instance_variable_get("@#{cal}") + "\n"
      return false unless self.instance_variable_get("@#{cal}") == other.instance_variable_get("@#{cal}")
      #puts "going to next \n"
    end

    true
  end

  def hmc_add(hmc_name)
    @hmcs_name.push(hmc_name) unless @hmcs_name.include?(hmc_name)
  end
end