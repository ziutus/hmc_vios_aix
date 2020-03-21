$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'AIX/lsps'

class AixLspsTest < Test::Unit::TestCase

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

  # test data source: https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/com.ibm.aix.cmds3/lsps.htm
#  def test_lsps_1
#
#    string = 'Page Space   PhysicalVolume  Volume Group    Size   %Used  Active  Auto  Type  Chksum
# hd6           hdisk0          rootvg         512MB    1     yes     yes   lv     8'
#
 #   #fail('Not implemented')
#  end

  # test data source: http://www.unixmantra.com/2013/12/practical-guide-to-aix-paging-space-management.html
  def test_lsps
    string='Page Space  Physical Volume   Volume Group    Size   %Used  Active  Auto  Type
paging00    hdisk1            rootvg          80MB       1     no   yes    lv
hd6         hdisk1            rootvg         256MB       1     yes   yes    lv'

    lsps = Lsps.new(string)

    assert_equal(2, lsps.data.count)

    assert_equal('paging00', lsps.data['paging00'].psname)
    assert_equal('hdisk1', lsps.data['paging00'].pvname)
    assert_equal('rootvg', lsps.data['paging00'].vgname)
    assert_equal('80MB', lsps.data['paging00'].size)
    assert_equal(1, lsps.data['paging00'].used)
    assert_equal('no', lsps.data['paging00'].active)
    assert_equal('yes', lsps.data['paging00'].auto)
    assert_equal('lv', lsps.data['paging00'].type)

    assert_equal('hd6', lsps.data['hd6'].psname)
    assert_equal('hdisk1', lsps.data['hd6'].pvname)
    assert_equal('rootvg', lsps.data['hd6'].vgname)
    assert_equal('256MB', lsps.data['hd6'].size)
    assert_equal(1, lsps.data['hd6'].used)
    assert_equal('yes', lsps.data['hd6'].active)
    assert_equal('yes', lsps.data['hd6'].auto)
    assert_equal('lv', lsps.data['hd6'].type)
  end

end