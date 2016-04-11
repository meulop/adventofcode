class Adventure
  def initialize(input_file)
    @input_file = input_file
    @options = {}
    @data = {}
    yield @options
  end

  attr_accessor :input_file, :data, :options
  

  def process_input
    File.open(@input_file).each do |line|
      yield line.chomp, @data
    end
  end

  def post_process
    yield @data
  end
end