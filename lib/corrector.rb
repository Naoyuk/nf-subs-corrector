# frozen_string_literal: true

require 'csv'

# CSVファイルの各カラムの値のフォーマットを整形するクラス
class Corrector
  def format_submissions(input_file, output_path)
    csv_data = CSV.read(input_file)

    CSV.open(output_path, 'wb') do |csv|
      csv_data.map do |row|
        next if row[0] == '#'

        csv << create_new_row(row)
      end
    end
  end

  def format_phone_number(phone_number)
    # 前後の余分な文字や数字をトリム
    phone_number = phone_number.to_s.gsub(/\A[^\d]*|[^-\d]*\z/, '')

    # 数字以外の文字を削除
    phone_number.gsub!(/\D/, '')

    # 数字部分が11桁かつ最初が1で始まる場合はトリム
    phone_number = phone_number[1..] if phone_number.match?(/^\d{11}$/) && phone_number.start_with?('1')

    # 長さが正しいか確認
    return nil unless phone_number.match?(/^\d{10}$/)

    "(#{phone_number[0, 3]}) #{phone_number[3, 3]}-#{phone_number[6, 4]}"
  end

  def words_capitalize(str)
    words = str.split
    converted_words = words.map(&:capitalize)
    converted_words.join(' ')
  end

  def format_postal_code(postal_code)
    # 大文字に変換し、非アルファベット文字を削除
    cleaned_postal_code = postal_code.upcase.gsub(/[^A-Z0-9]/, '')

    # フォーマットに統一
    "#{cleaned_postal_code[0, 3]} #{cleaned_postal_code[3, 3]}"
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
end
