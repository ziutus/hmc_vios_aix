require "pp"

class Lpar_profile

	attr_reader :sys, :dataString, :name, :lpar_name
	attr_reader :name, :lpar_id, :lpar_env
	attr_reader :all_resources
	attr_reader :min_mem, :desired_mem, :max_mem, :mem_mode, :hpt_ratio
	attr_reader :min_num_huge_pages, :desired_num_huge_pages, :max_num_huge_pages
	
	attr_reader :proc_mode, :min_proc_units, :desired_proc_units, :max_proc_units
	attr_reader 			:min_procs, 	 :desired_procs, 	  :max_procs

	attr_reader :sharing_mode, :uncap_weight
	attr_reader :io_slots, :io_slots_raw
	attr_reader :lpar_io_pool_ids, :lpar_io_pool_ids_raw
	attr_reader :max_virtual_slots
	attr_reader :virtual_serial_adapters_raw, :virtual_serial_adapters
	attr_reader :virtual_scsi_adapters_raw, :virtual_scsi_adapters
	attr_reader :virtual_eth_adapters_raw, :virtual_eth_adapters
	
	attr_reader :hca_adapters, :hca_adapters_raw, :auto_start, :conn_monitoring
	
	attr_reader :resource_config, :os_version, :logical_serial_num, :default_profile, :curr_profile, :work_group_id, :shared_proc_pool_util_auth, :allow_perf_collection 
	attr_reader :power_ctrl_lpar_ids, :boot_mode, :lpar_keylock, :redundant_err_path_reporting, :rmc_state, :rmc_ipaddr, :sync_curr_profile 

	
	
	def initialize sys, lpar_name, lpar_id, name="normal"
	
		@sys = sys 
	
		@dataString = ""
	
		@name = name
		@lpar_name = lpar_name
		@lpar_id = lpar_id

#		@allow_perf_collection=""
		@all_resources = ""
		@auto_start=0

		@boot_mode="norm"
		@conn_monitoring=1

		@hca_adapters_raw=""
		@hpt_ratio=""

		@io_slots_raw=""
		@lpar_env="aixlinux"
		@lpar_io_pool_ids="none"
#		@lpar_keylock=""

		@min_mem="512"
		@desired_mem="2048"
		@max_mem="4096"

		@min_procs="1"
		@desired_procs="2"
		@max_procs="3"

		@min_proc_units="0.1"
		@desired_proc_units="0.2"
		@max_proc_units="2.0"

		@max_virtual_slots="20"

		@mem_mode=""

		@power_ctrl_lpar_ids=""
		@proc_mode="shared"

		@redundant_err_path_reporting=0
		
#		@resource_config=""
		@shared_proc_pool_util_auth="1"
		@sharing_mode="uncap"
		
