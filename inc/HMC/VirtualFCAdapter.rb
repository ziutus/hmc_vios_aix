class VirtualFCAdapter

	#see: http://www-01.ibm.com/support/docview.wss?uid=nas8N1011009
	#see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8edm/mksyscfg.html
	
	attr_accessor :virtualSlotNumber, :clientOrServer, :remoteLparID, :remoteLparName, :remoteSlotNumber 
	attr_accessor :wwpn1, :wwpn2
	attr_accessor :isRequired 

	def initialize string='' 
		@virtualSlotNumber 
		@clientOrServer
		@remoteLparID
		@remoteLparName
		@remoteSlotNumber 
		@wwpn1
		@wwpn2
		@isRequired=0
		
		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end			
	end
		
		
	def validate
		raise "virtualSlotNumber not defined" unless (@virtualSlotNumber.is_a? Numeric)
	end
		
	def to_s
	
		self.validate()

		#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required

		
		result ="#{@virtualSlotNumber}/#{clientOrServer}/#{@remoteLparID}/#{@remoteLparName}/#{@remoteSlotNumber}/" 
		result = result+"#{@wwpn1}" 	   unless (@wwpn1.nil?)
		result = result+",#{@wwpn2}" 	   unless (@wwpn2.nil?)
		result = result+"/#{@isRequired}"
		
		result
	end
	
	def decode string

		#virtual-slot-number/client-or-server/[remote-lpar-ID]/[remote-lpar-name]/remote-slot-number/[wwpns]/is-required
	
		regExp =  %r{^\s*(\d+)/(server|client)/(\d+)/([\w\-\_]+|)/(\d+)/(\w{16}\,\w{16}|\w{16}|)/(0|1)\s*$}

		match = regExp.match(string)
		
		raise "RegExp couldn't decode string #{string}" unless match

		@virtualSlotNumber 	= match[1].to_i	
		@clientOrServer 	= match[2]	
		@remoteLparID 		= match[3].to_i	
		@remoteLparName		= match[4]
		@remoteSlotNumber 	= match[5].to_i	
		wwpns				= match[6]
		@isRequired			= match[7].to_i
		
		if match2 = %r{^\s*(\w{16})\,(\w{16})\s*$}.match(wwpns) 
			@wwpn1 = match2[1]
			@wwpn2 = match2[2]
		elsif  match3 = %r{^\s*(\w{16})\s*$}.match(wwpns) 
			@wwpn1 = match3[1]
			@wwpn2 = nil 
		end

		
	end

	alias :parse :decode

	
end