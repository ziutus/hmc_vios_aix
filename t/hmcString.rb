$LOAD_PATH << File.dirname(__FILE__)+"/../inc"

require "test/unit"
require 'pp'
require 'HMC/HmcString'

include HmcString

# "--require <gem home>/test-unit-3.2.3/lib/test/unit/autorunner"
#  --require "C:/Ruby24/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test-unit.rb"

class TestString < Test::Unit::TestCase

  def test_String

    string = 'name=L2support,"resources=lpar:root/ibmhscS1_0|1*9131-52A*6535CCG|IBMHSC_Partition,lpar:root/ibmhscS1_0|5*9131-52A*6535CCG|IBMHSC_Partition",nameLong=L2supportRole';

    myHash = HmcString.parse(string)

    assert_equal("L2support",     myHash["name"],     "name - L2support")
    assert_equal("L2supportRole", myHash["nameLong"], "nameLong - L2supportRole")

  end
end