#		@sync_curr_profile=""

		@uncap_weight=128
		@virtual_eth_adapters_raw=""
		@virtual_scsi_adapters_raw=""
		@virtual_serial_adapters_raw=""
		
		@virtual_eth_adapters = []
		@virtual_scsi_adapters = []
		@virtual_serial_adapters = []
		
		@work_group_id=""
		

	end

	def get_mksyscfg
		result = "mksyscfg -r lpar -m #{@sys} -i \"name=#{@lpar_name},lpar_id=#{@lpar_id},profile_name=#{@name},"
		result += "lpar_env=#{@lpar_env},shared_proc_pool_util_auth=#{@shared_proc_pool_util_auth},min_mem=#{@min_mem},"
		result += "desired_mem=#{@desired_mem},max_mem=#{@max_mem},proc_mode=#{@proc_mode},"
		result += "min_proc_units=#{@min_proc_units},desired_proc_units=#{@desired_proc_units},max_proc_units=#{@max_proc_units},"
		result += "min_procs=#{@min_procs},desired_procs=#{@desired_procs}, max_procs=#{@max_procs},"
		result += "sharing_mode=#{@sharing_mode},uncap_weight=#{@uncap_weight},boot_mode=#{@boot_mode},"
		result += "conn_monitoring=#{@conn_monitoring},shared_proc_pool_util_auth=#{@shared_proc_pool_util_auth}"
		result += ",lpar_io_pool_ids=#{@lpar_io_pool_ids},"
		result += "max_virtual_slots=#{@max_virtual_slots}"

		result += ",io_slots=none";
		
		if (@virtual_eth_adapters.size == 0) 
			result +=  ",virtual_eth_adapters=none"
		 else 
			result +=  ",\"\\\"virtual_eth_adapters="
			adapters=[] 
			@virtual_eth_adapters.each { |adapter|
				adapters.push(adapter.to_s)
			}
			result += adapters.join(",")
			result +=  "\"\\\""
		end
		
		if (@virtual_scsi_adapters.size == 0) 
			result +=  ",virtual_scsi_adapters=none"
		else 
			result +=  ",\"\\\"virtual_scsi_adapters="
			adapters=[] 
			@virtual_scsi_adapters.each { |adapter|
				adapters.push(adapter.to_s)
			}
			result += adapters.join(",")
			result +=  "\"\\\""
		end
		
		
		result += "\""
		
		result 
	end
	
	def adapter_eth_add adapter
		@virtual_eth_adapters.push(adapter)
	end
	
	def adapter_scsi_add adapter
		@virtual_scsi_adapters.push(adapter)
	end	
	
	def remove
		"rmsyscfg -m #{@sys} -r lpar -n #{@lpar_name}"
	end
	
	def lssyscfgDecode string
		
		parameters = string.split(",")
		
		parameters.each { |x| 
			key, value = x.split("=")
		
			value = "" if value==nil
	
			case key 

				when "name" 				then				@name=value
				when "lpar_id" 				then				@lpar_id=value
				when "lpar_env" 			then				@lpar_env=value
				when "state" 				then				@state=value
				when "resource_config" 		then				@resource_config=value
				when "os_version" 			then				@os_version=value
				when "logical_serial_num" 	then				@logical_serial_num=value
				when "default_profile" 		then				@default_profile=value
				when "curr_profile" 		then				@curr_profile=value
				when "work_group_id" 		then				@work_group_id=value
				when "shared_proc_pool_util_auth" then			@shared_proc_pool_util_auth=value
				when "allow_perf_collection" then				@allow_perf_collection=value
				when "power_ctrl_lpar_ids" 	then				@power_ctrl_lpar_ids=value
				when "boot_mode" 			then				@boot_mode=value
				when "lpar_keylock" 		then				@lpar_keylock=value
				when "auto_start" 			then				@auto_start=value
				when "redundant_err_path_reporting" then		@redundant_err_path_reporting=value
				when "rmc_state" 			then				@rmc_state=value
				when "rmc_ipaddr" 			then				@rmc_ipaddr=value
				when "sync_curr_profile" 	then				@sync_curr_profile=value			
				else
					abort "Unknown key #{key} with value #{value}, exiting... \n"
			end
		}			
	end
	
	def lssyscfgProfDecode string 
