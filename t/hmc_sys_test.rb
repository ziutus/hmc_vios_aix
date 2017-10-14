$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'HMC/Sys'
require 'test/unit'
require 'pp'


class TestHMCSystem < Test::Unit::TestCase

  # test data taken from: https://www.ibm.com/support/knowledgecenter/en/SGVKBA_3.2.2/com.ibm.rsct.trouble/RMC_connection_diagnosis.htm
  def test_name

    system = Sys.new
    system.parse_f('9.3.206.220,9179-MHD,1003EFP,No Connection', 'name,type_model,serial_num,state')

    assert_equal('9.3.206.220',   system.name)
    assert_equal('9179-MHD',      system.type_model)
    assert_equal('1003EFP',       system.serial_num)
    assert_equal('No Connection', system.state)

  end

end
