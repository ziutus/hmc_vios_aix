$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Sys'
require "test/unit"
require 'pp'


class TestHMCSystem < Test::Unit::TestCase

  # test data taken from: https://www.ibm.com/support/knowledgecenter/en/SGVKBA_3.2.2/com.ibm.rsct.trouble/RMC_connection_diagnosis.htm
  def test_name
        string = 'name=9131-52A-6535CCG,type_model=9131-52A,serial_num=6535CCG,ipaddr=192.168.200.39,state=Power Off,detailed_state=None,sys_time=10/04/2017 16:41:46,power_off_policy=unavailable,active_lpar_mobility_capable=unavailable,inactive_lpar_mobility_capable=unavailable,active_lpar_share_idle_procs_capable=unavailable,active_mem_expansion_capable=unavailable,hardware_active_mem_expansion_capable=unavailable,active_mem_sharing_capable=unavailable,addr_broadcast_perf_policy_capable=0,bsr_capable=unavailable,cod_mem_capable=unavailable,cod_proc_capable=unavailable,dynamic_platform_optimization_capable=unavailable,electronic_err_reporting_capable=unavailable,firmware_power_saver_capable=0,hardware_power_saver_capable=0,hardware_discovery_capable=unavailable,hca_capable=1,huge_page_mem_capable=1,lhea_capable=unavailable,lpar_avail_priority_capable=unavailable,lpar_proc_compat_mode_capable=unavailable,lpar_remote_restart_capable=unavailable,powervm_lpar_remote_restart_capable=unavailable,lpar_suspend_capable=unavailable,micro_lpar_capable=unavailable,os400_capable=unavailable,redundant_err_path_reporting_capable=unavailable,shared_eth_failover_capable=unavailable,sni_msg_passing_capable=0,sp_failover_capable=1,vet_activation_capable=unavailable,virtual_fc_capable=unavailable,virtual_io_server_capable=unavailable,virtual_switch_capable=unavailable,vsn_phase2_capable=unavailable,vsi_on_veth_capable=unavailable,assign_5250_cpw_percent=unavailable,max_lpars=unavailable,max_power_ctrl_lpars=0,max_remote_restart_capable_lpars=unavailable,max_suspend_capable_lpars=unavailable,hca_bandwidth_capabilities=null,service_lpar_id=unavailable,service_lpar_name=unavailable,curr_sys_keylock=manual,pend_sys_keylock=manual,curr_power_on_side=temp,pend_power_on_side=temp,curr_power_on_speed=fast,pend_power_on_speed=fast,curr_power_on_speed_override=none,pend_power_on_speed_override=none,power_on_type=power on,power_on_option=autostart,power_on_lpar_start_policy=autostart,pend_power_on_option=autostart,pend_power_on_lpar_start_policy=autostart,power_on_method=02,power_on_attr=0000,sp_boot_attr=0000,sp_boot_major_type=08,sp_boot_minor_type=01,sp_version=00030030,mfg_default_config=unavailable,curr_mfg_default_ipl_source=a,pend_mfg_default_ipl_source=a,curr_mfg_default_boot_mode=norm,pend_mfg_default_boot_mode=norm'
        system = Sys.new()

        system.parse(string)


        assert_equal('9131-52A-6535CCG', system.name)
        assert_equal('9131-52A', system.type_model)
        assert_equal('6535CCG', system.serial_num)
        assert_equal('192.168.200.39', system.ipaddr)
        assert_equal('Power Off', system.state)
        assert_equal('None', system.detailed_state)
        assert_equal('10/04/2017 16:41:46', system.sys_time)
        assert_equal('unavailable', system.power_off_policy)
        assert_equal('unavailable', system.active_lpar_mobility_capable)
        assert_equal('unavailable', system.inactive_lpar_mobility_capable)
        assert_equal('unavailable', system.active_lpar_share_idle_procs_capable)
        assert_equal('unavailable', system.active_mem_expansion_capable)
        assert_equal('unavailable', system.hardware_active_mem_expansion_capable)
        assert_equal('unavailable', system.active_mem_sharing_capable)
        assert_equal('0', system.addr_broadcast_perf_policy_capable)
        assert_equal('unavailable', system.bsr_capable)
        assert_equal('unavailable', system.cod_mem_capable)
        assert_equal('unavailable', system.cod_proc_capable)
        assert_equal('unavailable', system.dynamic_platform_optimization_capable)
        assert_equal('unavailable', system.electronic_err_reporting_capable)
        assert_equal('0', system.firmware_power_saver_capable)
        assert_equal('0', system.hardware_power_saver_capable)
        assert_equal('unavailable', system.hardware_discovery_capable)
        assert_equal('1', system.hca_capable)
        assert_equal('1', system.huge_page_mem_capable)
        assert_equal('unavailable', system.lhea_capable)
        assert_equal('unavailable', system.lpar_avail_priority_capable)
        assert_equal('unavailable', system.lpar_proc_compat_mode_capable)
        assert_equal('unavailable', system.lpar_remote_restart_capable)
        assert_equal('unavailable', system.powervm_lpar_remote_restart_capable)
        assert_equal('unavailable', system.lpar_suspend_capable)
        assert_equal('unavailable', system.micro_lpar_capable)
        assert_equal('unavailable', system.os400_capable)
        assert_equal('unavailable', system.redundant_err_path_reporting_capable)
        assert_equal('unavailable', system.shared_eth_failover_capable)
        assert_equal('0', system.sni_msg_passing_capable)
        assert_equal('1', system.sp_failover_capable)
        assert_equal('unavailable', system.vet_activation_capable)
        assert_equal('unavailable', system.virtual_fc_capable)
        assert_equal('unavailable', system.virtual_io_server_capable)
        assert_equal('unavailable', system.virtual_switch_capable)
        assert_equal('unavailable', system.vsn_phase2_capable)
        assert_equal('unavailable', system.vsi_on_veth_capable)
        assert_equal('unavailable', system.assign_5250_cpw_percent)
        assert_equal('unavailable', system.max_lpars)
        assert_equal('0', system.max_power_ctrl_lpars)
        assert_equal('unavailable', system.max_remote_restart_capable_lpars)
        assert_equal('unavailable', system.max_suspend_capable_lpars)
        assert_equal('null', system.hca_bandwidth_capabilities)
        assert_equal('unavailable', system.service_lpar_id)
        assert_equal('unavailable', system.service_lpar_name)
        assert_equal('manual', system.curr_sys_keylock)
        assert_equal('manual', system.pend_sys_keylock)
        assert_equal('temp', system.curr_power_on_side)
        assert_equal('temp', system.pend_power_on_side)
        assert_equal('fast', system.curr_power_on_speed)
        assert_equal('fast', system.pend_power_on_speed)
        assert_equal('none', system.curr_power_on_speed_override)
        assert_equal('none', system.pend_power_on_speed_override)
        assert_equal('power on', system.power_on_type)
        assert_equal('autostart', system.power_on_option)
        assert_equal('autostart', system.power_on_lpar_start_policy)
        assert_equal('autostart', system.pend_power_on_option)
        assert_equal('autostart', system.pend_power_on_lpar_start_policy)
        assert_equal('02', system.power_on_method)
        assert_equal('0000', system.power_on_attr)
        assert_equal('0000', system.sp_boot_attr)
        assert_equal('08', system.sp_boot_major_type)
        assert_equal('01', system.sp_boot_minor_type)
        assert_equal('00030030', system.sp_version)
        assert_equal('unavailable', system.mfg_default_config)
        assert_equal('a', system.curr_mfg_default_ipl_source)
        assert_equal('a', system.pend_mfg_default_ipl_source)
        assert_equal('norm', system.curr_mfg_default_boot_mode)
        assert_equal('norm', system.pend_mfg_default_boot_mode)

  end

end