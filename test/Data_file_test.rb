$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'Framework/DataFile'

require 'test/unit'
require 'pp'

class DataFileTest < Test::Unit::TestCase


  def test_read_data_file_1
    datafile = DataFile.new('test/data/data_file.txt')

    assert_equal("command_4_result_line_1\n", datafile.find('command 4 2>&1'))
    assert_equal("command_4_result_line_1\n", datafile.find('command 4'))

  end

  def test_similar_commands
    datafile = DataFile.new('test/data/data_file_lsmap.txt')
    assert_equal('lsmap -npiv -all -fmt :', datafile.find_simiar_command('lsmap -npiv -all'))
    assert_equal('lsmap -all', datafile.find_simiar_command('lsmap -all -fmt :'))

  end
end