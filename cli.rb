#!/usr/bin/ruby

require './credit_card_validator'

#### Command Line Interface
input = ARGF.read
credit_card_validator(input)
