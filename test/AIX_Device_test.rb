$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'test/unit'
require 'AIX/device'
require 'pp'

class AIX_Device_Test < Test::Unit::TestCase


  #Test data are taken from manual (I only changed block_size)
  #https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds3/lsattr.htm
  #point 2
  def test_compare_odm_running

    string_odm='mode          yes   Use DEVICE BUFFERS during writes     True
block_size    1024  BLOCK size (0=variable length)       True
extfm         yes   Use EXTENDED file marks              True
ret           no    RETENSION on tape change or reset    True
density_set_1 37    DENSITY setting #1                   True
density_set_2 36    DENSITY setting #2                   True
compress      yes   Use data COMPRESSION                 True
size_in_mb    12000 Size in Megabytes                    False
ret_error     no    RETURN error on tape change or reset True'

    string_running='mode          yes   Use DEVICE BUFFERS during writes     True
block_size    1025  BLOCK size (0=variable length)       True
extfm         yes   Use EXTENDED file marks              True
ret           no    RETENSION on tape change or reset    True
density_set_1 37    DENSITY setting #1                   True
density_set_2 36    DENSITY setting #2                   True
compress      yes   Use data COMPRESSION                 True
size_in_mb    12000 Size in Megabytes                    False
ret_error     no    RETURN error on tape change or reset True'

    device = Device.new
    device.set_attr(string_odm,     'odm')
    device.set_attr(string_running, 'running')

    device.validate

    assert_equal('block_size: ODM value 1024 is different from running: 1025', device.warnings[0])

  end

  #Test data are taken from manual (I only changed block_size)
  #https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds3/lsattr.htm
  #point 7
  def test_compare_odm_running_O

    string_odm='#mode:block_size:extfm:ret:density_set_1:density_set_2:compress:size_in_mb:ret_error
yes:1024:yes:no:37:36:yes:12000:no'

    string_running='#mode:block_size:extfm:ret:density_set_1:density_set_2:compress:size_in_mb:ret_error
yes:1025:yes:no:37:36:yes:12000:no'

    device = Device.new
    device.set_attr(string_odm,     'odm')
    device.set_attr(string_running, 'running')

    device.validate

    assert_equal('block_size: ODM value 1024 is different from running: 1025', device.warnings[0])

  end

end