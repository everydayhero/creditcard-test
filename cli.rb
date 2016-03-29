#!/usr/bin/ruby

require_relative 'credit_card_validator'

# Given a multi-line input of credit card numbers (with one card number per
# line), this function puts a corresponding validation string for each
def credit_card_validator(input)
  validations = []
  input.each_line do |line|
    card_number = line.gsub(/\s/, '')
    if card_number.length > 0
      validations.push CreditCardValidation.new card_number
    end
  end
  validations
end

#### Command Line Interface
input = ARGF.read
validations = credit_card_validator(input)
for validation in validations
  puts validation
end
