$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Lpar_profile'
require "test/unit"
require "pp"

class TestLparProfile2 < Test::Unit::TestCase

	def test_profile_decode()

		string = 'name=normal,lpar_name=vios2,lpar_id=3,lpar_env=vioserver,all_resources=0,min_mem=1024,desired_mem=6144,max_mem=10240,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.6,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,"io_slots=21010002/none/1,21050003/none/1",lpar_io_pool_ids=none,max_virtual_slots=200,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=2/server/5/nim1/3/0,"virtual_eth_adapters=6/0/6//2/1,8/0/8//2/1,9/0/6//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
		profile = Lpar_profile.new("System", "vios2", 3, "normal")
		profile.lssyscfgProfDecode(string)
		
		assert_equal(profile.name, 							"normal")
		assert_equal(profile.lpar_name,						"vios2")
		assert_equal(profile.lpar_id,						3) 
		assert_equal(profile.lpar_env, 						"vioserver")
		assert_equal(profile.all_resources,					0)
		assert_equal(profile.min_mem,						1024)
		assert_equal(profile.desired_mem,					6144)
		assert_equal(profile.max_mem,						10240)
		assert_equal(profile.mem_mode,						"ded")
		assert_equal(profile.hpt_ratio,						"1:64")
		assert_equal(profile.proc_mode,						"shared")
		assert_equal(profile.min_proc_units,				"0.1")
		assert_equal(profile.desired_proc_units,			"0.3")
		assert_equal(profile.max_proc_units,				"0.6")
		assert_equal(profile.min_procs,						1)
		assert_equal(profile.desired_procs,					1)
		assert_equal(profile.max_procs,						1)
		assert_equal(profile.sharing_mode,					"cap")
		assert_equal(profile.uncap_weight,					0)
		assert_equal(profile.io_slots_raw,					"21010002/none/1,21050003/none/1")
		assert_equal(profile.lpar_io_pool_ids,				"none")
		assert_equal(profile.max_virtual_slots,				200)
		assert_equal("0/server/1/any//any/1,1/server/1/any//any/1", profile.virtual_serial_adapters_raw)
		assert_equal("2/server/5/nim1/3/0",						    profile.virtual_scsi_adapters_raw)
		assert_equal("6/0/6//2/1,8/0/8//2/1,9/0/6//0/0",			profile.virtual_eth_adapters_raw)
		assert_equal("none", profile.hca_adapters_raw)
		assert_equal("norm", profile.boot_mode)
		assert_equal(0,      profile.conn_monitoring)
		assert_equal(0,      profile.auto_start)
		assert_equal("none", profile.power_ctrl_lpar_ids)
		assert_equal("none", profile.work_group_id)
		assert_equal(0,      profile.redundant_err_path_reporting)		
		
	end 
end
