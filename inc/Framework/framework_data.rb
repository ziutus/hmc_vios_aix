require 'Framework/hmcDir'
require 'Framework/system'
require 'Framework/DataFile'

class FrameworkData

  attr_accessor :directory
  attr_accessor :date
  attr_accessor :verbose

  attr_accessor :vios_directory
  attr_accessor :hmc_directory

  def initialize(directory, date, verbose = 0)
    @directory = directory
    @date = date
    @verbose = verbose

    @hmc_directory = '/hmc'
    @vios_directory = '/vios'
  end

  def search_lpar(lpar_to_find, data_to_find = 'none')
    lpars = []

    puts '>DEBUG: searching data about frame on HMCs' if @verbose > 0
    Dir.chdir(@directory + '/' + @hmc_directory + '/' + @date + '/')
    Dir.glob('*').select do |hmc|
      puts ">DEBUG: Checking HMC #{hmc} " if @verbose > 0
      next unless File.directory? hmc

      hmc_data = HmcDir.new(directory + '/' + date + '/' + hmc)
      hmc_data.verbose = verbose
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
      lpar[index].vioses.each do |vios|
        filename = "#{directory}/#{@vios_directory}/#{@date}/#{vios}"
        next unless File.exist?(filename)
        data_file = DataFile.new(filename)
      end
    end

    lpars
  end
end