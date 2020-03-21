$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'AIX/package'
require 'test/unit'
require 'pp'


class AIX_lslpp < Test::Unit::TestCase

  # http://aix-adm.blogspot.com/2014/12/aix-lslpp.html
  def test_lslpp
    string = 'bos:bos.rte.security:5.3.1.1: : :C:F:Base Security Function: : : : : : :0:1:/:1806'

    package = Package.new(string)

    assert_equal('bos.rte.security', package.fileset)
    assert_equal('5.3.1.1', package.level)
    assert_equal('Base Security Function', package.description)


  end

end