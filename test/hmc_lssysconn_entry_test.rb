$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
$LOAD_PATH << File.dirname(__FILE__) + './lib'

require 'test/unit'
require 'HMC/lssysconn_entry'

class HmcLssysconnTest < Test::Unit::TestCase

  def test_type_model_serial_num_to_array
    entry = Lssysconn_entry.new
    array = entry.type_model_serial_num_to_array('9131-52A*6535CCG')

    assert_equal('9131',    array[0])
    assert_equal('52A',     array[1])
    assert_equal('6535CCG', array[2])
  end


  # source data: https://www.ibm.com/support/knowledgecenter/en/POWER5/ipha5_p5/managedsystemstate_no_connect.htm
  def test_1
    string = 'resource_type=sys,type_model_serial_num=9117-570*100729E,sp=unavailable,ipaddr=10.0.0.247,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting 0000-0000-00000000'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('9117-570*100729E', entry.type_model_serial_num)

    assert_equal('9117', entry.type)
    assert_equal('570', entry.model)
    assert_equal('100729E', entry.serial_num)

    assert_equal('unavailable', entry.sp)
    assert_equal('10.0.0.247', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('No Connection', entry.state)
    assert_equal('Connecting 0000-0000-00000000', entry.connection_error_code)

  end

  # source data: https://sourceforge.net/p/xcat/mailman/message/23258914/
  def test_2
    string = 'resource_type=sys,type_model_serial_num=9110-51A*1075E3F,sp=primary,sp_phys_loc=unavailable,ipaddr=192.168.200.53,alt_ipaddr=unavailable,state=Failed Authentication,connection_error_code=Incorrect password 0802-0001-00000026'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('9110-51A*1075E3F', entry.type_model_serial_num)
    assert_equal('primary', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('192.168.200.53', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Failed Authentication', entry.state)
    assert_equal('Incorrect password 0802-0001-00000026', entry.connection_error_code)

  end

  # data source: own power5 frame
  def test_3
    string = 'resource_type=sys,type_model_serial_num=9131-52A*6535CCG,sp=unavailable,sp_phys_loc=unavailable,ipaddr=192.168.200.39,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting  0000-0000-00000000'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('9131-52A*6535CCG', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('192.168.200.39', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('No Connection', entry.state)
    assert_equal('Connecting  0000-0000-00000000', entry.connection_error_code)

  end


  # data source: own power5 frame
  def test_firmware_password_locked
    string = 'resource_type=sys,type_model_serial_num=9131-52A*6535CCG,sp=unavailable,sp_phys_loc=unavailable,ipaddr=192.168.200.39,alt_ipaddr=unavailable,state=Connecting,connection_error_code=Firmware Password locked  0803-0001-00000203'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('9131-52A*6535CCG', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('192.168.200.39', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Connecting', entry.state)
    assert_equal('Firmware Password locked  0803-0001-00000203', entry.connection_error_code)

  end


  # data source: own power5 frame
  def test_4
    string = 'resource_type=sys,type_model_serial_num=9131-52A*6535CCG,sp=primary,sp_phys_loc=unavailable,ipaddr=192.168.200.39,alt_ipaddr=unavailable,state=Connected'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('9131-52A*6535CCG', entry.type_model_serial_num)
    assert_equal('primary', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('192.168.200.39', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Connected', entry.state)
    assert_equal(nil, entry.connection_error_code)

  end

  #data source: http://www-01.ibm.com/support/docview.wss?uid=nas8N1020147
  def test_5
    string = 'resource_type=sys,type_model_serial_num=7998-61X*0617ABA,sp=unavailable,sp_phys_loc=unavailable,ipaddr=9.5.65.18,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting  02FF-0003-008087E9'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('7998-61X*0617ABA', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('9.5.65.18', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('No Connection', entry.state)
    assert_equal('Connecting  02FF-0003-008087E9', entry.connection_error_code)


  end

  #data source: https://www.ibm.com/developerworks/community/forums/html/topic?id=77777777-0000-0000-0000-000014703171
  def test_6
    string = 'resource_type=sys,type_model_serial_num=unavailable,sp=unavailable,sp_phys_loc=unavailable,ipaddr=128.200.91.5,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting 0000-0000-00000000'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('unavailable', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('128.200.91.5', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('No Connection', entry.state)
    assert_equal('Connecting 0000-0000-00000000', entry.connection_error_code)

  end

  #  data source: http://www-01.ibm.com/support/docview.wss?uid=nas8N1014500
  def test_state_connecting

    string = 'resource_type=sys,type_model_serial_num=unavailable,sp=unavailable,sp_phys_loc=unavailable,ipaddr=172.16.255.254,alt_ipaddr=unavailable,state=Connecting,connection_error_code=Connecting 0000-0000-00000000'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('unavailable', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('172.16.255.254', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Connecting', entry.state)
    assert_equal('Connecting 0000-0000-00000000', entry.connection_error_code)


  end

  #data source: http://www-01.ibm.com/support/docview.wss?uid=nas8N1015271
  def test_frame_pending_authentification
    string = 'resource_type=frame,type_model_serial_num=9458-100*9922006W,side=b,ipaddr=192.168.254.254,state=pending authentication - password updates required'

    entry = Lssysconn_entry.new(string)
    assert_equal('frame', entry.resource_type)
    assert_equal('9458-100*9922006W', entry.type_model_serial_num)
    assert_equal('b', entry.side)
    assert_equal('192.168.254.254', entry.ipaddr)
    assert_equal('pending authentication - password updates required', entry.state)
  end

  def test_version_mismatch
   string = 'resource_type=sys,type_model_serial_num=9406-520*103E8FE,sp=primary,sp_phys_loc=unavailable,ipaddr=9.5.66.29,alt_ipaddr=unavailable,state=Version Mismatch,connection_error_code=Connection not allowed 0009-0008-00000000'

   entry = Lssysconn_entry.new(string)

  end

  #data source: http://www-01.ibm.com/support/docview.wss?uid=nas7ed6373fb95fe571686257ad400737e94
  def test_sys_allready_connected
    string = 'resource_type=sys,type_model_serial_num=7895-42X*105C91B,sp=unavailable,sp_phys_loc=unavailable,ipaddr=10.254.100.9,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Already connected 0402-0001-00000025'

    entry = Lssysconn_entry.new(string)
    assert_equal('sys', entry.resource_type)
    assert_equal('7895-42X*105C91B', entry.type_model_serial_num)
    assert_equal('unavailable', entry.sp)
    assert_equal('unavailable', entry.sp_phys_loc)
    assert_equal('10.254.100.9', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('No Connection', entry.state)
    assert_equal('Already connected 0402-0001-00000025', entry.connection_error_code)
  end

  # source of test: http://www-01.ibm.com/support/docview.wss?uid=nas8N1010700
  def test_frame_alt_ipaddr
    string = 'resource_type=frame,type_model_serial_num=9A01-100*0P1P315,side=b,ipaddr=192.168.255.253,alt_ipaddr=unavailable,state=Connected'

    entry = Lssysconn_entry.new(string)
    assert_equal('frame', entry.resource_type)
    assert_equal('9A01-100*0P1P315', entry.type_model_serial_num)
    assert_equal('b', entry.side)
    assert_equal('192.168.255.253', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Connected', entry.state)
  end

  # IBM System p5 Approaches to 24x7 Availability Including AIX 5L - site 379
  def test_frame_alt_ipaddr_2
    string = 'resource_type=frame,type_model_serial_num=9119-590*02C489E,side=unavailable,ipaddr=192.168.254.255,alt_ipaddr=unavailable,state=Version Mismatch,connection_error_code=Version mismatch 0404-0007-00000001'

    entry = Lssysconn_entry.new(string)
    assert_equal('frame', entry.resource_type)
    assert_equal('9119-590*02C489E', entry.type_model_serial_num)
    assert_equal('unavailable', entry.side)
    assert_equal('192.168.254.255', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Version Mismatch', entry.state)
    assert_equal('Version mismatch 0404-0007-00000001', entry.connection_error_code)
  end

  # https://www.ibm.com/developerworks/community/forums/atom/download/hmc%20lssysconn%20output.docx?nodeId=170cf43e-2872-41d9-a90a-254f8339afd0
  #
  def test_sp_phys_loc
    string = 'resource_type=sys,type_model_serial_num=8286-42A*218CA0V,sp=primary,sp_phys_loc=U78C9.001.WZS05NY-P1,ipaddr=10.128.0.23,alt_ipaddr=unavailable,state=Connected'
    entry = Lssysconn_entry.new(string)

    assert_equal('sys', entry.resource_type)
    assert_equal('8286-42A*218CA0V', entry.type_model_serial_num)
    assert_equal('primary', entry.sp)
    assert_equal('U78C9.001.WZS05NY-P1', entry.sp_phys_loc)
    assert_equal('10.128.0.23', entry.ipaddr)
    assert_equal('unavailable', entry.alt_ipaddr)
    assert_equal('Connected', entry.state)
  end

end