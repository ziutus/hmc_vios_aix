require 'HMC/HmcString'
include HmcString

class HmcData

  attr_reader :errors
  attr_reader :warnings
  attr_accessor :verbose

  def initialize(dir)
    @errors   = []
    @warnings = []
    @verbose = 0
    @sys = []
    @dir = dir

    @hmc_dir_map = {
      'frame_list'   => 'lssysscfg_r_frame_F_name_serial_num_state.txt',
      'sys_list'     => 'lssyscfg_r_sys_F_name_serial_num_state.txt',
      'lssysconn'    => 'lssysconn_r_all.txt',
      'ldap'         => 'ldap.txt',
      'lssvcevents_hardware' => 'lssvcevents_hardware.txt',
      'resurceroles' => 'resourceroles.txt'
    }

    @frame_files_map = {
      'frame_memory'  => '_mem.txt',
      'frame_proc' => '_proc.txt',
    }

    @frame_lpar_map = {
      'lpar_info' => '_lpar.txt',
      'io_slot' => '_io_slot.txt',
      'memory' => '_mem_lpar.txt',
      'proc' => '_proc_lpar.txt',
      'virtual_eth' => '_virtual_eth.txt',
      'virtual_fc' => '_virtual_fc.txt',
      'virtual_scsi' => '_virtual_scsi.txt',
      'virtual_serial' => '_virtual_serial.txt',
      'virtual_slot' => '_virtual_slot.txt',
      'prof' => '_prof.txt',
    }
  end

  def validate
    errors = 0

    puts 'HMC files:' if @verbose > 0
    if File.directory?(@dir)
      puts "checking if directory #{@dir} exist [OK]" if @verbose > 0
    else
      @errors.push("The directory #{@dir} doesn't exist!")
      return false
    end

    if File.exist?(@dir + '/' + @hmc_dir_map['sys_list'])
      puts "checking if list of systems exist #{@dir + '/' + @hmc_dir_map['sys_list']} exist [OK]" if @verbose > 0
    else
      @errors.push("File with list of systems >#{@dir}/#{@hmc_dir_map['sys_list']}< doesn't exist!")
      return false
    end

    @hmc_dir_map.each_pair do |file_type,filename|
      errors += 1 unless file_exist?(file_type, @dir + '/' + filename)
    end

    list_of_frames

    @sys.each do |sys_name|
      puts "Frame: #{sys_name}" if @verbose > 0
      @frame_files_map.each_pair do |file_type,filename|
        errors += 1 unless file_exist?(file_type, @dir + '/' + sys_name + filename)
      end

      @frame_lpar_map.each_pair do |file_type,filename|
        errors += 1 unless file_exist?(file_type, @dir + '/' + sys_name + filename)
      end
    end

    return false if errors > 0
    true
  end

  def list_of_frames
    File.read(@dir + '/' + @hmc_dir_map['sys_list']).split("\n").each do |string|
      sys = Sys.new()
      sys.parse_f(string, 'name,serial_num,state')
      @sys.push(sys.name)
    end
  end

  def file_exist?(file_type, filename)
    if File.exist?(filename)
      puts "checking #{file_type}: #{filename} exist [OK]" if @verbose > 0
    else
      @errors.push("File >#{filename}< doesn't exist!")
      puts "checking #{file_type}: #{filename} doesn't exist! [Error]" if @verbose > 0
      return false
    end
    true
  end

  def lpar_hash(sys_name, lpar_id)
    result = {}

    @frame_lpar_map.each_pair do |file_type,filename|
      next unless File.readable?(@dir + '/' + sys_name + filename)
      file = File.new(@dir + '/' + sys_name + filename, 'r')
      while (line = file.gets)
        hmc_data = HmcString.parse(line)
        if hmc_data['lpar_id'] == lpar_id.to_s
          result[file_type].nil? ? result[file_type] = line : result[file_type] += line
        end
      end
    end

    result
  end

end