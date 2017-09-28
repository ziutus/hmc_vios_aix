require 'pp'
require 'VIOS/Vtd2'
require 'VIOS/Vhost'

class Lsmap

	attr_accessor :mapping 
#	attr_reader :data_string_raw
	
	
	def initialize string='' 
		
		@mapping = Hash.new()
		
		if string.length > 0
#		  @data_string_raw = string
		  self.parse_long(string)
		end			
	end	

	def parse_long string 

		vhost_number=0
		vtd_number=0
		vhost = ''
		vhost_value = ''
	
		string.each_line { |line|
#			pp line
			if (line =~ /^\s*SVSA\s+Physloc\s+Client\sPartition\sID\s*$/) 
#				print ">>found new vhost<< \n"
				next
			elsif (line =~ /^\s*[-]+\s+[-]+\s+[-]+\s*$/)
				next
			elsif (line =~ /^\s*(vhost\d+)\s+([\w\-\.]+)\s+(\w+)\s*$/)	
				if vhost_number > 0
					if vtd_number > 0
						vhost.vtds_add(Vtd2.new(vhost_value))
					end	
					
					@mapping[vhost.name] = vhost
				end
			
				vhost = Vhost.new(line)
				vhost_number = vhost_number + 1
				vhost_value  = ''
				vtd_number=0
				
			elsif (line =~ /^\s*$/)
				next
			elsif (line =~ /^\s*VTD\s+([\w\_\-]+)\s*$/)
				if vtd_number > 0
					vhost.vtds_add(Vtd2.new(vhost_value))
				end	

				vtd_number = vtd_number +1
			
				vhost_value = line 
			elsif (line =~ /^\s*Status\s+(Available|Defined)\s*$/)
				vhost_value = vhost_value + line 
			elsif (line =~ /^\s*LUN\s+(0x\w+)\s*$/)		
				vhost_value = vhost_value + line 
			elsif (line =~ /Backing\sdevice\s+([\w\-\_]+)/) 
				vhost_value = vhost_value + line 
			elsif (line =~ /Physloc/)		
				vhost_value = vhost_value + line 
			elsif (line =~ /^\s*Mirrored\s+(true|false)\s*$/)
				vhost_value = vhost_value + line 
			else	
				raise "Class:VIOS:lsmap, function: parse_long, RegExp couldn't decode line >>#{line}<<"
			end			
		}
		
		if vtd_number > 0
			vhost.vtds_add(Vtd2.new(vhost_value))
		end	
		
		if vhost_number > 0
			@mapping[vhost.name] = vhost
		end
	end
end