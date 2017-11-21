$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'HMC/lssvcevents'
require 'pp'


class HmcLssvceventsTest < Test::Unit::TestCase

  # test data taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  def test_fail
string = %^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="
problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^


    events = Lssvcevents.new(string)

    assert_equal(2,events.count )
  end
end