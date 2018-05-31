require 'rspec'
require 'calendar'

describe Calendar do
  subject(:calender) do
    test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
    if File.exists?(test_output_file)
      File.delete(test_output_file)
    end
    calender = Calendar.new(test_output_file)
  end

  describe '#valid_input?' do
    it 'should return true when the input range is valid' do
      expect(calender.valid_input?([10, 20])).to eq(true)
    end
    it 'should return false when the input range is invalid' do
      expect(calender.valid_input?([20, 10])).to eq(false)
    end
  end

  describe '#all_true?' do
    it 'should return true when all input values are true except that last one' do
      expect(calender.all_true?([[1, true], [2, true], [3, true], [4, false]])).to eq(true)
    end
    it 'should return false for all other inputs' do
      expect(calender.all_true?([[1, false], [2, true]])).to eq(false)
      expect(calender.all_true?([[1, false], [2, false]])).to eq(false)
      expect(calender.all_true?([[1, true], [2, false], [3, true]])).to eq(false)
    end
  end

  describe '#all_false?' do
    it 'should return true when all input values are false except that last one' do
      expect(calender.all_false?([[1, false], [2, false], [3, false], [4, true]])).to eq(true)
    end
    it 'should return false for all other inputs' do
      expect(calender.all_false?([[1, true], [2, true]])).to eq(false)
      expect(calender.all_false?([[1, false], [2, false]])).to eq(false)
      expect(calender.all_false?([[1, false], [2, true], [3, false]])).to eq(false)
    end
  end

  describe 'test input file 1' do
    it 'should add and remove ranges' do
      ANSWER_1 = [
        '[[1, 200]]',
        '[[1, 50], [100, 200]]'
      ]
      test_input_file_1 = File.readlines(File.expand_path '../test_input_file_1.csv', __FILE__)
      test_input_file_1.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_1[idx])
      end
    end
  end

  describe 'test input file 2' do
    it 'should not remove from an emtpy state' do
      ANSWER_2 = [
        '[]'
      ]
      test_input_file_2 = File.readlines(File.expand_path '../test_input_file_2.csv', __FILE__)
      test_input_file_2.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_2[idx])
      end
    end
  end

  describe 'test input file 3' do
    it 'should work with large ranges' do
      ANSWER_3 = [
        '[[1000, 1000000]]'
      ]
      test_input_file_3 = File.readlines(File.expand_path '../test_input_file_3.csv', __FILE__)
      test_input_file_3.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_3[idx])
      end
    end
  end

  describe 'test input file 4' do
    it 'should add and remove multiple ranges' do
      ANSWER_4 = [
        '[[15, 30]]',
        '[[15, 20], [25, 30]]',
        '[[15, 20], [25, 30], [40, 50]]',
        '[[15, 16], [19, 20], [25, 30], [40, 50]]',
        '[[1, 5], [15, 16], [19, 20], [25, 30], [40, 50]]'
      ]
      test_input_file_4 = File.readlines(File.expand_path '../test_input_file_4.csv', __FILE__)
      test_input_file_4.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_4[idx])
      end
    end
  end

  describe 'test input file 5' do
    it 'should not remove out of bounds ranges' do
      ANSWER_5 = [
        '[[1000, 1000000]]',
        '[[1000, 1000000]]'
      ]
      test_input_file_5 = File.readlines(File.expand_path '../test_input_file_5.csv', __FILE__)
      test_input_file_5.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_5[idx])
      end
    end
  end

  describe 'test input file 6' do
    it 'should not add invalid ranges' do
      ANSWER_6 = [
        '[]',
        '[]'
      ]
      test_input_file_6 = File.readlines(File.expand_path '../test_input_file_6.csv', __FILE__)
      test_input_file_6.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_6[idx])
      end
    end
  end

  describe 'test input file 7' do
    it 'should not remove invalid ranges' do
      ANSWER_7 = [
        '[]',
        '[]'
      ]
      test_input_file_7 = File.readlines(File.expand_path '../test_input_file_7.csv', __FILE__)
      test_input_file_7.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_7[idx])
      end
    end
  end

  describe 'test input file 8' do
    it 'should not add or remove invalid ranges' do
      ANSWER_8 = [
        '[[10, 20]]',
        '[[10, 20]]',
        '[[10, 20]]'
      ]
      test_input_file_8 = File.readlines(File.expand_path '../test_input_file_8.csv', __FILE__)
      test_input_file_8.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_8[idx])
      end
    end
  end

  describe 'test input file 9' do
    it 'should not add or remove invalid ranges' do
      ANSWER_9 = [
        '[[5, 20]]',
        '[[10, 20]]',
        '[[10, 15]]',
        '[[1, 15]]',
        '[[1, 10]]',
        '[[1, 10], [15, 30]]',
        '[[1, 30]]',
        '[[1, 20]]',
        '[[1, 20], [30, 40]]',
        '[[1, 10], [30, 40]]',
        '[[1, 10], [20, 40]]',
        '[[1, 10], [20, 50]]',
        '[[1, 10], [20, 30], [40, 50]]',
        '[[1, 10], [20, 30], [40, 50], [60, 70]]',
        '[[1, 10], [20, 30], [40, 70]]',
        '[[1, 10], [20, 30], [40, 60]]',
        '[[1, 10], [20, 30], [40, 60], [80, 90]]',
        '[[1, 10], [20, 30], [40, 60], [70, 90]]',
        '[[1, 10], [20, 30], [40, 50]]',
        '[[1, 50]]'
      ]
      test_input_file_9 = File.readlines(File.expand_path '../test_input_file_9.csv', __FILE__)
      test_input_file_9.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_9[idx])
      end
    end
  end

  describe 'test input file 10' do
    it 'should work for all ranges' do
      ANSWER_10 = [
        '[[1, 5]]',
        '[[1, 2], [3, 5]]',
        '[[1, 2], [3, 5], [6, 8]]',
        '[[1, 2], [3, 4], [7, 8]]',
        '[[1, 8]]'
      ]
      test_input_file_10 = File.readlines(File.expand_path '../test_input_file_10.csv', __FILE__)
      test_input_file_10.each do |line|
        calender.line_input(line)
      end
      test_output_file = File.expand_path('../../test_output_file.txt', __FILE__)
      output_file = File.readlines(test_output_file)
      File.delete(test_output_file)
      output_file.each_with_index do |line, idx|
        expect(line.strip.to_s).to eq(ANSWER_10[idx])
      end
    end
  end
end