#		puts "Will decode string" + string
	
		regExp = %r{name=([\w\_\-]+),lpar_name=([\w\_\-]+),lpar_id=(\d+),lpar_env=(aixlinux|vioserver),all_resources=(\d+),
		min_mem=(\d+),desired_mem=(\d+),max_mem=(\d+),mem_mode=(ded),hpt_ratio=(\d+:\d+),
		proc_mode=(shared),min_proc_units=(\d+\.\d+),desired_proc_units=(\d+\.\d+),max_proc_units=(\d+\.\d+),
		min_procs=(\d+),desired_procs=(\d+),max_procs=(\d+),sharing_mode=(cap|uncap),uncap_weight=(\d+),
		(?:\"|)io_slots=(none|[\w\/\,]+)(?:\"|),
		(?:\"|)lpar_io_pool_ids=(none|[\w\/\,]+)(?:\"|),
		max_virtual_slots=(\d+),
		(?:\"|)virtual_serial_adapters=(.*?)(?:\"|),
		(?:\"|)virtual_scsi_adapters=(.*?)(?:\"|),
		(?:\"|)virtual_eth_adapters=(.*?)(?:\"|),
		(?:\"|)hca_adapters=(.*?)(?:\"|),
		boot_mode=(norm),conn_monitoring=(\d+),auto_start=(\d+),power_ctrl_lpar_ids=(none),work_group_id=(none),
		redundant_err_path_reporting=(\d+)
		}x

		regExp2 = %r{name=([\w\_\-]+),lpar_name=([\w\_\-]+),lpar_id=(\d+),lpar_env=(aixlinux|vioserver),all_resources=(\d+),
		min_mem=(\d+),desired_mem=(\d+),max_mem=(\d+),
		min_num_huge_pages=(\d+),desired_num_huge_pages=(\d+),max_num_huge_pages=(\d+),mem_mode=(ded),hpt_ratio=(\d+:\d+),
		proc_mode=(shared),min_proc_units=(\d+\.\d+),desired_proc_units=(\d+\.\d+),max_proc_units=(\d+\.\d+),
		min_procs=(\d+),desired_procs=(\d+),max_procs=(\d+),sharing_mode=(cap|uncap),uncap_weight=(\d+),
		(?:\"|)io_slots=(none|[\w\/\,]+)(?:\"|),
		(?:\"|)lpar_io_pool_ids=(none|[\w\/\,]+)(?:\"|),
		max_virtual_slots=(\d+),
		(?:\"|)virtual_serial_adapters=(.*?)(?:\"|),
		(?:\"|)virtual_scsi_adapters=(.*?)(?:\"|),
		(?:\"|)virtual_eth_adapters=(.*?)(?:\"|),
		(?:\"|)hca_adapters=(.*?)(?:\"|),
		boot_mode=(norm),conn_monitoring=(\d+),auto_start=(\d+),power_ctrl_lpar_ids=(none),work_group_id=(none),
		redundant_err_path_reporting=(\d+)
		}x
		

		match   = regExp.match(string)
		match2  = regExp2.match(string)
		

#		puts "regexp is working..."
#		pp match

		if match 	
			@name 		= match[1]
			@lpar_name 	= match[2]
			@lpar_id 	= match[3].to_i
			@lpar_env	= match[4]
			@all_resources = match[5].to_i 

			@min_mem	 = match[6].to_i
			@desired_mem = match[7].to_i 
			@max_mem	 = match[8].to_i 
			@mem_mode	 = match[9]
			@hpt_ratio   = match[10]

			@proc_mode	 = match[11]

			@min_proc_units		= match[12]
			@desired_proc_units	= match[13]
			@max_proc_units		= match[14]
			
			@min_procs		= match[15].to_i
			@desired_procs	= match[16].to_i
			@max_procs		= match[17].to_i

			@sharing_mode   = match[18]
			@uncap_weight	= match[19].to_i

			@io_slots_raw   	  = match[20]		
			@lpar_io_pool_ids_raw = match[21]

			@max_virtual_slots 	  = match[22].to_i
			
			@virtual_serial_adapters_raw = match[23]
			@virtual_scsi_adapters_raw   = match[24]
			@virtual_eth_adapters_raw	 = match[25]
			@hca_adapters_raw			 = match[26]
			@boot_mode					 = match[27]
			@conn_monitoring 			 = match[28].to_i 
			@auto_start					 = match[29].to_i 
			@power_ctrl_lpar_ids		 = match[30]
			@work_group_id				 = match[31]
			@redundant_err_path_reporting= match[32].to_i 

		elsif match2 
#			pp match2 
		
			@name 		= match2[1]
			@lpar_name 	= match2[2]
			@lpar_id 	= match2[3].to_i
			@lpar_env	= match2[4]
			@all_resources = match2[5].to_i 

			@min_mem	 = match2[6].to_i
			@desired_mem = match2[7].to_i 
			@max_mem	 = match2[8].to_i 
			
			@min_num_huge_pages		= match2[9].to_i 
			@desired_num_huge_pages = match2[10].to_i 
			@max_num_huge_pages		= match2[11].to_i		

			
			@mem_mode	 = match2[12]
			@hpt_ratio   = match2[13]

			@proc_mode	 = match2[14]

			@min_proc_units		= match2[15]
			@desired_proc_units	= match2[16]
			@max_proc_units		= match2[17]
			
			@min_procs		= match2[18].to_i
			@desired_procs	= match2[19].to_i
			@max_procs		= match2[20].to_i

			@sharing_mode   = match2[21]
			@uncap_weight	= match2[22].to_i

			@io_slots_raw   	  = match2[23]		
			@lpar_io_pool_ids_raw = match2[24]

			@max_virtual_slots 	  = match2[25].to_i
			
			@virtual_serial_adapters_raw = match2[26]
			@virtual_scsi_adapters_raw   = match2[27]
			@virtual_eth_adapters_raw	 = match2[28]
			@hca_adapters_raw			 = match2[29]
			@boot_mode					 = match2[30]
			@conn_monitoring 			 = match2[31].to_i 
			@auto_start					 = match2[32].to_i 
			@power_ctrl_lpar_ids		 = match2[33]
			@work_group_id				 = match2[34]
			@redundant_err_path_reporting= match2[35].to_i 
							
		else 
	
			puts string
			puts match 
			puts "RegExp couldn't decode string >#{string}<"
			raise 
	
		end
		
		@virtual_eth_adapters = []
		@virtual_scsi_adapters = []
		@virtual_serial_adapters = []

		
	end
	
	
end	