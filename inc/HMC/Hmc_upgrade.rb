class HmcUpgrade

  attr_accessor :hostname
  attr_accessor :user
  attr_accessor :password
  attr_accessor :ssh_key
  attr_accessor :mount_location
  attr_accessor :mount_options
  attr_accessor :filename
  attr_accessor :reboot
  attr_accessor :remove_file
  attr_accessor :interactive

  @hostname       = nil #option -h
  @user           = nil #option -u
  @password       = nil #option -p
  @ssh_key        = nil #?? (version 8?)
  @mount_location = nil #?? (version 8?)
  @mount_options  = nil #?? (version 8?)
  @filename       = nil #option -f (file on the FTP server to obtain or locally)
  @reboot         = nil #option -r (reboot after installation)
  @remove_file    = nil #option -c (remove the file from local filesystem after the installation)
  @interactive    = nil #option -i (prompt for password)

  attr_accessor :_version

  attr_reader :_type

  @_type          = nil
  @_version       = nil

  t8_options = %w[ disk dvd ftp sftp nfs usb ]
  t7_options = %w[ m s l ]  #m - media, s - server, l - local filesystem (only valid )


  def initialize

  end


  def validate

    if (@_type.nil?)
        @_type = 'server' unless @hostname.nil?
        @_type = 'server' unless @user.nil?
        @_type = 'server' unless @password.nil?
    end


      if (@_type == 'server')
        raise 'hostname not setup' if @hostname.nil?
        raise 'user not setup'     if @user.nil?
        raise 'password not setup' if @password.nil?
      end
  end

  def cmd

    self.validate

    command = 'updhmc '
    command += '-r ' if @reboot == true

    if (@_type == 'server')
      command += "-t s -h #{@hostname} -u #{@user} -p #{@password} -f #{@filename}"
    elsif (@_type == 'media')
      raise 'type media - not implemented'
    elsif (@_type == 'local_filesystem')
      raise 'type local_filesystem - not implemented'
    end
    command
  end

end