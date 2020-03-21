$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

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

  def test_cvs
    header_line='HMC;          event time;ID;  PHM;refcode; system serial; sys name; failing mtms; machine type; model; priority; ticket number; event status; Resolution Status; text; action plan;';
    line = 'hmc1;07/12/2016 13:21:14;45;;B3020001;TU20305;ivm1sdmc;8286-41A/TU20305;8286;41A;priority-low;ABC1234;Open;open;Communications to the SFP component on partition P8TiOS are unavailable.;action plan2;'

    entry = Lssvcenevents_entry.new
    entry.parse_from_csv(header_line, line)

    assert_equal(['hmc1'], entry.hmcs_name)
    assert_equal('07/12/2016 13:21:14',entry.last_time )
    assert_equal('45',entry.problem_num )
    assert_equal(nil,entry.pmh_num )
    assert_equal('B3020001',entry.refcode )
    assert_equal('TU20305',entry.serial )
    assert_equal('ivm1sdmc',entry.sys_name )
    assert_equal('8286-41A/TU20305',entry.failing_mtms )
    assert_equal('8286',entry.machine_type )
    assert_equal('41A',entry.machine_model )
    assert_equal('priority-low', entry.priority)
    assert_equal('ABC1234', entry.ticket_number)
    assert_equal('Open', entry.status)
    assert_equal('open', entry.resolution_status)
    assert_equal('Communications to the SFP component on partition P8TiOS are unavailable.', entry.text)
    assert_equal('action plan2', entry.action_plan)
  end

  def test_cvs_2
    header_line='HMC;          event time;ID;  PHM;refcode; system serial; sys name; failing mtms; machine type; model; priority; ticket number; event status; Resolution Status; text; action plan;';
    line = 'hmc1;07/12/2016 13:21:14;45;80503,090,20;B3020001;TU20305;ivm1sdmc;8286-41A/TU20305;8286;41A;priority-low;ABC1234;Open;open;Communications to the SFP component on partition P8TiOS are unavailable.;action plan2;'

    entry = Lssvcenevents_entry.new
    entry.parse_from_csv(header_line, line)

    assert_equal(['hmc1'], entry.hmcs_name)
    assert_equal('07/12/2016 13:21:14',entry.last_time )
    assert_equal('45',entry.problem_num )
    assert_equal('80503,090,20',entry.pmh_num)
    assert_equal('80503 090 20',entry.pmh_num_nice)
    assert_equal('B3020001',entry.refcode )
    assert_equal('TU20305',entry.serial )
    assert_equal('ivm1sdmc',entry.sys_name )
    assert_equal('8286-41A/TU20305',entry.failing_mtms )
    assert_equal('8286',entry.machine_type )
    assert_equal('41A',entry.machine_model )
    assert_equal('priority-low', entry.priority)
    assert_equal('ABC1234', entry.ticket_number)
    assert_equal('Open', entry.status)
    assert_equal('open', entry.resolution_status)
    assert_equal('Communications to the SFP component on partition P8TiOS are unavailable.', entry.text)
    assert_equal('action plan2', entry.action_plan)
  end


  # test data are taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  def test_compare_true
    string=%^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    entry1 = Lssvcenevents_entry.new(string, 'hmc1')
    entry2 = Lssvcenevents_entry.new(string, 'hmc2')

    assert_equal(true, entry1.compare(entry2))
  end

  # test data are taken from: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014321
  def test_compare_false
    string1=%^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^
    string2=%^problem_num=46,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    entry1 = Lssvcenevents_entry.new(string1, 'hmc1')
    entry2 = Lssvcenevents_entry.new(string2, 'hmc2')

    assert_equal(false, entry1.compare(entry2))
  end

  def test_compare_csv_false
    string_raw=%^problem_num=46,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    string_csv_header ='HMC;          event time;ID;  PHM;refcode; system serial; sys name; failing mtms; machine type; model; priority; ticket number; event status; Resolution Status; text; action plan;'
    string_csv_value = 'hmc1;07/12/2016 13:21:14;45;;B3020001;TU20305;ivm1sdmc;8286-41A/TU20305;8286;41A;priority-low;ABC1234;Open;open;Communications to the SFP component on partition P8TiOS are unavailable.;action plan2;'

    entry1 = Lssvcenevents_entry.new(string_raw, 'hmc1')

    entry2 = Lssvcenevents_entry.new
    entry2.parse_from_csv(string_csv_header, string_csv_value)

    assert_equal(false, entry1.compare(entry2))
  end

  def test_compare_csv_true
    string_raw=%^problem_num=45,pmh_num=,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    string_csv_header ='HMC;          event time;ID;  PHM;refcode; system serial; sys name; failing mtms; machine type; model; priority; ticket number; event status; Resolution Status; text; action plan;'
    string_csv_value = 'hmc1;07/12/2016 13:21:14;45;;B3020001;TU20305;ivm1sdmc;8286-41A/TU20305;8286;41A;priority-low;ABC1234;Open;open;Communications to the SFP component on partition P8TiOS are unavailable.;action plan2;'

    entry1 = Lssvcenevents_entry.new(string_raw, 'hmc1')

    entry2 = Lssvcenevents_entry.new
    entry2.parse_from_csv(string_csv_header, string_csv_value)

    assert_equal(true, entry1.compare(entry2, %w[hmcs_name problem_num last_time refcode sys_name failing_mtms machine_type machine_model status text phm_num]))
  end

  def test_compare_csv_true_2
    string_raw=%^problem_num=45,pmh_num=50890,refcode=B3020001,status=Open,first_time=07/12/2016 13:21:14,last_time=07/12/2016 13:21:14,sys_name=ivm1sdmc,sys_mtms=VM-V8d7-f9d/fa6e3fc,enclosure_mtms=8286-41A/TU20305,firmware_fix=,text=Communications to the SFP component on partition P8TiOS are unavailable.,created_time=07/12/2016 13:21:14,reporting_name=ivm1sdmc,reporting_mtms=VM-V8d7-f9d/fa6e3fc,failing_mtms=8286-41A/TU20305,analyzing_hmc=ivm1sdmc,event_time=07/12/2016 13:21:14,"files=iqyymrge.log/Consolidated system platform log,iqyvpd.dat/Configuration information associated with the HMC,actzuict.dat/Tasks performed,iqyvpdc.dat/Configuration information associated with the HMC,problems.xml/XML version of the problems opened on the HMC for the HMC and the server,refcode.dat/list of reference codes associated with the hmc,iqyylog.log/HMC firmware log information,hmc.eed/HMC code level obtained from 'lshmc -V' and connection information obtained from 'lssysconn -r all',gardRecord.xml/No description is available",approval_state=approved,callhome_intended=false,duplicate_count=0,event_severity=0,analyzing_mtms=VM-V8d7-f9d/fa6e3fc,ref_code_extn=00000000,sys_refcode=B302000100000070,"fru_details=fru_part_num=FSPSP33:fru_serial_num=:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_ISOLATE_PROCEDURE:fru_replacement_group=M:fru_ccin=:fru_logic_ctrl_mtms=,fru_part_num=PTNNTWK:fru_serial_num=:VM-V8d7-f9d/fa6e3fc-SPOT-LAN-CONNECTION:fru_location_code=:fru_replaced_date=0:fru_class=CLASS_SYMBOLIC_PROCEDURE:fru_replacement_group=:fru_ccin=:fru_logic_ctrl_mtms="^

    string_csv_header ='HMC;          event time;ID;  PHM;refcode; system serial; sys name; failing mtms; machine type; model; priority; ticket number; event status; Resolution Status; text; action plan;'
    string_csv_value = 'hmc1;07/12/2016 13:21:14;45;50890;B3020001;TU20305;ivm1sdmc;8286-41A/TU20305;8286;41A;priority-low;ABC1234;Open;open;Communications to the SFP component on partition P8TiOS are unavailable.;action plan2;'

    entry1 = Lssvcenevents_entry.new(string_raw, 'hmc1')

    entry2 = Lssvcenevents_entry.new
    entry2.parse_from_csv(string_csv_header, string_csv_value)

    assert_equal(true, entry1.compare(entry2, %w[hmcs_name problem_num last_time refcode sys_name failing_mtms machine_type machine_model status text phm_num]))
  end

end