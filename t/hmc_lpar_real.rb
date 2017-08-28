$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Lpar_real'
require 'HMC/VirtualEthAdapter'
require "test/unit"
require "pp"

class TestHMCLpar < Test::Unit::TestCase
 
	def test_lpar_commands
		myLpar = Lpar_real.new("Frame1", 1, "lpar1")
		assert_equal("chsysstate -m Frame1 -r lpar -n lpar1 -o shutdown", myLpar.stop() )
		assert_equal("chsysstate -m Frame1 -r lpar -n lpar1 -o on -f normal", myLpar.start("normal") )
	end
  
	def test_lpar_lssyscfg_decode
		myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
		string = "name=aix53_15,lpar_id=15,lpar_env=aixlinux,state=Not Activated,resource_config=0,os_version=Unknown,logical_serial_num=6535CCGF,default_profile=normal,curr_profile=,work_group_id=none,shared_proc_pool_util_auth=1,allow_perf_collection=1,power_ctrl_lpar_ids=none,boot_mode=norm,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=,sync_curr_profile=0"

		myLpar.lssyscfgDecode(string)
		
		assert_equal(myLpar.name,			"aix53_15")
		assert_equal(myLpar.lpar_id,		"15")
		assert_equal(myLpar.lpar_env,		"aixlinux")
		assert_equal(myLpar.state,			"Not Activated")
		assert_equal(myLpar.resource_config,"0")
		assert_equal(myLpar.os_version,		"Unknown")
		assert_equal(myLpar.logical_serial_num,"6535CCGF")
		assert_equal(myLpar.default_profile,"normal")
		assert_equal(myLpar.curr_profile,	"")
		assert_equal(myLpar.work_group_id,	"none")
		assert_equal(myLpar.shared_proc_pool_util_auth,"1")
		assert_equal(myLpar.allow_perf_collection,"1")
		assert_equal(myLpar.power_ctrl_lpar_ids,"none")
		assert_equal(myLpar.boot_mode,		"norm")
		assert_equal(myLpar.lpar_keylock,	"norm")
		assert_equal(myLpar.auto_start,		"0")
		assert_equal(myLpar.redundant_err_path_reporting,"0")
		assert_equal(myLpar.rmc_state,			"inactive")
		assert_equal(myLpar.rmc_ipaddr,			"")
		assert_equal(myLpar.sync_curr_profile,	"0")
	end
	
	def test_memory_decode
			string = "lpar_name=aix53_15,lpar_id=15,curr_min_mem=1,curr_mem=2,curr_max_mem=3,pend_min_mem=4,pend_mem=5,pend_max_mem=6,run_min_mem=7,run_mem=8,curr_min_num_huge_pages=9,curr_num_huge_pages=10,curr_max_num_huge_pages=11,pend_min_num_huge_pages=12,pend_num_huge_pages=13,pend_max_num_huge_pages=14,run_num_huge_pages=15,mem_mode=ded,curr_hpt_ratio=1:64"
		
			myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
			myLpar.decodeMem(string)
			
			assert_equal(myLpar.curr_min_mem, 			  1)
			assert_equal(myLpar.curr_mem, 				  2)
			assert_equal(myLpar.curr_max_mem, 			  3)
			assert_equal(myLpar.pend_min_mem, 			  4)
			assert_equal(myLpar.pend_mem, 			 	  5)
			assert_equal(myLpar.pend_max_mem, 			  6)
			assert_equal(myLpar.run_min_mem, 			  7)
			assert_equal(myLpar.run_mem, 				  8)
			assert_equal(myLpar.curr_min_num_huge_pages,  9)
			assert_equal(myLpar.curr_num_huge_pages, 	 10)
			assert_equal(myLpar.curr_max_num_huge_pages, 11)
			assert_equal(myLpar.pend_min_num_huge_pages, 12)
			assert_equal(myLpar.pend_num_huge_pages, 	 13)
			assert_equal(myLpar.pend_max_num_huge_pages, 14)
			assert_equal(myLpar.run_num_huge_pages, 	 15)
			assert_equal(myLpar.mem_mode, 			  "ded")
			assert_equal(myLpar.curr_hpt_ratio, 	 "1:64")			


			
	end
	
	def test_proc_dedicated_decode
		string = "lpar_name=aix53_15,lpar_id=15,curr_proc_mode=ded,curr_min_procs=1,curr_procs=2,curr_max_procs=3,curr_sharing_mode=share_idle_procs,pend_proc_mode=ded,pend_min_procs=4,pend_procs=5,pend_max_procs=6,pend_sharing_mode=share_idle_procs,run_procs=7"
	
		myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
		myLpar.decodeProc(string)	

		assert_equal("ded",	myLpar.curr_proc_mode)
		
		assert_equal(15, myLpar.lpar_id)
		assert_equal(1,	 myLpar.curr_min_procs)
		assert_equal(2,	 myLpar.curr_procs)
		assert_equal(3,	 myLpar.curr_max_procs)

		assert_equal("share_idle_procs", myLpar.pend_sharing_mode)
		assert_equal("ded",	myLpar.pend_proc_mode)

		assert_equal(4,	 myLpar.pend_min_procs)
		assert_equal(5,	 myLpar.pend_procs)
		assert_equal(6,  myLpar.pend_max_procs)

		assert_equal("share_idle_procs",  myLpar.curr_sharing_mode)
		
		assert_equal(7,	 myLpar.run_procs)
	
	end
	
	def test_proc_shared_decode
	
		string="lpar_name=aix61_8,lpar_id=8,curr_shared_proc_pool_id=0,curr_proc_mode=shared,curr_min_proc_units=0.2,curr_proc_units=1.0,curr_max_proc_units=2.0,curr_min_procs=1,curr_procs=1,curr_max_procs=2,curr_sharing_mode=uncap,curr_uncap_weight=128,pend_shared_proc_pool_id=0,pend_proc_mode=shared,pend_min_proc_units=0.2,pend_proc_units=1.0,pend_max_proc_units=2.0,pend_min_procs=1,pend_procs=1,pend_max_procs=2,pend_sharing_mode=uncap,pend_uncap_weight=128,run_proc_units=0.0,run_procs=0,run_uncap_weight=0"

		myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
		myLpar.decodeProc(string)
		
		assert_equal(0,         myLpar.curr_shared_proc_pool_id)
		assert_equal("shared", 	myLpar.curr_proc_mode)
		assert_equal("0.2", 	myLpar.curr_min_proc_units)
		assert_equal("1.0", 	myLpar.curr_proc_units)
		assert_equal("2.0", 	myLpar.curr_max_proc_units)
		assert_equal(1,			myLpar.curr_min_procs)
		assert_equal(1,			myLpar.curr_procs)
		assert_equal(2, 		myLpar.curr_max_procs)
		assert_equal("uncap",	myLpar.curr_sharing_mode)
		assert_equal(128,		myLpar.curr_uncap_weight)
		assert_equal(0,			myLpar.pend_shared_proc_pool_id)
		assert_equal("shared",	myLpar.pend_proc_mode)
		assert_equal("0.2",		myLpar.pend_min_proc_units)
		assert_equal("1.0",		myLpar.pend_proc_units)
		assert_equal("2.0",		myLpar.pend_max_proc_units)
		assert_equal(1,			myLpar.pend_min_procs)
		assert_equal(1,			myLpar.pend_procs)
		assert_equal(2,			myLpar.pend_max_procs)
		assert_equal("uncap",	myLpar.pend_sharing_mode)
		assert_equal(128,		myLpar.pend_uncap_weight)
		assert_equal("0.0",		myLpar.run_proc_units)
		assert_equal(0,			myLpar.run_procs)
		assert_equal(0,			myLpar.run_uncap_weight)
	
	end
	
	
	def test_virtualio_slot
		string = "lpar_name=aix53_15,lpar_id=15,curr_max_virtual_slots=8,pend_max_virtual_slots=9,next_avail_virtual_slot=2"
		
		myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
		myLpar.decodeVirtualioSlot(string)
		
		assert_equal(8, 	myLpar.curr_max_virtual_slots)
		assert_equal(9, 	myLpar.pend_max_virtual_slots)
		assert_equal(2, 	myLpar.next_avail_virtual_slot)
		
	end
	
	def test_virtualio_eth
	
		string = "lpar_name=vios1,lpar_id=15,slot_num=6,state=1,is_required=0,is_trunk=0,ieee_virtual_eth=0,port_vlan_id=6,addl_vlan_ids=,mac_addr=26E6B0002006
lpar_name=vios1,lpar_id=15,slot_num=7,state=1,is_required=0,is_trunk=1,trunk_priority=1,ieee_virtual_eth=0,port_vlan_id=7,addl_vlan_ids=,mac_addr=26E6B0002007
lpar_name=vios1,lpar_id=15,slot_num=9,state=1,is_required=0,is_trunk=1,trunk_priority=1,ieee_virtual_eth=0,port_vlan_id=9,addl_vlan_ids=,mac_addr=26E6B0002009"	
		
		myLpar = Lpar_real.new("9131-52A-6535CCG", 15, "aix53_15")
		myLpar.decodeVirtualioEth(string)
		
		#pp myLpar
		assert_equal(0, myLpar.virtual_adapter_first_free())
		assert_equal(false, myLpar.virtual_adapter_exit?(2))
		assert_equal(true, myLpar.virtual_adapter_exit?(6))
		
	end
	
end	