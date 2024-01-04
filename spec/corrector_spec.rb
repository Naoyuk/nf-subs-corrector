# frozen_string_literal: true

require_relative '../lib/corrector'

RSpec.describe Corrector do
  describe '#format_phone_number' do
    it 'returns formatted phone number' do
      phone_numbers = [
        '12223334444',
        '1 222 333 4444',
        '1-222 333 4444',
        '1 222-333 4444',
        '1 222 333-4444',
        '1-222 333-4444',
        '1-222-333-4444',
        '1(222)333-4444',
        '1(222)333 4444',
        '1(222) 333 4444',
        '1(222)-333 4444',
        '+12223334444',
        '+1 222 333 4444',
        '+1-222-333-4444',
        '+1(222)333-4444',
        '+1(222)333 4444',
        '(222)333 4444',
        '222-333-4444',
        '222 333-4444',
        '222-333 4444',
        '222 333 4444'
      ]

      corrector = Corrector.new
      phone_numbers.each do |phone_number|
        expect(corrector.format_phone_number(phone_number)).to eq '(222) 333-4444'
      end
    end
  end

  describe '#words_capitalize' do
    it 'returns capitalized word for each' do
      word1 = 'aaa'
      word2 = 'Aaa'
      word3 = 'aAA'
      word4 = 'aAa'
      word5 = 'aAa bbb'
      word6 = 'aAa bBb'
      word7 = 'aAa BBb ccc'

      corrector = Corrector.new
      expect(corrector.words_capitalize(word1)).to eq 'Aaa'
      expect(corrector.words_capitalize(word2)).to eq 'Aaa'
      expect(corrector.words_capitalize(word3)).to eq 'Aaa'
      expect(corrector.words_capitalize(word4)).to eq 'Aaa'
      expect(corrector.words_capitalize(word5)).to eq 'Aaa Bbb'
      expect(corrector.words_capitalize(word6)).to eq 'Aaa Bbb'
      expect(corrector.words_capitalize(word7)).to eq 'Aaa Bbb Ccc'
    end
  end

  describe '#format_postal_code' do
    it 'returns formatted postal code' do
      postal_codes = [
        'a1b 2c3',
        'A1b 2C3',
        'A1b-2C3',
        'a1b2c3',
        'a1B2c3'
      ]

      corrector = Corrector.new
      postal_codes.each do |postal_code|
        expect(corrector.format_postal_code(postal_code)).to eq 'A1B 2C3'
      end
    end
  end

  describe '#create_new_row' do

  end

  describe '#format_submissions' do

  end
end

