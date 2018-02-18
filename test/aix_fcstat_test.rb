$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'AIX/fcstat'

class TestAixFcstat < Test::Unit::TestCase

  def test_Fcstat1

    # example output from fcstat command is taken from IBM website:
    # https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds2/fcstat.htm
    # some data were changed to next numbers to be sure that regexp is working correctly
    string = File.read('data/fcstat.txt')

    fcstat = Fcstat.new(string)
    data = fcstat.get_stats()

    assert_equal('fcs0',     fcstat.device,     'fcstat device name')
    assert_equal('fcs0',     data['device'],     'fcstat device name')

    assert_equal('fcs0',     fcstat.data['device'],     'fcstat device name')

    assert_equal('FC Adapter (df1000f9)', fcstat.data['Device Type'])
    assert_equal('1E313BB001',            fcstat.data['Serial Number'])
    assert_equal('02C82115', fcstat.data['Option ROM Version'])
    assert_equal( 'B1F2.10A5',fcstat.data['ZA'])

    assert_equal( '20000000C9487B04', fcstat.data['Node WWN'])
	  assert_equal( '10000000C9416DA4', fcstat.data['Port WWN'])

    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Supported'], 'fcstat device name')
    assert_equal('0x0000010000000000000000000000000000000000000000000000000000000000', fcstat.data["FC4 Types"]['Active'],    'fcstat device name')

    assert_equal('4', fcstat.data['Class of Service'])

    assert_equal('011400', fcstat.data['Port FC ID'])
    assert_equal('2 GBIT', fcstat.data['Port Speed (supported)'])
    assert_equal('1 GBIT', fcstat.data['Port Speed (running)'])
    assert_equal('Fabric', fcstat.data['Port Type'])
    assert_equal(345422,   fcstat.data['Seconds Since Last Reset'])

    assert_equal(1, fcstat.data['Transmit Statistics']['Frames'])
    assert_equal(3, fcstat.data['Transmit Statistics']['Words'])
    assert_equal(2, fcstat.data['Receive Statistics']['Frames'])
    assert_equal(4, fcstat.data['Receive Statistics']['Words'])

    assert_equal(5  , fcstat.data['LIP Count'])
    assert_equal(6  , fcstat.data['NOS Count'])
    assert_equal(7  , fcstat.data['Error Frames'])
    assert_equal(8  , fcstat.data['Dumped Frames'])
    assert_equal(9  , fcstat.data['Link Failure Count'])
    assert_equal(10 , fcstat.data['Loss of Sync Count'])
    assert_equal(11 , fcstat.data['Loss of Signal'])
    assert_equal(12 , fcstat.data['Primitive Seq Protocol Err Count'])
    assert_equal(13 , fcstat.data['Invalid Tx Word Count'])
    assert_equal(14 , fcstat.data['Invalid CRC Count'])
    assert_equal(15 , fcstat.data['IP over FC Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(16 , fcstat.data['IP over FC Adapter Driver Information']['No Adapter Elements Count'])

    assert_equal(17 , fcstat.data['FC SCSI Adapter Driver Information']['No DMA Resource Count'])
    assert_equal(18 , fcstat.data['FC SCSI Adapter Driver Information']['No Adapter Elements Count'])
    assert_equal(19 , fcstat.data['FC SCSI Adapter Driver Information']['No Command Resource Count'])



    assert_equal(20 , fcstat.data['IP over FC Traffic Statistics']['Input Requests'])
    assert_equal(21 , fcstat.data['IP over FC Traffic Statistics']['Output Requests'])
    assert_equal(22 , fcstat.data['IP over FC Traffic Statistics']['Control Requests'])
    assert_equal(23 , fcstat.data['IP over FC Traffic Statistics']['Input Bytes'])
    assert_equal(24 , fcstat.data['IP over FC Traffic Statistics']['Output Bytes'])

    assert_equal(16289, fcstat.data['FC SCSI Traffic Statistics']['Input Requests'])
    assert_equal(48930, fcstat.data['FC SCSI Traffic Statistics']['Output Requests'])
    assert_equal(11791, fcstat.data['FC SCSI Traffic Statistics']['Control Requests'])
    assert_equal(128349517, fcstat.data['FC SCSI Traffic Statistics']['Input Bytes'])
    assert_equal(209883136, fcstat.data['FC SCSI Traffic Statistics']['Output Bytes'])

  end
end
