$LOAD_PATH << File.dirname(__FILE__)+"/../inc"

require 'HMC/Version'
require "test/unit"
require 'pp'

# Test data taken from: https://sites.google.com/site/rhdisk0/unix/aix/hmc-in-virtualbox
class TestHMVersion < Test::Unit::TestCase

  def test_only82
    string = '"version= Version: 8
 Release: 8.2.0
 Service Pack: 0
HMC Build level 20141006.3
","base_version=V8R8.2.0
"'

    myHmc = Version.new(string)

    assert_equal('8',          myHmc.version)
    assert_equal('8.2.0',      myHmc.release)
    assert_equal('0',          myHmc.servicePack)
    assert_equal('20141006.3', myHmc.hmcBuildLevel)
    assert_equal('V8R8.2.0',   myHmc.base_version)

  end


  def test_hmc82MH01454
    string = '"version= Version: 8
 Release: 8.2.0
 Service Pack: 0
HMC Build level 20141104.1
MH01454: Required fix for HMC V8R8.2.0 (11-05-2014)
","base_version=V8R8.2.0
"'

    myHmc = Version.new(string)

    assert_equal('8',          myHmc.version)
    assert_equal('8.2.0',      myHmc.release)
    assert_equal('0',          myHmc.servicePack)
    assert_equal('20141104.1', myHmc.hmcBuildLevel)
    assert_equal(true,         myHmc.hasFix?('MH01454'))
    assert_equal('V8R8.2.0',   myHmc.base_version)

  end
end
