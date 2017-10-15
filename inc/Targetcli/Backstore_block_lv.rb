class Backstore_block_lv < Backstore_block

	attr_accessor :vg, :lv

	def initialize 
		super 		
	end	
	
	def lsDecode string
	
		regexp_no_device = /^No\ssuch\spath\s/
		regexp_ls_backstore =  /^\s*\|\s+\|\s+\o\-\s+([\w\_]+)\s+[\.]+\s+\[\/dev\/([\w\_]+)\/([\w\_]+)\s+\((\d+\.\d+[MG]iB)\)\s+(write-thru)\s(activated)\]$/
		
		match_no_device   = regexp_no_device.match(string)
		match_ls_backstore = regexp_ls_backstore.match(string)

		if match_no_device 
			return "no device"
		elsif match_ls_backstore
		
			@name = match_ls_backstore[1]
			@vg = match_ls_backstore[2]
			@lv = match_ls_backstore[3]
			@size = match_ls_backstore[4]
			@write = match_ls_backstore[5]
			@status = match_ls_backstore[6]
		
			@path = "/dev/" + @vg + "/" +@lv
		
			return "device found"
		else
			
			puts "RegExp couldn't decode string >#{string}<"
			raise "Couldn't decode string"
			
		end
		
	end	
	
	def create_cmd

		@command + " /backstores/block create name=" + @name + " dev=/dev/" + @vg + "/" + @lv 
	end

	def delete_cmd
	
		@command + " /backstores/block delete " + @name 
	end 
	
	def ls_all_cmd
		@command + " /backstores/block ls"
	end 
end 