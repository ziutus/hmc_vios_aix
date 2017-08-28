
# to call this test: ruby t/all_tests.rb

# The path to Ruby Enlightenment starts with the following:

# dnf install rubygem-test-unit rubygem-test-unit-doc rubygem-test-unit-rr-doc rubygem-test-unit-notify-doc rubygem-test-unit-rr rubygem-test-unit-notify

$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.dirname(__FILE__)+"/../inc"


require "aix_etc_hosts_entry.rb"
require "aix_etc_hosts.rb"
require "hmc_lpar_netboot.rb"
require "hmc_lpar_profile2.rb"
require "hmc_lpar_profile.rb"
require "hmc_lpar_real.rb"
require "hmc_resourcerole.rb"
require "hmc_resourceRoles.rb"
require "hmc_resoure.rb"
require "hmc_VirtualEthAdapter.rb"
require "hmc_VirtualScsiAdapter.rb"
require "hmc_VirtualSerialAdapter.rb"
#require "targetcli_1.rb"
#require "targetcli_backstore_lv.rb"
