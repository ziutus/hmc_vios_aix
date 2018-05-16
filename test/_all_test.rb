$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'test/unit'

Dir[File.dirname(File.absolute_path(__FILE__)) + '/*_test.rb'].each {|file|
  next if file == '_all_test.rb'
  require file
}

