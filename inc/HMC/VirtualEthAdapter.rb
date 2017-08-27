class VirtualEthAdapter


	attr_accessor :virtualSlotNumber, :isIEEE, :portVlanID, :additionalVlanIDs, :trunkPriority, :isTrunk
	attr_accessor :isRequired, :virtualSwitch, :macAddress, :allowedOsMacAddresses, :QosPiority 

	def initialize 
		@virtualSlotNumber
		@isIEEE=0
		@portVlanID 
		@additionalVlanIDs=""
		@isTrunk=0
		@trunkPriority=0 #if trunk is true, trunk priority has to to be set up
		@isRequired=0
		
		@virtualSwitch
		
		@macAddress
		@allowedOsMacAddresses
		@QosPiority
	end
		
	def validate
		
		raise "virtualSlotNumber not defined" unless (@virtualSlotNumber.is_a? Numeric)
	end
		
	def to_s
	
		self.validate()
	
		result ="#{@virtualSlotNumber}/#{@isIEEE}/#{@portVlanID}/#{@additionalVlanIDs}/#{@trunkPriority}/#{@isRequired}" 
		result = result+"/#{@virtualSwitch}" unless (@virtualSwitch.nil?)
		result = result+"/#{@macAddress}" unless (@macAddress.nil?)
		result = result+"/#{@allowedOsMacAddresses}" unless (@allowedOsMacAddresses.nil?)
		result = result+"/#{@QosPiority}" unless (@QosPiority.nil?)
		
		result
	end
	
	def decode string

#virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/ 
#[allowed-OS-MAC-addresses]/[QoS-priority]]]
	
		regExp = /(\d+)\/(0|1)\/(\d+)\/([\d\,]+|)\/(\d+)\/(0|1)/

		match = regExp.match(string)
		
		abort "RegExp couldn't decode string #{string}" unless match

		@virtualSlotNumber	= match[1].to_i	
		@isIEEE				= match[2].to_i	
		@portVlanID			= match[3].to_i	
		@additionalVlanIDs	= match[4]
		@trunkPriority		= match[5].to_i
		@isRequired			= match[6].to_i

	end
	
end