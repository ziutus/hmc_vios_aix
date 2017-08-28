$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Lpar_profile'
require 'HMC/VirtualEthAdapter'
require "test/unit"


class TestHMCLparProfile < Test::Unit::TestCase
 
  

	
	def test_memory_decode
			string = 'name=normal,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=2048,desired_mem=6144,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
		
			myLpar = Lpar_profile.new("9131-52A-6535CCG", 5, "nim1")
			myLpar.lssyscfgProfDecode(string)
			
			assert_equal("normal", myLpar.name)
			assert_equal("nim1",   myLpar.lpar_name)
			assert_equal(5,      myLpar.lpar_id)
			assert_equal("aixlinux", myLpar.lpar_env)
			assert_equal(0,     myLpar.all_resources)
			assert_equal(2048,  myLpar.min_mem)
			assert_equal(6144,  myLpar.desired_mem)
			assert_equal(10240, myLpar.max_mem)
			assert_equal(0,     myLpar.min_num_huge_pages)
			assert_equal(0,     myLpar.desired_num_huge_pages)
			assert_equal(0,     myLpar.max_num_huge_pages)
			assert_equal("ded", myLpar.mem_mode)
			assert_equal("1:64",   myLpar.hpt_ratio)
			assert_equal("shared", myLpar.proc_mode)
			assert_equal("0.1",    myLpar.min_proc_units)
			assert_equal("0.3",    myLpar.desired_proc_units)
			assert_equal("0.8",    myLpar.max_proc_units)
			assert_equal(1,        myLpar.min_procs)
			assert_equal(1,        myLpar.desired_procs)
			assert_equal(2,        myLpar.max_procs)
			assert_equal("cap",    myLpar.sharing_mode)
			assert_equal(0,		   myLpar.uncap_weight)
			assert_equal("none",   myLpar.io_slots_raw)
			assert_equal("none",   myLpar.lpar_io_pool_ids_raw)
			assert_equal(10,       myLpar.max_virtual_slots)
			assert_equal("0/server/1/any//any/1,1/server/1/any//any/1", myLpar.virtual_serial_adapters_raw)
			assert_equal("2/client/2/vios1/2/1,3/client/3/vios2/2/1",   myLpar.virtual_scsi_adapters_raw)
			assert_equal("6/1/6//0/0,7/0/7//0/0",                       myLpar.virtual_eth_adapters_raw)
			assert_equal("none", myLpar.hca_adapters_raw)
			assert_equal("norm", myLpar.boot_mode)
			assert_equal(0,      myLpar.conn_monitoring)
			assert_equal(0,      myLpar.auto_start)
			assert_equal("none", myLpar.power_ctrl_lpar_ids)
			assert_equal("none", myLpar.work_group_id)
			assert_equal(0,      myLpar.redundant_err_path_reporting)

	end
	
end			
		