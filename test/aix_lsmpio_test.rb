$LOAD_PATH << File.dirname(__FILE__)+'/../lib'

require 'test/unit'
require 'pp'
require 'AIX/lsmpio'

class TestAixFcstat < Test::Unit::TestCase

  # test data are taken from https://www.ibm.com/support/knowledgecenter/ssw_aix_72/l_commands/lsmpio.html
  # data for hdisk1235 are copy of hdisk1234
  def test_aixs_lsmpio_2_disks
    string = '
name   path_id status  path_status     parent connection
===============================================================================
hdisk1234  0   Enabled Opt,Sel,Deg,Rsv fscsi0 500a098186a7d4ca,0008000000000000
hdisk1234  1   Enabled Non             fscsi0 500a098196a7d4ca,0008000000000000
hdisk1234  2   Enabled Opt,Sel         fscsi1 500a098186a7d4ca,0008000000000000
hdisk1234  3   Enabled Non             fscsi1 500a098196a7d4ca,0008000000000000
hdisk1235  0   Enabled Opt,Sel,Deg,Rsv fscsi0 500a098186a7d4ca,0009000000000000
hdisk1235  1   Enabled Non             fscsi0 500a098196a7d4ca,0009000000000000
hdisk1235  2   Enabled Opt,Sel         fscsi1 500a098186a7d4ca,0009000000000000
hdisk1235  3   Enabled Non             fscsi1 500a098196a7d4ca,0009000000000000'

    lsmpio = Lsmpio.new(string)

    assert_equal(2, lsmpio.disks.length, '2 disks are in output')
    assert_equal(4, lsmpio.disks['hdisk1234'].paths.length, '4 paths for hdisk1234')
    # assert_equal(true, lsmpio.enabled_all, 'all paths enabled')
  end
end
