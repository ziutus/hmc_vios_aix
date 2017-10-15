$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'AIX/EtcHostsEntry'
require 'test/unit'
require 'pp'

class TestAixEtcHosts < Test::Unit::TestCase

	def test_etc_hosts_entry_1

		string='127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4'

		myEntry = EtcHostsEntry.new('127.0.0.1', 'localhost', 'localhost.localdomain localhost localhost4   localhost localhost4.localdomain4')

		assert_equal(string, myEntry.to_s() ,   '127.0.0.1 - to_s')
		assert_equal(9,      myEntry.ip_size,   '127.0.0.1 - ip size')
		assert_equal(true,   myEntry.corrected, '127.0.0.1 - entry corrected')
				
	end
end