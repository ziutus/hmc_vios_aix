$LOAD_PATH << File.dirname(__FILE__)+'/../lib'

require 'test/unit'
require 'pp'
require 'AIX/fcstat'

class TestAixFcstat < Test::Unit::TestCase

  # test data are taken from http://www.wmduszyk.com/?p=6800&langswitch_lang=en
  def test_fcstat_error_reading_statistics_information
    string = 'FIBRE CHANNEL STATISTICS REPORT: fcs0

Device Type: FC Adapter (77102224)

Option ROM Version: 49535020

World Wide Node Name: 0x0
World Wide Port Name: 0x2100001b3283477f

FC-4 TYPES:
Supported: 0x0000010000000000000000000000000000000000000000000000000000000000
Active: 0x0000010000000000000000000000000000000000000000000000000000000000
Class of Service: 3
Port Speed (supported): 1 GBIT
Port Speed (running): 4 GBIT
Port FC ID: 0x010500
Port Type: Fabric
Error reading statistics information'

    exception = assert_raise(RuntimeError) { fcstat = Fcstat.new(string) }
    assert_equal("Error reading statistics information",  exception.message)
  end


  # Test data source: IBM AIX Version 7.1 Differences Guide site 73
  def test_fcstat_ODM_issue
    string = 'Error accessing ODM
Device not found'

    exception = assert_raise(RuntimeError) { fcstat = Fcstat.new(string) }
    assert_equal("Error accessing ODM - Device not found",  exception.message)
  end

  # Test data source: IBM AIX Version 7.1 Differences Guide site 73
  def test_fcstat_ODM_issue2
    string = 'Error accessing ODM
VPD information not found'

    exception = assert_raise(RuntimeError) { fcstat = Fcstat.new(string) }
    assert_equal("Error accessing ODM - VPD information not found",  exception.message)
  end

  # Test data source: IBM AIX Version 7.1 Differences Guide site 73
  def test_fcstat_46
    string = 'Error opening device: /dev/fscsi0

