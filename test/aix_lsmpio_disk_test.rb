$LOAD_PATH << File.dirname(__FILE__)+'/../lib'

require 'test/unit'
require 'pp'
require 'AIX/lsmpio_disk'

class TestAixLsmpioDisk < Test::Unit::TestCase

  # test data are taken from https://www.ibm.com/support/knowledgecenter/ssw_aix_72/l_commands/lsmpio.html
  def test_aix_lsmpio_disk
    string = '
name   path_id status  path_status     parent connection
===============================================================================
hdisk1234  0   Enabled Opt,Sel,Deg,Rsv fscsi0 500a098186a7d4ca,0008000000000000
hdisk1234  1   Enabled Non             fscsi0 500a098196a7d4ca,0008000000000000
hdisk1234  2   Enabled Opt,Sel         fscsi1 500a098186a7d4ca,0008000000000000
hdisk1234  3   Enabled Non             fscsi1 500a098196a7d4ca,0008000000000000'

    disk = Lsmpio_disk.new(string)

    assert_equal('hdisk1234', disk.name, 'device name')
    assert_equal(4, disk.paths.length, 'number of paths')
    assert_equal(0, disk.paths[0].path_id, 'path_id 0 - path_id check')

  end
end
