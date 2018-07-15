require 'pathname'
require 'yaml'


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

  def initialize(directory, date, config_file = nil)
    @directory = directory
    @date = date
    @verbose = $VERBOSE.nil? || $VERBOSE == false ? 0 : $VERBOSE


    if config_file.nil?
      @vios_datafile_extension = nil
      @hmc_directory = '/hmc'
      @vios_subdirectory = '/vios'
    else
      options = YAML.load_file(config_file)
      @vios_datafile_extension = options[:vios_datafile_extension]
      @hmc_directory = options[:hmc_subdirectory]
      @vios_subdirectory = options[:vios_subdirectory]
    end
  end

  def create_structure(base_dir)
    create_dir(base_dir)
    create_dir(base_dir + @hmc_directory)
    create_dir(base_dir + @hmc_directory + '/' + @date)
    create_dir(base_dir + @vios_directory)
    create_dir(base_dir + @vios_directory + '/' + @date)
  end

  def create_dr(dirname)
    if Dir.exist?(dirname)
      puts ">DEBUG: dirname exist: #{dirname}, ignoring..." if @verbose > 0
    else
      puts ">DEBUG: creating dirname: #{dirname}" if @verbose > 0
      Dir.mkdir(dirname)
    end
  end

  def search_frame(sys_to_find)
    systems = []

    puts ">DEBUG(1): searching data about frame #{sys_to_find}" if @verbose > 0
    hmc_dir_base = @directory + '/' + @hmc_directory + '/' + @date + '/'
    puts ">DEBUG(1): checking directory #{hmc_dir_base}" if @verbose > 0
    Dir.chdir(hmc_dir_base)
    Dir.glob('*').select do |hmc|
      puts "DEBUG(1): Checking HMC #{hmc} (dir: #{hmc_dir_base}/#{hmc}" if @verbose > 0
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

    puts ">DEBUG: verbose: #{@verbose}" if @verbose > 0
    puts '>DEBUG: searching data about frame on HMCs' if @verbose > 0

    hmc_dir_base = @directory + '/' + @hmc_directory + '/' + @date + '/'
    puts ">DEBUG: going to directory #{hmc_dir_base}" if @verbose > 0
    unless File.directory?(hmc_dir_base)
      puts ">DEBUG: Directory #{hmc_dir_base} doesn't exist!" if @verbose > 0
      return []
    end

    Dir.chdir(hmc_dir_base)
    Dir.glob('*').select do |hmc|
      puts ">DEBUG: Checking HMC #{hmc} and directory #{hmc_dir_base}/#{hmc} " if @verbose > 0
      unless File.directory? hmc
        puts ">DEBUG: Directory #{hmc} doesn't exist!" if @verbose > 0
        next
      end

      hmc_data = HmcDir.new(hmc_dir_base + hmc)
      hmc_data.verbose = @verbose
      hmc_data.create_list_of_frames

      hmc_data.sys.each do |sys_name|
        sys = System.new(sys_name, hmc)
        sys.parse_raw_data(hmc_data.file_content(sys_name, 'lpar_info'))
        lpars.push(sys.getLparByName(lpar_to_find)) if sys.lpars_by_name.include?(lpar_to_find)
      end
    end

    puts '>DEBUG: checking if data from both HMCs are equal (not implemented yet)' if @verbose > 0
    # @TODO: create code to compare real data and profiles from all HMCs

    puts '>DEBUG: searching data from VIOSes' if @verbose > 0
    lpars.each_index do |index|
      puts ">DEBUG:Possible VIOSes :" + lpars[index].vioses.sort.join(',') if @verbose > 0
      lpar_id = lpars[index].lpar_id
      lpars[index].vioses.each do |vios|
        filename = "#{directory}/#{@vios_subdirectory}/#{@date}/#{vios}.#{vios_datafile_extension}"
        puts ">DEBUG: VIOS #{vios} filename #{filename}" if @verbose > 0
        unless File.exist?(filename)
          puts "DEBUG: VIOS #{vios}, file doesn't exist! (is down? not accessible etc?)..."
          next
        end

        data_file = DataFile.new(filename)

        npiv_all = Lsmap_npiv.new(data_file.find("lsmap -all -npiv"), vios, lpars[index].sys)
        vhost_all = Lsmap.new(data_file.find("lsmap -all"), vios, lpars[index].sys)

        lpar_vscsi = vhost_all.mapping_for_lpar(lpar_id)
        lpar_npiv = npiv_all.mapping_for_lpar_id(lpar_id)

        puts ">DEBUG: Putting data from VIOSes about NPIV: #{lpar_npiv.count} vchosts" if @verbose > 0
        lpars[index].vscsi.concat(lpar_vscsi)
        puts ">DEBUG: Putting data from VIOSes about VSCSI: #{lpar_vscsi.count} vhosts" if @verbose > 0
        lpars[index].npiv.concat(lpar_npiv)
      end
    end

    lpars
  end

  def vios_data(lparname, command)
    path = Pathname.new("#{directory}/#{@vios_subdirectory}/#{@date}/#{lparname}.#{vios_datafile_extension}")
    path.cleanpath
    filename = path.realpath
    puts ">DEBUG: Data will be taken from file #{filename}" if @verbose > 0
    unless File.exist?(filename)
      puts ">DEBUG: This file >#{filename}< doesn't exist! " if @verbose > 0
      return nil
    end
    data_file = DataFile.new(filename)
    data_file.find(command)
  end
end