errno: 00000046'

    exception = assert_raise(RuntimeError) { fcstat = Fcstat.new(string) }
    assert_equal("Error - network is unreachable",  exception.message)
  end


  def test_Fcstat1

    # example output from fcstat command is taken from IBM website:
    # https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds2/fcstat.htm
    # some data were changed to next numbers to be sure that regexp is working correctly
    string = File.read('test/data/fcstat.txt')

    fcstat = Fcstat.new(string)
    data = fcstat.get_stats()

    assert_equal('fcs0',     fcstat.device,      'fcstat device name')
    assert_equal('fcs0',     data['device'],     'fcstat device name')

    assert_equal('fcs0',     fcstat.data['device'], 'fcstat device name')

    assert_equal('FC Adapter (df1000f9)', fcstat.data['Device Type'])
    assert_equal('1E313BB001',            fcstat.data['Serial Number'])
    assert_equal('02C82115', fcstat.data['Option ROM Version'])
    assert_equal( 'B1F2.10A5', fcstat.data['ZA'])

    assert_equal('20000000C9487B04', fcstat.data['Node WWN'])
	  assert_equal('10000000C9416DA4', fcstat.data['Port WWN'])

    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Supported'], 'fcstat device name')
    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Active'],    'fcstat device name')

    assert_equal('4', fcstat.data['Class of Service'])

    assert_equal('011400', fcstat.data['Port FC ID'])
    assert_equal('2 GBIT', fcstat.data['Port Speed (supported)'])
    assert_equal('1 GBIT', fcstat.data['Port Speed (running)'])
    assert_equal('Fabric', fcstat.data['Port Type'])
    assert_equal(345_422,  fcstat.data['Seconds Since Last Reset'])

    assert_equal(1, fcstat.data['Transmit Statistics']['Frames'])
    assert_equal(3, fcstat.data['Transmit Statistics']['Words'])
    assert_equal(2, fcstat.data['Receive Statistics']['Frames'])
    assert_equal(4, fcstat.data['Receive Statistics']['Words'])

    assert_equal(5,  fcstat.data['LIP Count'])
    assert_equal(6,  fcstat.data['NOS Count'])
    assert_equal(7,  fcstat.data['Error Frames'])
    assert_equal(8,  fcstat.data['Dumped Frames'])
    assert_equal(9,  fcstat.data['Link Failure Count'])
    assert_equal(10, fcstat.data['Loss of Sync Count'])
    assert_equal(11, fcstat.data['Loss of Signal'])
    assert_equal(12, fcstat.data['Primitive Seq Protocol Err Count'])
    assert_equal(13, fcstat.data['Invalid Tx Word Count'])
    assert_equal(14, fcstat.data['Invalid CRC Count'])
    assert_equal(15, fcstat.data['IP over FC Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(16, fcstat.data['IP over FC Adapter Driver Information']['No Adapter Elements Count'])

    assert_equal(17, fcstat.data['FC SCSI Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(18, fcstat.data['FC SCSI Adapter Driver Information']['No Adapter Elements Count'])
    assert_equal(19, fcstat.data['FC SCSI Adapter Driver Information']['No Command Resource Count'])



    assert_equal(20, fcstat.data['IP over FC Traffic Statistics']['Input Requests'])
    assert_equal(21, fcstat.data['IP over FC Traffic Statistics']['Output Requests'])
    assert_equal(22, fcstat.data['IP over FC Traffic Statistics']['Control Requests'])
    assert_equal(23, fcstat.data['IP over FC Traffic Statistics']['Input Bytes'])
    assert_equal(24, fcstat.data['IP over FC Traffic Statistics']['Output Bytes'])

    assert_equal(16289, fcstat.data['FC SCSI Traffic Statistics']['Input Requests'])
    assert_equal(48930, fcstat.data['FC SCSI Traffic Statistics']['Output Requests'])
    assert_equal(11791, fcstat.data['FC SCSI Traffic Statistics']['Control Requests'])
    assert_equal(128349517, fcstat.data['FC SCSI Traffic Statistics']['Input Bytes'])
    assert_equal(209883136, fcstat.data['FC SCSI Traffic Statistics']['Output Bytes'])

  end

  # test data source: http://blog.krystalia.net/post/2007/08/28/aix-nouvel-utilitaire-fcstat.html
  def test_fcstat_long_2

    string = File.read('test/data/fcstat_2.txt')
  fcstat = Fcstat.new(string)
  data = fcstat.get_stats()

  assert_equal('fcs0', fcstat.device, 'fcstat device name')
  assert_equal('fcs0', data['device'], 'fcstat device name')

  assert_equal('fcs0',     fcstat.data['device'], 'fcstat device name')

  assert_equal('FC Adapter (df1000fd)', fcstat.data['Device Type'])
  assert_equal('1B9999999',            fcstat.data['Serial Number'])
  assert_equal('02C82138', fcstat.data['Option ROM Version'])
  assert_equal('B1F2.10X8', fcstat.data['Firmware version'])

  assert_equal('0x20000000C964777E', fcstat.data['Node WWN'])
  assert_equal('0x10000000C964777E', fcstat.data['Port WWN'])

  assert_equal('0x0000012000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Supported'], 'fcstat device name')
  assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Active'],    'fcstat device name')

  assert_equal('3', fcstat.data['Class of Service'])

  assert_equal('0x610213', fcstat.data['Port FC ID'])
  assert_equal('4 GBIT', fcstat.data['Port Speed (supported)'])
  assert_equal('4 GBIT', fcstat.data['Port Speed (running)'])
  assert_equal('Fabric', fcstat.data['Port Type'])
  assert_equal(1_049_191,  fcstat.data['Seconds Since Last Reset'])

  assert_equal(2877134108, fcstat.data['Transmit Statistics']['Frames'])
  assert_equal(1099511627520, fcstat.data['Transmit Statistics']['Words'])
  assert_equal(1261755420, fcstat.data['Receive Statistics']['Frames'])
  assert_equal(586414879232, fcstat.data['Receive Statistics']['Words'])

  assert_equal(0,  fcstat.data['LIP Count'])
  assert_equal(0,  fcstat.data['NOS Count'])
  assert_equal(0,  fcstat.data['Error Frames'])
  assert_equal(0,  fcstat.data['Dumped Frames'])
  assert_equal(0,  fcstat.data['Link Failure Count'])
  assert_equal(6, fcstat.data['Loss of Sync Count'])
  assert_equal(0, fcstat.data['Loss of Signal'])
  assert_equal(0, fcstat.data['Primitive Seq Protocol Err Count'])
  assert_equal(0, fcstat.data['Invalid Tx Word Count'])
  assert_equal(0, fcstat.data['Invalid CRC Count'])

  assert_equal(0, fcstat.data['IP over FC Adapter Driver Information']['No DMA Resource Count'])
  assert_equal(0, fcstat.data['IP over FC Adapter Driver Information']['No Adapter Elements Count'])

  assert_equal(0, fcstat.data['FC SCSI Adapter Driver Information']['No DMA Resource Count'])
  assert_equal(316556, fcstat.data['FC SCSI Adapter Driver Information']['No Adapter Elements Count'])
  assert_equal(2045709, fcstat.data['FC SCSI Adapter Driver Information']['No Command Resource Count'])

  assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Input Requests'])
  assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Output Requests'])
  assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Control Requests'])
  assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Input Bytes'])
  assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Output Bytes'])

  assert_equal(35188289, fcstat.data['FC SCSI Traffic Statistics']['Input Requests'])
  assert_equal(47812736, fcstat.data['FC SCSI Traffic Statistics']['Output Requests'])
  assert_equal(890940, fcstat.data['FC SCSI Traffic Statistics']['Control Requests'])
  assert_equal(2312815985241, fcstat.data['FC SCSI Traffic Statistics']['Input Bytes'])
  assert_equal(5720318319104, fcstat.data['FC SCSI Traffic Statistics']['Output Bytes'])


  end

  # test data source: http://docs.neverdark.ru/2016/11/15/aix-%D1%83%D0%B7%D0%BD%D0%B0%D1%82%D1%8C-wwn-%D1%8B-%D0%BF%D0%BE%D1%80%D1%82%D0%BE%D0%B2/
  def test_fcstat_long_3

    string = File.read('test/data/fcstat_3.txt')
    fcstat = Fcstat.new(string)
    data = fcstat.get_stats()

    assert_equal('fcs0', fcstat.device, 'fcstat device name')
    assert_equal('fcs0', data['device'], 'fcstat device name')

    assert_equal('fcs0',     fcstat.data['device'], 'fcstat device name')

    assert_equal('Virtual Fibre Channel Client Adapter (adapter/vdevice/IBM,vfc-client)', fcstat.data['Device Type'])
    assert_equal('UNKNOWN', fcstat.data['Serial Number'])
    assert_equal('UNKNOWN', fcstat.data['Option ROM Version'])
    assert_equal('UNKNOWN', fcstat.data['ZA'])

    assert_equal('0xC0507606F5020004', fcstat.data['Node WWN'])
    assert_equal('0xC0507606F5020004', fcstat.data['Port WWN'])

    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data['FC4 Types']['Supported'], 'fcstat device name')
    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data['FC4 Types']['Active'],    'fcstat device name')

    assert_equal('3', fcstat.data['Class of Service'])

    assert_equal('0x0f1654', fcstat.data['Port FC ID'])
    assert_equal('UNKNOWN', fcstat.data['Port Speed (supported)'])
    assert_equal('8 GBIT', fcstat.data['Port Speed (running)'])
    assert_equal('Fabric', fcstat.data['Port Type'])
    assert_equal('UNKNOWN', fcstat.data['Attention Type'])
    assert_equal('UNKNOWN', fcstat.data['Topology'])
    assert_equal(217,  fcstat.data['Seconds Since Last Reset'])

    assert_equal(-1, fcstat.data['Transmit Statistics']['Frames'])
    assert_equal(-1, fcstat.data['Transmit Statistics']['Words'])
    assert_equal(-1, fcstat.data['Receive Statistics']['Frames'])
    assert_equal(-1, fcstat.data['Receive Statistics']['Words'])

    assert_equal(-1,  fcstat.data['LIP Count'])
    assert_equal(-1,  fcstat.data['NOS Count'])
    assert_equal(-1,  fcstat.data['Error Frames'])
    assert_equal(-1,  fcstat.data['Dumped Frames'])
    assert_equal(-1,  fcstat.data['Link Failure Count'])
    assert_equal(-1, fcstat.data['Loss of Sync Count'])
    assert_equal(-1, fcstat.data['Loss of Signal'])
    assert_equal(-1, fcstat.data['Primitive Seq Protocol Err Count'])
    assert_equal(-1, fcstat.data['Invalid Tx Word Count'])
    assert_equal(-1, fcstat.data['Invalid CRC Count'])

    assert_equal(0, fcstat.data['IP over FC Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(0, fcstat.data['IP over FC Adapter Driver Information']['No Adapter Elements Count'])

    assert_equal(0, fcstat.data['FC SCSI Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(0, fcstat.data['FC SCSI Adapter Driver Information']['No Adapter Elements Count'])
    assert_equal(0, fcstat.data['FC SCSI Adapter Driver Information']['No Command Resource Count'])

    assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Input Requests'])
    assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Output Requests'])
    assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Control Requests'])
    assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Input Bytes'])
    assert_equal(0, fcstat.data['IP over FC Traffic Statistics']['Output Bytes'])

    assert_equal(26_673, fcstat.data['FC SCSI Traffic Statistics']['Input Requests'])
    assert_equal(6_821, fcstat.data['FC SCSI Traffic Statistics']['Output Requests'])
    assert_equal(94, fcstat.data['FC SCSI Traffic Statistics']['Control Requests'])
    assert_equal(442_182_355, fcstat.data['FC SCSI Traffic Statistics']['Input Bytes'])
    assert_equal(91_161_424, fcstat.data['FC SCSI Traffic Statistics']['Output Bytes'])
  end

  # source of test data: https://www.lazysystemadmin.com/2010/08/find-wwn-address-in-aix.html
  # comment from: Ben @ Geekswing April 26, 2013 at 10:59 PM
  def test_fcstat_private_loop

    string = File.read('test/data/fcstat_4.txt')
    fcstat = Fcstat.new(string)
    data = fcstat.get_stats()

    assert_equal('fcs0', fcstat.device, 'fcstat device name')
    assert_equal('Private Loop', fcstat.data['Port Type'])

  end

  def test_fc_scsi_traffic_statistics
    string = 'FC SCSI Traffic Statistics
 Input Requests: 35188289
 Output Requests: 47812736
 Control Requests: 890940
 Input Bytes: 2312815985241
 Output Bytes: 5720318319104'
    fcstat = Fcstat.new
    data = fcstat.parse_fc_scsi_traffic_statistics(string)

    assert_equal(35188289, data['Input Requests'])
    assert_equal(47812736, data['Output Requests'])
    assert_equal(890940, data['Control Requests'])
    assert_equal(2312815985241, data['Input Bytes'])
    assert_equal(5720318319104, data['Output Bytes'])

  end

  def test_parse_ip_over_fc_traffic_statistics
    string = 'IP over FC Traffic Statistics
 Input Requests: 1
 Output Requests: 2
 Control Requests: 3
 Input Bytes: 4
 Output Bytes: 5'

    fcstat = Fcstat.new
    data = fcstat.parse_ip_over_fc_traffic_statistics(string)

    assert_equal(1, data['Input Requests'])
    assert_equal(2, data['Output Requests'])
    assert_equal(3, data['Control Requests'])
    assert_equal(4, data['Input Bytes'])
    assert_equal(5, data['Output Bytes'])
  end

  def test_fc_scsi_adapter_driver_information
    string = 'FC SCSI Adapter Driver Information
 No DMA Resource Count: 0
 No Adapter Elements Count: 316556
 No Command Resource Count: 2045709
'
    fcstat = Fcstat.new
    data = fcstat.parse_fc_scsi_adapter_driver_information(string)
    assert_equal(0,         data['No DMA Resource Count'])
    assert_equal(316_556,   data['No Adapter Elements Count'])
    assert_equal(2_045_709, data['No Command Resource Count'])

  end

  def test_parse_ip_over_fc_adapter_2
    string = 'IP over FC Adapter Driver Information
  No DMA Resource Count: 15
  No Adapter Elements Count: 16'
    fcstat = Fcstat.new
    data = fcstat.parse_ip_over_fc_adapter_driver_information(string)

    assert_equal(15, data['No DMA Resource Count'])
    assert_equal(16, data['No Adapter Elements Count'])

  end

end