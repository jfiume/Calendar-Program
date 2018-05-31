require 'byebug'

class Calendar

  def initialize(output_file)
    @output_file = output_file
    @state = []
    @state_hash = {}
  end

  def line_input(line)
    # strip out all input formatting and place in an array
    lines = line.strip.split(', ')
    # set a range of the interval
    range = [lines[1].to_i, lines[2].to_i]
    # if input is invalid we return [] to the output file
    return output unless valid_input?(range)

    if lines.first == "add"
      add(range)
    elsif lines.first == "remove"
      remove(range)
    end
  end

  def valid_input?(range)
    range.first < range.last
  end

  def all_true?(sorted_state)
    # does not check the last value as it should be false
    sorted_state[0...-1].each_index do |idx|
      return false unless sorted_state[idx].last
    end
    # returns true if the last value is false
    !sorted_state.last.last
  end

  def all_false?(sorted_state)
    # does not check the last value as it should be true
    sorted_state[0...-1].each_index do |idx|
      return false if sorted_state[idx].last
    end
    # returns true if the last value is false
    sorted_state.last.last
  end

  protected

  def add(range)
    (range.first..range.last - 1).each do |num|
      @state_hash[num] = true
    end
    # set the last number of the range to false unless its already been set
    # ex: add, 1, 5 results in the range 1 up to 5 but not including 5
    @state_hash[range.last] = false unless @state_hash[range.last]

    check_state
  end

  def remove(range)
    (range.first..range.last - 1).each do |num|
      next unless @state_hash[num]
      @state_hash[num] = false
    end
    # set the last number of the range to true if it was previously false
    # ex: remove, 4, 7 results in the range 4 up to 7 but not including 7
    @state_hash[range.last] = true if @state_hash[range.last]

    check_state
  end

  def check_state
    # reset state
    @state = []
    sorted_state = @state_hash.sort_by {|k, _| k}
    # empty state case
    return output if sorted_state.empty?
    # no disjoints case with all trues
    return all_true(sorted_state) if all_true?(sorted_state)
    # no disjoints case with all falses
    return all_false if all_false?(sorted_state)
    # filter the state
    filtered_state = filter_state(sorted_state)

    update_state(filtered_state)
  end

  def filter_state(sorted_state)
    true_false = sorted_state.first.last

    if true_false
      filtered_state = [sorted_state.first]
    else
      filtered_state = []
    end

    # finds where the disjoints occur and puts them into a new array
    sorted_state.each_index do |idx|
      if true_false != sorted_state[idx].last
        true_false = sorted_state[idx].last
        filtered_state << sorted_state[idx]
      end
    end

    # filtered_state must come in even pairs to update state correctly
    raise 'error, state not stable!' if filtered_state.size.odd?

    filtered_state
  end

  def update_state(filtered_state)
    idx = 0
    # updates state in array pairs
    while idx < filtered_state.length
      @state << [filtered_state[idx].first, filtered_state[idx + 1].first]
      idx += 2
    end

    output
  end

  def all_true(sorted_state)
    @state << [sorted_state.first.first, sorted_state.last.first]

    output
  end

  def all_false
    output
  end

  def output
    # creates and writes to the specified output file
    File.open(@output_file, "a") do |file|
      file << "#{@state}\n"
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # takes the inputs from the command line
  if ARGV.length != 2
      puts "We need exactly 2 parameters. The name of the input file and the output file."
      exit;
  end

  input_filename = ARGV[0]
  output_filename = ARGV[1]
  # check that we have a CSV input and TXT output
  if input_filename.split('.').last != "csv"
    puts '# WARNING: input file'
    puts '# Please use .csv input file'
  end

  calender = Calendar.new(output_filename)

  puts "Going to open '#{input_filename}'"
  fh = open input_filename
  # passes the contents line by line from the input file into #line_input
  fh.each do |line|
     calender.line_input(line)
  end
  # closes the input file when all process are complete
  fh.close
  puts "'#{output_filename}' now updated"
end
