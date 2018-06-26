require 'net/ssh'

class MyExec
  def initialize(method, exec_mode='off')
    @method  = method
    @exec_mode = exec_mode
  end

  def show_variables
    puts "Method: #{@method}"

    puts 'Ssh'
    puts "Server: #{@ssh_server}"
    puts "User: #{@ssh_user}"
    puts "Password: #{@ssh_password}"
    puts "ExecMode: #{@exec_mode}"

  end

  def set_ssh(server, user, password)
    @ssh_server   = server
    @ssh_user     = user
    @ssh_password = password
  end

  def execute(command, exec_mode = 'off')

    exec_local = @exec_mode
    exec_local = 'on' if exec_mode == 'on'
    result_string = ''

    STDOUT.sync = true

    Net::SSH.start(@ssh_server, @ssh_user, :password => @ssh_password) do |ssh|
      time1 = Time.new
      puts  time1.strftime('%Y-%m-%d %H:%M:%S') + " calling: #{command}"
      puts  time1.strftime('%Y-%m-%d %H:%M:%S') + ' exec mode: ' + exec_local
      result_string = ssh.exec!(command) if exec_local == 'on'
      time2 = Time.new
      puts  time2.strftime('%Y-%m-%d %H:%M:%S') + ' executed'
      return result_string
    end
  end


end