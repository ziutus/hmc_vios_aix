$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

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