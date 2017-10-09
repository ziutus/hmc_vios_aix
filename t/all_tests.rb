
# to call this test: ruby t/all_tests.rb

# The path to Ruby Enlightenment starts with the following:

# dnf install rubygem-test-unit rubygem-test-unit-doc rubygem-test-unit-rr-doc rubygem-test-unit-notify-doc rubygem-test-unit-rr rubygem-test-unit-notify

$LOAD_PATH << File.dirname(__FILE__)+'./inc'
$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

test_unit_version=`gem list test-unit`.to_s.scan(/test-unit \((\d\.\d\.\d)/).join
autorunner_file="#{Gem.dir}/gems/test-unit-#{test_unit_version}/lib/test/unit/autorunner.rb"
require autorunner_file if File.exist?(autorunner_file)


require 'aix_errpt_entry.rb'

require 'aix_etc_hosts_entry.rb'
require 'aix_etc_hosts.rb'
require 'hmc_lpar_netboot.rb'
require 'hmc_lpar_profile.rb'
require 'hmc_lpar_real.rb'
require 'hmc_lssysconf_sys.rb'
require 'hmcRemoteAccess.rb'
require 'hmc_resourcerole.rb'
require 'hmc_resourceRoles.rb'
require 'hmc_resoure.rb'
require 'hmcString.rb'
require 'hmc_version.rb'
require 'hmc_VirtualEthAdapter.rb'
require 'hmc_VirtualScsiAdapter.rb'
require 'hmc_VirtualSerialAdapter.rb'
require 'hmc_frame_lshwres_io_slot.rb'

require 'unix_ps_ef.rb'
require 'unix_ps_process.rb'
#require "targetcli_1.rb"
#require "targetcli_backstore_lv.rb"
