$LOAD_PATH << File.dirname(__FILE__)+"/../inc"
$LOAD_PATH << File.dirname(__FILE__)

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'VIOS/Vhost'
require 'test/unit'
require 'pp'

class TestViosVtd < Test::Unit::TestCase

	def test_vhost1

		string='vhost2       	      U9111.520.10004BA-V1-C2           0x0000000b'
		vhost = Vhost.new(string)

		assert_equal('vhost2', 			            vhost.name)
		assert_equal('U9111.520.10004BA-V1-C2', vhost.physloc)
		assert_equal('0x0000000b', 			        vhost.client_partition_id)
		assert_equal(11, 			    		          vhost.client_partition_id_nice)
	end

end