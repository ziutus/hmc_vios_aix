class MyExec
	def initialize(method, execMode="off")
		@method  = method 
		@execMode= execMode
	end
	
	def showVariables
		puts "Method: #{@method}"
		
		puts "Ssh"
		puts "Server: #{@sshServer}"
		puts "User: #{@sshUser}"
		puts "Password: #{@sshPassword}"
		puts "ExecMode: #{@execMode}"
		
	end
	
	def setSsh(server, user, password)
		@sshServer=server
		@sshUser=user
		@sshPassword=password
	end	
	
	def Exec(command, execMode="off")
		
		execLocal = @execMode
		execLocal = "on" if execMode == "on"
		resultString = ""
	
		Net::SSH.start(@sshServer, @sshUser, :password => @sshPassword) do |ssh|
			time1 = Time.new
			puts  time1.strftime("%Y-%m-%d %H:%M:%S") + " calling: #{command}"
			puts  time1.strftime("%Y-%m-%d %H:%M:%S") + " exec mode: " + execLocal
			resultString = ssh.exec!(command) if ( execLocal == "on")
			time2 = Time.new
			puts  time2.strftime("%Y-%m-%d %H:%M:%S") + " executed"
			return resultString 			
		end
	end 
	
	
end