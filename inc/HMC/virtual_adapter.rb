class VirtualAdapter

  attr_accessor :virtualSlotNumber
  attr_accessor :isRequired

  # below data can be taken only from lshwres, they are exist only for running lpars
  attr_accessor :lpar_name
  attr_accessor :lpar_id
  attr_accessor :state

  # type of input / output (data can be taken from profile or real setup (lshwres...))
  attr_reader :_type

  def initialize(string = '')
    @lpar_name = nil
    @lpar_id = nil
    @state = nil
    @_type = 'profile'
    @params = []
  end

  def diff(other_adapter, profile1, profile2)
    diff = {}

    if self.class.name != other_adapter.class.name
      raise "Wrong type of adapter has been compared #{other_adapter.class.name}"
    end

    @params.sort.each do |param|
      next if  instance_variable_get("@#{param}") == other_adapter.instance_variable_get("@#{param}")

      diff_entry = {}
      diff_entry[profile2] = other_adapter.instance_variable_get("@#{param}")
      diff_entry[profile1]  = instance_variable_get("@#{param}")
      diff[param.to_s] = diff_entry
    end

    diff
  end

  def ==(other)
    to_s == other.to_s
  end

end