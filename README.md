# Calendar Program

By Joe Fiume  
[jfiume.github.io](http://https://github.com/jfiume)

## Instructions

1. Install Gemfile dependencies with "bundle install"
2. Use the command line to input the program name, input file and output file.
  * ex: "ruby lib/calendar.rb input_file.csv output_file.txt"
3. Run the RSpec tests with the command "bundle exec rspec"
4. Watch the tests pass
5. Enjoy!

## Discussion
* I used the following technologies: Ruby and Rspec.
* I used 2 instance variables to hold and update state. I used a hash for quick updating when a new input file is called. I convert the hash to a sorted nested array. I output the sorted nested array to the output file.

## Requirements
#### Build the Calendar
The Calendar takes 2 command line inputs: an input CSV file and an output Text file. The output text file is updated with the new state appended in the form of a nested array.

#### Tests
There are 10 test input files that generate 10 test output files. Each of these files is tested via RSpec and the output file is destroyed. The 10 test input files are located inside the "spec" folder. There are also RSpec tests for public instance methods.
