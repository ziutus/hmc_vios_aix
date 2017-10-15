class VirtualSerialAdapter

	attr_accessor :virtualSlotNmuber, :clientOrServer, :supportsHMC, :remoteLparID 
	attr_accessor :remoteLparName, :remoteSlotNumber, :isRequired 

	def initialize string='' 
		@virtualSlotNmuber
		@clientOrServer
		@supportsHMC
		@remoteLparID
		@remoteLparName
		@remoteSlotNumber
		@isRequired


		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end		
	end

	def decode string

		regExp = /(\d+)\/(server|client)\/(0|1)\/(\d+|any)\/([\w\_\-]+|)\/(\d+|any)\/(0|1)/
		
		match = regExp.match(string)
	
		abort "Class VirtualSerialAdapter: RegExp couldn't decode string #{string}" unless match
		
		@virtualSlotNmuber	= match[1].to_i		
		@clientOrServer		= match[2]
		@supportsHMC		= match[3].to_i
		@remoteLparID		= match[4]
		@remoteLparName		= match[5]
		@remoteSlotNumber	= match[6]
		@isRequired			= match[7].to_i
	
	end

	alias :parse :decode
	
	
	#virtual-slot-number/client-or-server/[supports-HMC]/[remote-lpar-ID]/[remote-lpar-name]/[remote-slot-number]/is-required
	def to_s
		"#{@virtualSlotNmuber}/#{@clientOrServer}/#{@supportsHMC}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/#{@isRequired}"
	end

  def ==(another_adapter)
    self.to_s == another_adapter.to_s
  end

end