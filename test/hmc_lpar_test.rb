$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << File.dirname(__FILE__) + './lib'

require 'Framework/HmcLpar'
require 'HMC/Lpar_profile'
require 'test/unit'
require 'pp'

class TestHMCLpar < Test::Unit::TestCase

  def test_profile_decode
    profile_string_normal = 'name=normal,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=2048,desired_mem=6144,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
    profile_string_low = 'name=low,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=1024,desired_mem=2048,max_mem=4096,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.2,max_proc_units=0.4,min_procs=1,desired_procs=1,max_procs=1,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'
    running_mem_string = 'lpar_name=nim1,lpar_id=5,curr_min_mem=1,curr_mem=2,curr_max_mem=3,pend_min_mem=4,pend_mem=5,pend_max_mem=6,run_min_mem=7,run_mem=8,curr_min_num_huge_pages=9,curr_num_huge_pages=10,curr_max_num_huge_pages=11,pend_min_num_huge_pages=12,pend_num_huge_pages=13,pend_max_num_huge_pages=14,run_num_huge_pages=15,mem_mode=ded,curr_hpt_ratio=1:64'


    profile_normal = Lpar_profile.new
    profile_normal.lssyscfgProfDecode(profile_string_normal)

    profile_low = Lpar_profile.new(5)
    profile_low.lssyscfgProfDecode(profile_string_low)

    lpar = Lpar.new(5)
    lpar.profile_add(profile_normal)
    lpar.profile_add(profile_low)
    lpar.decode_mem(running_mem_string)

    assert_equal(1, lpar.curr_min_mem)

    assert_equal(2,     lpar.profiles.count)
    assert_equal(true,  lpar.profile_exist?('normal'))
    assert_equal(true,  lpar.profile_exist?('low'))
    assert_equal(false, lpar.profile_exist?('big'))

    lpar.profile_delete('low')
    assert_equal(true,  lpar.profile_exist?('normal'))
    assert_equal(false,  lpar.profile_exist?('low'))
    assert_equal(false, lpar.profile_exist?('big'))

    lpar.profile_add(profile_string_low)
    assert_equal(true,  lpar.profile_exist?('low'))

  end


end