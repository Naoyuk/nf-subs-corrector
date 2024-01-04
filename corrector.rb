require 'csv'
require 'debug'

input_0 = File.expand_path('nf-subs-1013.csv', './src')
input_1 = File.expand_path('nf-subs-1015.csv', './src')
input_2 = File.expand_path('nf-subs-1016.csv', './src')
input_3 = File.expand_path('nf-subs-1017.csv', './src')
input_4 = File.expand_path('nf-subs-1018.csv', './src')

output_0 = File.expand_path('nf-subs-1013.csv', './output')
output_1 = File.expand_path('nf-subs-1015.csv', './output')
output_2 = File.expand_path('nf-subs-1016.csv', './output')
output_3 = File.expand_path('nf-subs-1017.csv', './output')
output_4 = File.expand_path('nf-subs-1018.csv', './output')

def format_phone_number(phone_number)
  # 前後の余分な文字や数字をトリム
  phone_number = phone_number.to_s.gsub(/\A[^\d]*|[^-\d]*\z/, '')

  # 数字以外の文字を削除
  phone_number.gsub!(/\D/, '')

  # 数字部分が11桁かつ最初が1で始まる場合はトリム
  if phone_number.match?(/^\d{11}$/) && phone_number.start_with?('1')
    phone_number = phone_number[1..-1]
  end

  # 長さが正しいか確認
  return nil unless phone_number.match?(/^\d{10}$/)

  "(#{phone_number[0, 3]}) #{phone_number[3, 3]}-#{phone_number[6, 4]}"
end

def words_capitalize(str)
  words = str.split
  converted_words = words.map do |word|
    word.capitalize
  end
  converted_words.join(' ')
end

def format_postal_code(postal_code)
  # 大文字に変換し、非アルファベット文字を削除
  cleaned_postal_code = postal_code.upcase.gsub(/[^A-Z0-9]/, '')

  # フォーマットに統一
  formatted_postal_code = "#{cleaned_postal_code[0, 3]} #{cleaned_postal_code[3, 3]}"
  formatted_postal_code
end

def create_new_row(row)
  new_row = []
  new_row << words_capitalize(row[2])
  new_row << words_capitalize(row[3])
  new_row << words_capitalize(row[4])

  new_row << row[5].downcase
  new_row << format_phone_number(row[6])
  new_row << words_capitalize(row[8])
  new_row << format_postal_code(row[9])

  new_row << words_capitalize(row[14])
  new_row << words_capitalize(row[15])
  new_row << words_capitalize(row[16])
  new_row
end

def format_submissions(input_file, output_path)
  csv_data = CSV.read(input_file)

  CSV.open(output_path, 'wb') do |csv|
    csv_data.map do |row|
      next if row[0] == '#'
      csv << create_new_row(row)
    end
  end
end

format_submissions(input_0, output_0)
format_submissions(input_1, output_1)
format_submissions(input_2, output_2)
format_submissions(input_3, output_3)
format_submissions(input_4, output_4)
