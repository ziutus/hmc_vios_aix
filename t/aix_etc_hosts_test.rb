$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)

require 'AIX/EtcHosts'
require 'test/unit'
require 'pp'

class TestAixEtcHosts < Test::Unit::TestCase

	def test_decode_etc_hosts_1

		string='#file, etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
'

		etc_hosts = EtcHosts.new(string)
		assert_equal(etc_hosts.check('127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4'), false, 'etc_hosts has info about 127.0.0.1')
		assert_equal(etc_hosts.check('192.168.200.1 gateway'), false, 'etc_hosts has info about 192.168.200.1')

	end
end
