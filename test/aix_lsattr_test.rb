$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'AIX/Lsattr'
require 'test/unit'
require 'pp'

include Lsattr

class AixLsattrTest < Test::Unit::TestCase

  #https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds3/lsattr.htm
  #point 7
  def test_aix_lsattr_1

    string='#mode:block_size:extfm:ret:density_set_1:density_set_2:compress:size_in_mb:ret_error
yes:1024:yes:no:37:36:yes:12000:no'

    array = lsattr_O(string)

    assert_equal('yes',   array['mode']['value'])
    assert_equal('1024',  array['block_size']['value'])
    assert_equal('yes',   array['extfm']['value'])
    assert_equal('no',    array['ret']['value'])
    assert_equal('37',    array['density_set_1']['value'])
    assert_equal('36',    array['density_set_2']['value'])
    assert_equal('yes',   array['compress']['value'])
    assert_equal('12000', array['size_in_mb']['value'])
    assert_equal('no',    array['ret_error']['value'])

  end

  #https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.cmds3/lsattr.htm
  #point 1
  def test_aix_lsattr_long
    string='mode          yes   Use DEVICE BUFFERS during writes     True
block_size    1024  BLOCK size (0=variable length)       True
extfm         yes   Use EXTENDED file marks              True
ret           no    RETENSION on tape change or reset    True
density_set_1 37    DENSITY setting #1                   True
density_set_2 36    DENSITY setting #2                   True
compress      yes   Use data COMPRESSION                 True
size_in_mb    12000 Size in Megabytes                    False
ret_error     no    RETURN error on tape change or reset True'

    array = lsattr(string)



    assert_equal('yes',   array['mode']['value'])
    assert_equal('1024',  array['block_size']['value'])
    assert_equal('yes',   array['extfm']['value'])
    assert_equal('no',    array['ret']['value'])
    assert_equal('37',    array['density_set_1']['value'])
    assert_equal('36',    array['density_set_2']['value'])
    assert_equal('yes',   array['compress']['value'])
    assert_equal('12000', array['size_in_mb']['value'])
    assert_equal('no',    array['ret_error']['value'])

    assert_equal('True',  array['mode']['user_settable'])
    assert_equal('True',  array['block_size']['user_settable'])
    assert_equal('True',  array['extfm']['user_settable'])
    assert_equal('True',  array['ret']['user_settable'])
    assert_equal('True',  array['density_set_1']['user_settable'])
    assert_equal('True',  array['density_set_2']['user_settable'])
    assert_equal('True',  array['compress']['user_settable'])
    assert_equal('False', array['size_in_mb']['user_settable'])
    assert_equal('True',  array['ret_error']['user_settable'])

  end

end

