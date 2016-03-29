#!/usr/bin/ruby

require_relative 'credit_card_validator'

#### Command Line Interface
input = ARGF.read
validations = credit_card_validator(input)
validations.each do | validation |
  puts validation
end
