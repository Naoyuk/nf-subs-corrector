require 'csv'
require 'debug'

spark_0 = File.expand_path('nf-subs-1013.csv', './src')
spark_1 = File.expand_path('nf-subs-1015.csv', './src')
spark_2 = File.expand_path('nf-subs-1016.csv', './src')
spark_3 = File.expand_path('nf-subs-1017.csv', './src')
spark_4 = File.expand_path('nf-subs-1018.csv', './src')

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

def format_submissions(file_path)
  csv_data = CSV.read(file_path)

  csv_data.each do |row|
    next if row[0] == '#'

    row[2].capitalize
    row[3].capitalize
    row[4].capitalize

    row[5].downcase
    format_phone_number(row[6])
    words_capitalize(row[8])
    format_postal_code(row[9])

    row[14].capitalize
    row[15].capitalize
    row[16].capitalize
  end
  debugger
end

format_submissions(spark_0)
