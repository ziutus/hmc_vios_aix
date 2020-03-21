require 'HMC/Lpar_profile'
require 'HMC/Lpar_real'

# class is taking all data from HMC (only), is able to compare running options with data in profiles
class HmcLpar < Lpar_real

  attr_accessor :sys
  attr_accessor :name
  attr_accessor :lpar_name
  attr_accessor :hmc
  attr_accessor :lpar_id

  attr_reader :errors
  attr_reader :warnings
  attr_accessor :verbose

  attr_accessor :vioses

  attr_reader :profiles



  def initialize(sys = nil, lpar_id = nil, name = nil, hmc = nil)
    super(sys, lpar_id, name)
    @hmc = hmc
    @sys = sys
    @lpar_id = lpar_id
    @name = name
    @profiles = {}
    @vioses = {}


    @errors   = []
    @warnings = []

    @verbose = 0
  end

  def profile_add(profile)
    if profile.class.to_s == 'String'
      profile_tmp = Lpar_profile.new
      profile_tmp.parse(profile)
      profile = profile_tmp
    end

    raise 'profile to add is not proper profile object or string with profile' unless profile.class.to_s == 'Lpar_profile'

    @profiles[profile.name]= profile
  end

  def profile_delete(profile_name)
    @profiles.delete(profile_name)
  end

  def profile_exist?(profile_name)
    @profiles.include?(profile_name)
  end

  def hashToLpar(hash)

    hash['prof'].split("\n").each { |line|
      profile_add(line)
    }

    lssyscfg_decode(hash['lpar_info']) unless hash['lpar_info'].nil?
    decode_mem(hash['memory']) unless hash['memory'].nil?
    decode_proc(hash['proc']) unless hash['proc'].nil?
    decodeVirtualioSlot(hash['virtual_slot']) unless  hash['virtual_slot'].nil?
    decode_virtualio_eth(hash['virtual_eth']) unless  hash['virtual_eth'].nil?
    decode_virtual_serial(hash['virtual_serial']) unless  hash['virtual_serial'].nil?
    decode_virtual_scsi(hash['virtual_scsi']) unless  hash['virtual_scsi'].nil?
  end

  def running_vs_pending
    curr_pend_array = %w[ min_mem mem nax_mem min_num_huge_pages num_huge_pages
                         max_num_huge_pages proc_mode min_procs procs max_procs sharing_mode min_proc_units proc_units
                         max_proc_units uncap_weight shared_proc_pool_id max_virtual_slots
                        ]

    curr_pend_array.each { |name|
      if instance_variable_get("@curr_#{name}") != instance_variable_get("@pend_#{name}")
        @errors.push("curr_#{name}:" + instance_variable_get("@curr_#{name}") +  "  vs pend_#{name}:" + instance_variable_get("@pend_#{name}") )
      end
    }
  end

  def current_profile_vs_running
    unless parsed_all?
      print 'Not all needed data are provided'
      pp @_parsed
      return false
    end

    # let's compare CPU and memory

    # let's compare virtual slots
    @profiles.each_pair { |name, profile|
      pp profile.to_s
    }

      # curr_pend = {
      #     'curr_min_mem' => 'pend_min_mem',
      #     'curr_mem' => 'pend_mem',
      #     'curr_max_mem' => 'pend_max_mem',
      #     'curr_min_num_huge_pages' => 'pend_min_num_huge_pages',
      #     'curr_num_huge_pages' => 'pend_num_huge_pages',
      #     'curr_max_num_huge_pages' => 'pend_max_num_huge_pages',
      #     'curr_proc_mode' => 'pend_proc_mode',
      #     'curr_min_procs' => 'pend_min_procs',
      #     'curr_procs' => 'pend_procs',
      #     'curr_max_procs' => 'pend_max_procs',
      #     'curr_sharing_mode' => 'pend_sharing_mode',
      #     'curr_min_proc_units' => 'pend_min_proc_units',
      #     'curr_proc_units' => 'pend_proc_units',
      #     'curr_max_proc_units' => 'pend_max_proc_units',
      #     'curr_uncap_weight' => 'pend_uncap_weight',
      #     'curr_shared_proc_pool_id' => 'pend_shared_proc_pool_id',
      #     'curr_max_virtual_slots' => 'pend_max_virtual_slots',
      # }

  end

end