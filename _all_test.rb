$LOAD_PATH << File.dirname(__FILE__)+"/lib"

require 'test/unit'

Dir[File.dirname(File.absolute_path(__FILE__)) + '/test/*_test.rb'].each {|file|
  puts file
  require file
}

