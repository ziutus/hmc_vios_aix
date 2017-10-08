$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Lpar_profile'
require 'HMC/VirtualEthAdapter'
require 'test/unit'


class TestHMCLparProfileCompare < Test::Unit::TestCase

  def test_check_power_5_to_s
    string = 'name=normal,lpar_name=vios2,lpar_id=3,lpar_env=vioserver,all_resources=0,min_mem=1024,desired_mem=6144,max_mem=10240,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.6,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,"io_slots=21010002/none/1,21050003/none/1",lpar_io_pool_ids=none,max_virtual_slots=200,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1",virtual_scsi_adapters=2/server/5/nim1/3/0,"virtual_eth_adapters=6/0/6//2/1,8/0/8//2/1,9/0/6//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
    profile = Lpar_profile.new('9131-52A-6535CCG', 5, 'nim1')
    profile.lssyscfgProfDecode(string)

    assert_equal(string, profile.to_s)
  end

  def test_profile_to_s_2
    string = 'name=p590n22 normal,lpar_name=p590n22,lpar_id=22,lpar_env=aixlinux,all_resources=0,min_mem=1024,desired_mem=4608,max_mem=6144,proc_mode=shared,min_proc_units=1.0,desired_proc_units=1.0,max_proc_units=4.0,min_procs=1,desired_procs=1,max_procs=8,sharing_mode=uncap,uncap_weight=128,"io_slots=2104001C/none/1,21020025/none/1,21040025/none/1,21010020/none/1,21030025/none/1",lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=1/server/1/any//any/1,0/server/1/any//any/1","virtual_scsi_adapters=2/client/1/p590v01/22/0,3/client/2/p590v02/22/0",virtual_eth_adapters=none,sni_device_ids=none,hca_adapters=none,boot_mode=norm,conn_monitoring=1,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=null'

    profile = Lpar_profile.new()
    profile.lssyscfgProfDecode(string)

    assert_equal(string, profile.to_s)

  end

  #source of data, own Power5 frame
  def profile_compare
    profile1_string='name=normal,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=2048,desired_mem=6144,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
    profile2_string='name=backup,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=1024,desired_mem=5120,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=12,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=8/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'

    profile1 = Lpar_profile.new('9131-52A-6535CCG', 5, 'nim1')
    profile1.lssyscfgProfDecode(profile1_string)

    profile2 = Lpar_profile.new('9131-52A-6535CCG', 5, 'nim1')
    profile2.lssyscfgProfDecode(profile2_string)

  end
end