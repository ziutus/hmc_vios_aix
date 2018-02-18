$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'HMC/lssvcenevents_entry'
require 'pp'

class Test_HmcLssvcevents_entry < Test::Unit::TestCase

  # test data are taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  def test_fail

    string=%^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    entry = Lssvcenevents_entry.new(string)

    assert_equal('45',entry.problem_num )
    assert_equal('',entry.pmh_num )
    assert_equal('B3020001',entry.refcode )
    assert_equal('Open',entry.status )
    assert_equal('07/12/2016 13:21:14',entry.first_time )
    assert_equal('07/12/2016 13:21:14',entry.last_time )
    assert_equal('ivm1sdmc',entry.sys_name )
    assert_equal('VM-V8d7-f9d/fa6e3fc',entry.sys_mtms )
    assert_equal('8286-41A/TU20305',entry.enclosure_mtms )
    assert_equal('',entry.firmware_fix )
    assert_equal('Communications to the SFP component on partition P8TiOS are unavailable.',entry.text )
    assert_equal('07/12/2016 13:21:14',entry.created_time )
    assert_equal('ivm1sdmc',entry.reporting_name )
    assert_equal('VM-V8d7-f9d/fa6e3fc',entry.reporting_mtms )
    assert_equal('8286-41A/TU20305',entry.failing_mtms )
    assert_equal('ivm1sdmc',entry.analyzing_hmc )
    assert_equal('07/12/2016 13:21:14',entry.event_time )
    assert_equal('approved',entry.approval_state )
    assert_equal('false',entry.callhome_intended)
    assert_equal('0',entry.duplicate_count )
    assert_equal('0',entry.event_severity )
    assert_equal('VM-V8d7-f9d/fa6e3fc',entry.analyzing_mtms )
    assert_equal('00000000',entry.ref_code_extn )
    assert_equal('B302000100000070',entry.sys_refcode )
  end


end