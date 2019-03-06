$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'Framework/system'
require 'test/unit'

class SystemTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # test data taken from: http://www-01.ibm.com/support/docview.wss?uid=isg3T7000527
  def test_system

    string='lpar_name=p72vio1,lpar_id=1,slot_num=2,state=1,is_required=0, is_trunk=1,trunk_priority=1,ieee_virtual_eth=1, port_vlan_id=1,vswitch=ETHERNET0," addl_vlan_ids=10,11",mac_addr=761FA3934802,allowed_os_mac_addrs=all,qos_priority=none
lpar_name=p72vio1,lpar_id=1,slot_num=3,state=1,is_required=0, is_trunk=1,trunk_priority=1,ieee_virtual_eth=1, port_vlan_id=2,vswitch=ETHERNET0," addl_vlan_ids=12,13",mac_addr=761FA3934803,allowed_os_mac_addrs=all,qos_priority=none
lpar_name=p72vio1,lpar_id=1,slot_num=4,state=1,is_required=0, is_trunk=0,ieee_virtual_eth=0, port_vlan_id=99,vswitch=ETHERNET0,addl_vlan_ids=,mac_addr=761FA3934804,allowed_os_mac_addrs=all,qos_priority=none
lpar_name=p72vio2,lpar_id=2,slot_num=2,state=1,is_required=0, is_trunk=1,trunk_priority=2,ieee_virtual_eth=1, port_vlan_id=1,vswitch=ETHERNET0," addl_vlan_ids=10,11",mac_addr=761FA4F6A602,allowed_os_mac_addrs=all,qos_priority=none
lpar_name=p72vio2,lpar_id=2,slot_num=3,state=1,is_required=0, is_trunk=1,trunk_priority=2,ieee_virtual_eth=1, port_vlan_id=2,vswitch=ETHERNET0," addl_vlan_ids=12,13",mac_addr=761FA4F6A603,allowed_os_mac_addrs=all,qos_priority=none
lpar_name=p72vio2,lpar_id=2,slot_num=4,state=1,is_required=0, is_trunk=0,ieee_virtual_eth=0, port_vlan_id=99,vswitch=ETHERNET0,addl_vlan_ids=,mac_addr=761FA4F6A604,allowed_os_mac_addrs=all,qos_priority=none
'

    system = System.new('p72')
    system.parse_raw_data(string)

    assert_equal(true,  system.lpar_name_exist?('p72vio1'))
    assert_equal(true,  system.lpar_name_exist?('p72vio2'))
    assert_equal(false, system.lpar_name_exist?('p72vio3'))
  end

  # test data source: own power5 frame
  def test_lpar
    string = 'name=aix53_15,lpar_id=15,lpar_env=aixlinux,state=Not Activated,resource_config=0,os_version=Unknown,logical_serial_num=6535CCGF,default_profile=normal,curr_profile=,work_group_id=none,shared_proc_pool_util_auth=1,allow_perf_collection=1,power_ctrl_lpar_ids=none,boot_mode=norm,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=,sync_curr_profile=0'

    system = System.new('power5')
    system.parse_raw_data(string)

    assert_equal(false, system.lpar_name_exist?('p72vio1'))
    assert_equal(true, system.lpar_name_exist?('aix53_15'))
  end

  # test data source: own power5 frame
  def test_vios_found
    string = 'name=nim1,lpar_id=5,lpar_env=aixlinux,state=Running,resource_config=1,os_version=AIX 5.3 5300-05-05-0123,logical_serial_num=6535CCG5,default_profile=normal,curr_profile=normal,work_group_id=none,shared_proc_pool_util_auth=0,allow_perf_collection=0,power_ctrl_lpar_ids=none,boot_mode=norm,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=active,rmc_ipaddr=192.168.200.235,sync_curr_profile=0
name=vios2,lpar_id=3,lpar_env=vioserver,state=Running,resource_config=1,os_version=Nieznane,logical_serial_num=6535CCG3,default_profile=normal,curr_profile=normal,work_group_id=none,shared_proc_pool_util_auth=0,allow_perf_collection=0,power_ctrl_lpar_ids=none,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=192.168.200.201,sync_curr_profile=0
name=vios1,lpar_id=2,lpar_env=vioserver,state=Running,resource_config=1,os_version=Nieznane,logical_serial_num=6535CCG2,default_profile=normal,curr_profile=normal,work_group_id=none,shared_proc_pool_util_auth=0,allow_perf_collection=0,power_ctrl_lpar_ids=none,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=1,rmc_state=inactive,rmc_ipaddr=192.168.200.200,sync_curr_profile=0
name=dump,lpar_id=1,lpar_env=aixlinux,state=Not Activated,resource_config=0,os_version=Nieznane,logical_serial_num=6535CCG1,default_profile=test_1,curr_profile=test_1,work_group_id=none,shared_proc_pool_util_auth=0,allow_perf_collection=0,power_ctrl_lpar_ids=none,boot_mode=sms,lpar_keylock=norm,auto_start=0,redundant_err_path_reporting=0,rmc_state=inactive,rmc_ipaddr=,sync_curr_profile=0
'

    system = System.new('power5')
    system.parse_raw_data(string)

    assert_equal(['vios1', 'vios2'], system.vioses.sort)

  end

end