# frozen_string_literal: true

require_relative '../lib/corrector'

input_files = []
Dir.foreach('./src') do |file_name|
  input_files << File.expand_path(file_name, './src') unless File.extname(file_name).empty?
end

existed_output_files = []
Dir.foreach('./output') do |file_name|
  existed_output_files << File.expand_path(file_name, './output') unless File.extname(file_name).empty?
end

existed_output_files.each do |output_file|
  File.delete(output_file) unless output_file.include?('.gitkeep')
end

corrector = Corrector.new

input_files.each do |input_file|
  output_file = File.expand_path(File.basename(input_file), './output')
  corrector.format_submissions(input_file, output_file)

  # delete input_file after correction
  File.delete(input_file)
end
