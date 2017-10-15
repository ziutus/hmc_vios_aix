$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)

require 'test/unit'

class HmcLssysconnTest < Test::Unit::TestCase

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

  # Fake test
  def test_fail

    string = 'resource_type=sys,type_model_serial_num=9131-52A*6535CCG,sp=unavailable,sp_phys_loc=unavailable,ipaddr=192.168.200.39,alt_ipaddr=unavailable,state=No Connection,connection_error_code=Connecting  0000-0000-00000000'
    pass('Not implemented')

    string = 'resource_type=sys,type_model_serial_num=9131-52A*6535CCG,sp=primary,sp_phys_loc=unavailable,ipaddr=192.168.200.39,alt_ipaddr=unavailable,state=Connected'
  end
end