class VirtualScsiAdapter

	attr_accessor :virtualSlotNumber, :clientOrServer, :remoteLparID, :remoteLparName, :remoteSlotNumber, :isRequired 

	def def initialize 
		@virtualSlotNumber
		@clientOrServer
		@remoteLparID
		@remoteLparName
		@remoteSlotNumber
		@isRequired 
	end

	#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
	def to_s
	
		self.validate
	
		"#{@virtualSlotNumber}/#{@clientOrServer}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/#{@isRequired}"
	end
	
	def validate

		raise "virtualSlotNumber not defined" 		if 	   (@virtualSlotNumber == nil)
		raise "virtualSlotNumber is not number" 	unless (@virtualSlotNumber.is_a? Numeric)
		raise "virtualSlotNumber has wrong value: #{@virtualSlotNumber}" 	if (@virtualSlotNumber < 1)
	
		raise "clinetOrServer not defined" 		if 	   (@clientOrServer == nil)
		clientOrServer_allowed = [ "client", "server"]		
		raise "clinetOrServer has wrong value #{@clientOrServer}" unless clientOrServer_allowed.include?(@clientOrServer)
		
		raise "remoteLparID not defined" 		if 	   (@remoteLparID.== nil)
		raise "remoteLparID is not number" 		unless (@remoteLparID.is_a? Numeric)
		
		raise "remoteLparName not defined" 		if	   (@remoteLparName == nil)
		raise "remoteLparName is not string"	unless (@remoteLparName.is_a? String)

		raise "remoteSlotNumber not defined" 	if     (@remoteSlotNumber == nil)
		raise "remoteSlotNumber is not number" 	unless (@remoteSlotNumber.is_a? Numeric)
		
		raise "isRequired not defined" 			if     (@isRequired == nil)
		raise "isRequired is not number"		unless (@isRequired.is_a? Numeric)
		raise "isRequired has wrong value #{@isRequired} " unless (@isRequired == 0 or @isRequired == 1)
		
	end 
	
	def decode string

		regExp = /(\d+)\/(server|client)\/(\d+)\/([\w\_\-]+)\/(\d+)\/(0|1)/
		regExp2 = /slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)/
		match = regExp.match(string)
		match2 = regExp2.match(string)
		
		if  (match)
			@virtualSlotNumber	= match[1].to_i	
			@clientOrServer		= match[2]
			@remoteLparID		= match[3].to_i
			@remoteLparName		= match[4]
			@remoteSlotNumber	= match[5].to_i
			@isRequired			= match[6].to_i
		elsif (match2)
			@virtualSlotNumber	= match2[1].to_i	
			@state				= match2[2]
			@isRequired			= match2[3].to_i
			@clientOrServer		= match2[4]
			@remoteLparID		= match2[5].to_i
			@remoteLparName		= match2[6]
			@remoteSlotNumber	= match2[7].to_i
			
			
		else	
			abort "RegExp couldn't decode string #{string}"
		end
		
	end
	
end