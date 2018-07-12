require 'pathname'

require 'Framework/hmcDir'
require 'Framework/system'
require 'Framework/DataFile'

require 'VIOS/lsmap'
require 'VIOS/lsmap_net'
require 'VIOS/lsmap_npiv'

class FrameworkData

  attr_accessor :directory
  attr_accessor :date
  attr_accessor :verbose

  attr_accessor :vios_subdirectory
  attr_accessor :hmc_directory
  attr_accessor :vios_datafile_extension

  def initialize(directory, date)
    @directory = directory
    @date = date
    @verbose = $VERBOSE.nil? || $VERBOSE == false ? 0 : $VERBOSE
    @vios_datafile_extension = nil

    @hmc_directory = '/hmc'
    @vios_subdirectory = '/vios'
  end

  def search_frame(sys_to_find)
    systems = []

    puts ">DEBUG(1): searching data about frame #{sys_to_find}" if @verbose > 0
    hmc_dir_base = @directory + '/' + @hmc_directory + '/' + @date + '/'
    puts ">DEBUG(1): checking directory #{hmc_dir_base}" if @verbose > 0
    Dir.chdir(hmc_dir_base)
    Dir.glob('*').select do |hmc|
      puts "Checking HMC #{hmc} (dir: #{hmc_dir_base}/#{hmc}" if @verbose > 0
      next unless File.directory?(hmc)

      hmc_data = HmcDir.new(hmc_dir_base + hmc)
      hmc_data.verbose = @verbose
      hmc_data.create_list_of_frames

      hmc_data.sys.each do |sys_name|
        sys = System.new(sys_name, hmc)
        sys.parse_raw_data(hmc_data.file_content(sys_name, 'lpar_info'))
        systems.push(sys) if sys.name == sys_to_find or sys_to_find == 'ALL'
      end
    end

    systems
  end

  def search_lpar(lpar_to_find, data_to_find = 'none')
    lpars = []

    puts '>DEBUG: searching data about frame on HMCs' if @verbose > 0

    hmc_dir_base = @directory + '/' + @hmc_directory + '/' + @date + '/'
    puts ">DEBUG: going to directory #{hmc_dir_base}"
    Dir.chdir(hmc_dir_base)
    Dir.glob('*').select do |hmc|
      puts ">DEBUG: Checking HMC #{hmc} and directory #{hmc_dir_base}/#{hmc} " if @verbose > 0
      next unless File.directory? hmc

      hmc_data = HmcDir.new(hmc_dir_base + hmc)
      hmc_data.verbose = @verbose
      hmc_data.create_list_of_frames

      hmc_data.sys.each do |sys_name|
        sys = System.new(sys_name, hmc)
        sys.parse_raw_data(hmc_data.file_content(sys_name, 'lpar_info'))
        lpars.push(sys.getLparByName(lpar_to_find)) if sys.lpars_by_name.include?(lpar_to_find)
      end
    end

    puts '>DEBUG: checking if data from both HMCs are equal' if @verbose > 0
    # @TODO: create code to compare real data and profiles from all HMCs

    puts '>DEBUG: searching data from VIOSes' if @verbose > 0
    lpars.each_index do |index|
      lpar_id = lpars[index].lpar_id
      lpars[index].vioses.each do |vios|
        filename = "#{directory}/#{@vios_subdirectory}/#{@date}/#{vios}.#{vios_datafile_extension}"
        puts "VIOS filename #{filename}" if @verbose > 0
        next unless File.exist?(filename)
        data_file = DataFile.new(filename)
        npiv_all = Lsmap_npiv.new(data_file.find("/usr/ios/cli/ioscli lsmap -all -npiv"), vios)
        vhost_all = Lsmap.new(data_file.find("/usr/ios/cli/ioscli lsmap -all"), vios)

        puts 'Putting data from VIOSes about NPIV and vscsi' if @verbose > 0
        lpars[index].vscsi.merge!(vhost_all.mapping_for_lpar(lpar_id))
        lpars[index].npiv.merge!(npiv_all.mapping_for_lpar(lpar_id))
      end
    end

    lpars
  end

  def vios_data(lparname, command)
    path = Pathname.new("#{directory}/#{@vios_subdirectory}/#{@date}/#{lparname}.#{vios_datafile_extension}")
    path.cleanpath
    filename = path.realpath
    puts "data will be taken from file #{filename}" if @verbose > 0
    unless File.exist?(filename)
      puts "This file >#{filename}< doesn't exist! " if @verbose > 0
      return nil
    end
    data_file = DataFile.new(filename)
    data_file.find(command)
  end
end