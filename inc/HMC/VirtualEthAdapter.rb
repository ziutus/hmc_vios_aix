class VirtualEthAdapter


	attr_accessor :virtualSlotNumber, :isIEEE, :portVlanID, :additionalVlanIDs, :trunkPriority, :isTrunk
	attr_accessor :isRequired, :virtualSwitch, :macAddress, :allowedOsMacAddresses, :qosPiority 

	def initialize string='' 
		@virtualSlotNumber
		@isIEEE=0
		@portVlanID 
		@additionalVlanIDs=''
		@isTrunk=0
		@trunkPriority=0 #if trunk is true, trunk priority has to to be set up
		@isRequired=0
		
		@virtualSwitch
		
		@macAddress
		@allowedOsMacAddresses
		@qosPiority
		
		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end			
	end
		
		
	def validate
		raise 'class: VirtualEthAdapter: function: validation, virtualSlotNumber not defined' unless (@virtualSlotNumber.is_a? Numeric)
		raise 'class: VirtualEthAdapter: function: validation, isIEEE not defined' unless (@isIEEE.is_a? Numeric)
		raise 'class: VirtualEthAdapter: function: validation, isRequired not defined' unless (@isRequired.is_a? Numeric)
	end
		
	def to_s
	
		self.validate()
	
		result ="#{@virtualSlotNumber}/#{@isIEEE}/#{@portVlanID}/#{@additionalVlanIDs}/#{@trunkPriority}/#{@isRequired}" 
		result = result+"/#{@virtualSwitch}" 		 unless (@virtualSwitch.nil?)
		result = result+"/#{@macAddress}" 			 unless (@macAddress.nil?)
		result = result+"/#{@allowedOsMacAddresses}" unless (@allowedOsMacAddresses.nil?)
		result = result+"/#{@qosPiority}" 			 unless (@qosPiority.nil?)

		if result.include?(',')
		  result = '""' + result + '""'
    end

		result
	end
	
	def decode string

#virtual-slot-number/is-IEEE/port-vlan-ID/[additional-vlan-IDs]/[trunk-priority]/is-required[/[virtual-switch][/[MAC-address]/ 
#[allowed-OS-MAC-addresses]/[QoS-priority]]]
	
		regExp_minimum 			   = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)\s*$}
		regExp_vswitch 			   = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)\s*$}
		regExp_mac_address 		   = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)\s*$}
		regExp_allowed_mac_address = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)\s*$}
		regExp_qos_priority 	   = %r{^\s*(\d+)/(0|1)/(\d+)/([\d\,]+|)/(\d+)/(0|1)/([\w\_\-]+)/(\w+|)/([\w\,]+|all)/(\d+|none)\s*$}

		if match = regExp_minimum.match(string) 
		
			@virtualSlotNumber	= match[1].to_i	
			@isIEEE				= match[2].to_i	
			@portVlanID			= match[3].to_i	
			@additionalVlanIDs	= match[4]
			@trunkPriority		= match[5].to_i
			@isRequired			= match[6].to_i

		elsif match = regExp_vswitch.match(string) 
		
			@virtualSlotNumber	= match[1].to_i	
			@isIEEE				= match[2].to_i	
			@portVlanID			= match[3].to_i	
			@additionalVlanIDs	= match[4]
			@trunkPriority		= match[5].to_i
			@isRequired			= match[6].to_i
			@virtualSwitch		= match[7].to_i

		elsif match = regExp_mac_address.match(string) 
		
			@virtualSlotNumber	= match[1].to_i	
			@isIEEE				= match[2].to_i	
			@portVlanID			= match[3].to_i	
			@additionalVlanIDs	= match[4]
			@trunkPriority		= match[5].to_i
			@isRequired			= match[6].to_i
			@virtualSwitch		= match[7]
			@macAddress			= match[8]
			
		elsif match = regExp_allowed_mac_address.match(string) 

			@virtualSlotNumber	= match[1].to_i	
			@isIEEE				= match[2].to_i	
			@portVlanID			= match[3].to_i	
			@additionalVlanIDs	= match[4]
			@trunkPriority		= match[5].to_i
			@isRequired			= match[6].to_i
			@virtualSwitch		= match[7]
			@macAddress			= match[8]
			@allowedOsMacAddresses = match[9]

		elsif match = regExp_qos_priority.match(string) 

			@virtualSlotNumber	= match[1].to_i	
			@isIEEE				= match[2].to_i	
			@portVlanID			= match[3].to_i	
			@additionalVlanIDs	= match[4]
			@trunkPriority		= match[5].to_i
			@isRequired			= match[6].to_i
			@virtualSwitch		= match[7]
			@macAddress			= match[8]
			@allowedOsMacAddresses = match[9]
			@qosPiority			= match[10]
			
		else
			raise "class:VirtualEthAdapter, function:parse, RegExp couldn't decode string >#{string}<"
		end
		
		
	end

	alias :parse :decode

	def ==(another_adapter)
		self.to_s == another_adapter.to_s
	end


end