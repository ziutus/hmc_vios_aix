$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'AIX/lsmpio'

class TestAixFcstat < Test::Unit::TestCase

  # test data are taken from http://www.wmduszyk.com/?p=6800&langswitch_lang=en
  def test_fcstat_error_reading_statistics_information
    string = '
name   path_id status  path_status     parent connection
===============================================================================
hdisk1234  0   Enabled Opt,Sel,Deg,Rsv fscsi0 500a098186a7d4ca,0008000000000000
hdisk1234  1   Enabled Non             fscsi0 500a098196a7d4ca,0008000000000000
hdisk1234  2   Enabled Opt,Sel         fscsi1 500a098186a7d4ca,0008000000000000
hdisk1234  3   Enabled Non             fscsi1 500a098196a7d4ca,0008000000000000'

    lsmpio = Lsmpio.new(string)
    lsmpio.validate

    # pp lsmpio.data
    # assert_equal('hdisk1234', lsmpio.name, 'device name')
    assert_equal(true, lsmpio.enabled_all, 'all paths enabled')
  end
end