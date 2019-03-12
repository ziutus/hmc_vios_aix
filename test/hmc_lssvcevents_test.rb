$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'test/unit'
require 'HMC/lssvcevents'

class HmcLssvceventsTest < Test::Unit::TestCase

  # test data taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  def test_fail
    string = %^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="
problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    events = Lssvcevents.new(string)

    assert_equal(2,events.count )
  end

  # test data taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  # and doubled with change name of HMC to second to test duplicated errors
  # simulation of many data strings like in real script
  def test_lssvecents_2

    events = Lssvcevents.new

    string_hmc1 = %^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="
problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms=^
    events.parse(string_hmc1, 'ivm1sdmc')

    string_hmc2 = %^problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm2sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms=^
    events.parse(string_hmc2, 'ivm2sdmc')

    assert_equal(2,events.count )

  end

  # test data taken from test_lssvcevents_2
  def test_compare_events

    string_hmc1 = %^problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms=^
    event1 = Lssvcenevents_entry.new(string_hmc1)

    string_hmc2 = %^problem_num=44,pmh_num=,refcode=B3010002,status=Open,first_time=07/12/2016 12:13:21,last_time=07/12/2016 12:13:21,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 12:13:21,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm2sdmc,event_time=07/12/2016 12:13:21,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B3010002,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms=^
    event2 = Lssvcenevents_entry.new(string_hmc2)

    assert_equal(true, event1.compare(event2))

  end


  # test data taken from https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014018335
  # Case is common for all HMC classes, this is why is in this test file
  def test_lssvecents_unknown_error

    events = Lssvcevents.new

    string_hmc1 = "An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative"
    events.parse(string_hmc1, 'hmc002')

    assert_equal(0,events.count )
    assert_equal(1,events.errors.count )
  end


end