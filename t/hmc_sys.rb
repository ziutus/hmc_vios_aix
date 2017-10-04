$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/Sys'
require "test/unit"
require 'pp'


class TestHMCSystem < Test::Unit::TestCase

  # test data taken from: https://www.ibm.com/support/knowledgecenter/en/SGVKBA_3.2.2/com.ibm.rsct.trouble/RMC_connection_diagnosis.htm
  def test_name
    string =

    system = Sys.new()

    system.parse_f('9.3.206.220,9179-MHD,1003EFP,No Connection', 'name,type_model,serial_num,state')

    assert_equal(system.name, '9.3.206.220')
    assert_equal(system.type_model, '9179-MHD')
    assert_equal(system.serial_num, '1003EFP')
    assert_equal(system.state, 'No Connection')

  end

end
