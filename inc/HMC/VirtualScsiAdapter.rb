class VirtualScsiAdapter

	#TODO: analyze if in case that remote lpar or slot is 'any' can we do simpler code (not so many if..elsif...)

	attr_accessor :virtualSlotNumber, :clientOrServer, :remoteLparID, :remoteLparName, :remoteSlotNumber, :isRequired 

	def initialize string='' 
		@virtualSlotNumber
		@clientOrServer
		@remoteLparID
		@remoteLparName
		@remoteSlotNumber
		@isRequired 
		
		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end			
	end

	#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
	def to_s
		self.validate
		"#{@virtualSlotNumber}/#{@clientOrServer}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/#{@isRequired}"
	end
	
	def validate

		raise 'virtualSlotNumber not defined' 		if 	   (@virtualSlotNumber == nil)
		raise 'virtualSlotNumber is not number' 	unless (@virtualSlotNumber.is_a? Numeric)
		raise "virtualSlotNumber has wrong value: #{@virtualSlotNumber}" 	if (@virtualSlotNumber < 1)
	
		raise 'clinetOrServer not defined' 		if 	   (@clientOrServer == nil)
		clientOrServer_allowed = [ 'client', 'server']
		raise "clinetOrServer has wrong value #{@clientOrServer}" unless clientOrServer_allowed.include?(@clientOrServer)
		
		raise 'remoteLparID not defined' 		if 	   (@remoteLparID.== nil)
		raise 'remoteLparID is not number' 		unless (@remoteLparID.is_a? Numeric)
		
		raise 'remoteLparName not defined' 		if	   (@remoteLparName == nil)
		raise 'remoteLparName is not string'	unless (@remoteLparName.is_a? String)

		raise 'remoteSlotNumber not defined' 	if     (@remoteSlotNumber == nil)
		raise 'remoteSlotNumber is not number' 	unless (@remoteSlotNumber.is_a? Numeric)
		
		raise 'isRequired not defined' 			if     (@isRequired == nil)
		raise 'isRequired is not number'		unless (@isRequired.is_a? Numeric)
		raise "isRequired has wrong value #{@isRequired} " unless (@isRequired == 0 or @isRequired == 1)
		
	end 
	
	def decode string

		regExp      = %r{^\s*(\d+)/(server|client)/(\d+)/([\w\_\-\.]+)/(\d+)/(0|1)\s*$}
		regExp_any  = %r{^\s*(\d+)/(server|client)/(any)/([\w\_\-\.]+)/(any)/(0|1)\s*$}
		regExp_long = %{^\s*slot_num=(\d+),state=(0|1),is_required=(0|1),adapter_type=(client|server),remote_lpar_id=(\d+|any),remote_lpar_name=([\w\_\-]+|),remote_slot_num=(\d+|any)\s*$}
		
		
		
		if  match = regExp.match(string)
			@virtualSlotNumber	= match[1].to_i	
			@clientOrServer		= match[2]
			@remoteLparID		= match[3].to_i
			@remoteLparName		= match[4]
			@remoteSlotNumber	= match[5].to_i
			@isRequired			= match[6].to_i
		elsif  match = regExp_any.match(string)
			@virtualSlotNumber	= match[1].to_i	
			@clientOrServer		= match[2]
			@remoteLparID		= match[3]
			@remoteLparName		= match[4]
			@remoteSlotNumber	= match[5]
			@isRequired			= match[6].to_i
		elsif match = regExp_long.match(string)
			@virtualSlotNumber	= match[1].to_i	
			@state				= match[2]
			@isRequired			= match[3].to_i
			@clientOrServer		= match[4]
			@remoteLparID		= match[5].to_i
			@remoteLparName		= match[6]
			@remoteSlotNumber	= match[7].to_i
		else	
			abort "Class VirtualScsiAdapter:RegExp couldn't decode string #{string}"
		end		
	end
	
	alias :parse :decode

	def ==(another_adapter)
		self.to_s == another_adapter.to_s
	end


end