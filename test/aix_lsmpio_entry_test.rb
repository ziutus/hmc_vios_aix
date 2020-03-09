$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'AIX/lsmpio_entry'

class TestAixFcstat < Test::Unit::TestCase

  # test data are taken from https://www.ibm.com/support/knowledgecenter/ssw_aix_72/l_commands/lsmpio.html
  def test_lsmpio_entry_1
    string = 'hdisk1234  0   Enabled Opt,Sel,Deg,Rsv fscsi0 500a098186a7d4ca,0008000000000000'

    lsmpio_entry = Lsmpio_entry.new(string)

    assert_equal(string, lsmpio_entry.string_raw, 'raw string equal to provided string')
    assert_equal('hdisk1234', lsmpio_entry.name, 'name')
    assert_equal(0, lsmpio_entry.path_id, 'path_id')
    assert_equal('Enabled', lsmpio_entry.status, 'status')
    assert_equal('Opt,Sel,Deg,Rsv', lsmpio_entry.path_status, 'path_status')
    assert_equal('fscsi0', lsmpio_entry.parent, 'parent')
    assert_equal('500a098186a7d4ca,0008000000000000', lsmpio_entry.connection, 'connection')
  end
end