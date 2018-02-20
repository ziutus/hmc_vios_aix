class VirtualSerialAdapter

	attr_accessor :virtualSlotNmuber
	attr_accessor :clientOrServer
	attr_accessor :supportsHMC
	attr_accessor :remoteLparID
	attr_accessor :remoteLparName
	attr_accessor :remoteSlotNumber
	attr_accessor :isRequired

	def initialize(string='')
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

	def decode(string)

		regexp = /(\d+)\/(server|client)\/(0|1)\/(\d+|any)\/([\w\_\-]+|)\/(\d+|any)\/(0|1)/
		
		match = regexp.match(string)
	
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

  def diff(other_adapter)

    diff = Array.new

    if self.class.name != another_adapter.class.name
      diff.push('different types of adapters')
      return diff
    end

    if @clientOrServer != other_adapter.clientOrServer
      diff_entry = Hash.new
      diff_entry[profile1] = "clientOrServer is setup to #{@clientOrServer}"
      diff_entry[profile2] = "clientOrServer is setup to #{other_adapter.clientOrServer}"
      diff["clientOrServer"] = diff_entry
    end

    if @supportsHMC != other_adapter.supportsHMC
      diff_entry = Hash.new
      diff_entry[profile1] = "supportsHMC is setup to #{@supportsHMC}"
      diff_entry[profile2] = "supportsHMC is setup to #{other_adapter.supportsHMC}"
      diff["supportsHMC"] = diff_entry
    end

    if @remoteLparID != other_adapter.remoteLparID
      diff_entry = Hash.new
      diff_entry[profile1] = "remoteLparID is setup to #{@remoteLparID}"
      diff_entry[profile2] = "remoteLparID is setup to #{other_adapter.remoteLparID}"
      diff["remoteLparID"] = diff_entry
    end

    if @remoteLparName != other_adapter.remoteLparName
      diff_entry = Hash.new
      diff_entry[profile1] = "remoteLparName is setup to #{@remoteLparName}"
      diff_entry[profile2] = "remoteLparName is setup to #{other_adapter.remoteLparName}"
      diff["remoteLparName"] = diff_entry
    end

    if @remoteSlotNumber != other_adapter.remoteSlotNumber
      diff_entry = Hash.new
      diff_entry[profile1] = "remoteSlotNumber is setup to #{@remoteSlotNumber}"
      diff_entry[profile2] = "remoteSlotNumber is setup to #{other_adapter.remoteSlotNumber}"
      diff["remoteSlotNumber"] = diff_entry
    end

    if @isRequired != other_adapter.isRequired
      diff_entry = Hash.new
      diff_entry[profile1] = "isRequired is setup to #{@isRequired}"
      diff_entry[profile2] = "isRequired is setup to #{other_adapter.isRequired}"
      diff["isRequired"] = diff_entry
    end

    diff
  end

end