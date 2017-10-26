$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'Data_file'

require 'test/unit'
require 'pp'

class DataFileTest < Test::Unit::TestCase


  def test_read_data_file_1
    datafile = Data_file.new('data/data_file.txt')

    assert_equal("command_4_result_line_1\n", datafile.find('command 4 2>&1'))
    assert_equal("command_4_result_line_1\n", datafile.find('command 4'))

  end
end