$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'

require 'test/unit'
require 'pp'
require 'Framework/framework_data'

class FrameworkDataTest < Test::Unit::TestCase


  def test_frameworkdata1

    data = FrameworkData.new('data/', '20180603_1656')
    data.vios_datafile_extension = 'txt'
    data.verbose = 3

    npiv_mapping = data.vios_data('vios1', 'lsmap -npiv -all')

    # pp npiv_mapping
  end
end