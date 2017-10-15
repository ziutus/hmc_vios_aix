$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'HMC/Lpar_real'
require 'test/unit'
require 'pp'

class TestHMCLpar < Test::Unit::TestCase
 
	def test_lpar_commands
		lpar = Lpar_real.new('Frame1', 1, 'lpar1')
		assert_equal('chsysstate -m Frame1 -r lpar -n lpar1 -o shutdown',     lpar.stop_cmd)
		assert_equal('chsysstate -m Frame1 -r lpar -n lpar1 -o on -f normal', lpar.start_cmd('normal') )
	end
  
	def test_lpar_lssyscfg_decode
		lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
		string = 'name=aix53_15,lpar_id=15,lpar_env=aixlinux,state=Not Activated,resource_config=0,os_version=Unknown,logical_serial_num=6535CCGF,default_profile=normal,curr_profile=,work_group_id=none,shared_proc_pool_util_auth=1,allow_perf_collection=1,power_ctrl_lpar_ids=none,boot_mode=norm,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=,sync_curr_profile=0'

		lpar.lssyscfgDecode(string)
		
		assert_equal('aix53_15', lpar.name)
		assert_equal(15,       lpar.lpar_id)
		assert_equal('aixlinux', lpar.lpar_env)
		assert_equal('Not Activated', lpar.state)
		assert_equal('0', lpar.resource_config)
		assert_equal('Unknown',  lpar.os_version)
		assert_equal('6535CCGF', lpar.logical_serial_num)
		assert_equal('normal',   lpar.default_profile)
		assert_equal('',         lpar.curr_profile)
		assert_equal('none',      lpar.work_group_id)
		assert_equal(1,        lpar.shared_proc_pool_util_auth)
		assert_equal(1,        lpar.allow_perf_collection)
		assert_equal('none',     lpar.power_ctrl_lpar_ids)
		assert_equal('norm',     lpar.boot_mode)
		assert_equal('norm',     lpar.lpar_keylock)
		assert_equal(0,        lpar.auto_start)
		assert_equal(0,        lpar.redundant_err_path_reporting,)
		assert_equal('inactive', lpar.rmc_state)
		assert_equal('',         lpar.rmc_ipaddr)
		assert_equal(0,        lpar.sync_curr_profile)
	end
	
	def test_memory_decode
			string = 'lpar_name=aix53_15,lpar_id=15,curr_min_mem=1,curr_mem=2,curr_max_mem=3,pend_min_mem=4,pend_mem=5,pend_max_mem=6,run_min_mem=7,run_mem=8,curr_min_num_huge_pages=9,curr_num_huge_pages=10,curr_max_num_huge_pages=11,pend_min_num_huge_pages=12,pend_num_huge_pages=13,pend_max_num_huge_pages=14,run_num_huge_pages=15,mem_mode=ded,curr_hpt_ratio=1:64'
		
			lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
			lpar.decodeMem(string)
			
			assert_equal(lpar.curr_min_mem, 			     1)
			assert_equal(lpar.curr_mem, 				       2)
			assert_equal(lpar.curr_max_mem, 			     3)
			assert_equal(lpar.pend_min_mem, 			     4)
			assert_equal(lpar.pend_mem, 			 	       5)
			assert_equal(lpar.pend_max_mem, 			     6)
			assert_equal(lpar.run_min_mem, 			       7)
			assert_equal(lpar.run_mem, 				         8)
			assert_equal(lpar.curr_min_num_huge_pages, 9)
			assert_equal(lpar.curr_num_huge_pages, 	   10)
			assert_equal(lpar.curr_max_num_huge_pages, 11)
			assert_equal(lpar.pend_min_num_huge_pages, 12)
			assert_equal(lpar.pend_num_huge_pages, 	   13)
			assert_equal(lpar.pend_max_num_huge_pages, 14)
			assert_equal(lpar.run_num_huge_pages, 	   15)
			assert_equal(lpar.mem_mode,             'ded')
			assert_equal(lpar.curr_hpt_ratio,      '1:64')


			
	end
	
	def test_proc_dedicated_decode
		string = 'lpar_name=aix53_15,lpar_id=15,curr_proc_mode=ded,curr_min_procs=1,curr_procs=2,curr_max_procs=3,curr_sharing_mode=share_idle_procs,pend_proc_mode=ded,pend_min_procs=4,pend_procs=5,pend_max_procs=6,pend_sharing_mode=share_idle_procs,run_procs=7'
	
		lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
		lpar.decodeProc(string)	

		assert_equal('ded', lpar.curr_proc_mode)
		
		assert_equal(15, lpar.lpar_id)
		assert_equal(1,	 lpar.curr_min_procs)
		assert_equal(2,	 lpar.curr_procs)
		assert_equal(3,	 lpar.curr_max_procs)

		assert_equal('share_idle_procs', lpar.pend_sharing_mode)
		assert_equal('ded', lpar.pend_proc_mode)

		assert_equal(4,	 lpar.pend_min_procs)
		assert_equal(5,	 lpar.pend_procs)
		assert_equal(6,  lpar.pend_max_procs)

		assert_equal('share_idle_procs', lpar.curr_sharing_mode)
		
		assert_equal(7,	 lpar.run_procs)
	
	end
	
	def test_proc_shared_decode
	
		string='lpar_name=aix61_8,lpar_id=8,curr_shared_proc_pool_id=0,curr_proc_mode=shared,curr_min_proc_units=0.2,curr_proc_units=1.0,curr_max_proc_units=2.0,curr_min_procs=1,curr_procs=1,curr_max_procs=2,curr_sharing_mode=uncap,curr_uncap_weight=128,pend_shared_proc_pool_id=0,pend_proc_mode=shared,pend_min_proc_units=0.2,pend_proc_units=1.0,pend_max_proc_units=2.0,pend_min_procs=1,pend_procs=1,pend_max_procs=2,pend_sharing_mode=uncap,pend_uncap_weight=128,run_proc_units=0.0,run_procs=0,run_uncap_weight=0'

		lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
		lpar.decodeProc(string)
		
		assert_equal(0,         lpar.curr_shared_proc_pool_id)
		assert_equal('shared', 	lpar.curr_proc_mode)
		assert_equal(0.2, 	lpar.curr_min_proc_units)
		assert_equal(1.0, 	lpar.curr_proc_units)
		assert_equal(2.0, 	lpar.curr_max_proc_units)
		assert_equal(1,			lpar.curr_min_procs)
		assert_equal(1,			lpar.curr_procs)
		assert_equal(2, 		lpar.curr_max_procs)
		assert_equal('uncap',	lpar.curr_sharing_mode)
		assert_equal(128,		lpar.curr_uncap_weight)
		assert_equal(0,			lpar.pend_shared_proc_pool_id)
		assert_equal('shared',	lpar.pend_proc_mode)
		assert_equal(0.2,		lpar.pend_min_proc_units)
		assert_equal(1.0,		lpar.pend_proc_units)
		assert_equal(2.0,		lpar.pend_max_proc_units)
		assert_equal(1,			lpar.pend_min_procs)
		assert_equal(1,			lpar.pend_procs)
		assert_equal(2,			lpar.pend_max_procs)
		assert_equal('uncap',	lpar.pend_sharing_mode)
		assert_equal(128,		lpar.pend_uncap_weight)
		assert_equal(0.0,		lpar.run_proc_units)
		assert_equal(0,			lpar.run_procs)
		assert_equal(0,			lpar.run_uncap_weight)
	
	end
	
	
	def test_virtualio_slot
		string = 'lpar_name=aix53_15,lpar_id=15,curr_max_virtual_slots=8,pend_max_virtual_slots=9,next_avail_virtual_slot=2'
		
		lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
		lpar.decodeVirtualioSlot(string)
		
		assert_equal(8, 	lpar.curr_max_virtual_slots)
		assert_equal(9, 	lpar.pend_max_virtual_slots)
		assert_equal(2, 	lpar.next_avail_virtual_slot)
		
	end
	
	def test_virtualio_eth
	
		string = 'lpar_name=vios1,lpar_id=15,slot_num=6,state=1,is_required=0,is_trunk=0,ieee_virtual_eth=0,port_vlan_id=6,addl_vlan_ids=,mac_addr=26E6B0002006
lpar_name=vios1,lpar_id=15,slot_num=7,state=1,is_required=0,is_trunk=1,trunk_priority=1,ieee_virtual_eth=0,port_vlan_id=7,addl_vlan_ids=,mac_addr=26E6B0002007
lpar_name=vios1,lpar_id=15,slot_num=9,state=1,is_required=0,is_trunk=1,trunk_priority=1,ieee_virtual_eth=0,port_vlan_id=9,addl_vlan_ids=,mac_addr=26E6B0002009'
		
		lpar = Lpar_real.new('9131-52A-6535CCG', 15, 'aix53_15')
		lpar.decodeVirtualioEth(string)
		
		#pp myLpar
		assert_equal(0,     lpar.virtual_adapter_first_free)
		assert_equal(false, lpar.virtual_adapter_exit?(2))
		assert_equal(true,  lpar.virtual_adapter_exit?(6))
		
	end
	
end	