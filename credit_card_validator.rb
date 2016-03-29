# Simple class to encapsulate the validation of a single credit card number
class CreditCardValidation
  def initialize(card_number)
    @card_number = card_number
  end

  def is_valid
    luhn_validator(@card_number)
  end

  def category
    categorise(@card_number)
  end

  def to_s
    category = categorise(@card_number)
    valid = luhn_validator(@card_number) ? 'valid' : 'invalid'
    "#{category}: #{@card_number}\t(#{valid})"
  end

  private
  # Simple categorisation check for Amex card
  def amex_validator(card_number)
    prefix = card_number[0..1]
    card_number.length == 15 and (prefix == '34' or prefix == '37')
  end

  # Simple categorisation check for Discover card
  def discover_validator(card_number)
    card_number.length == 16 and card_number[0..3] == '6011'
  end

  # Simple categorisation check for Mastercard
  def mastercard_validator(card_number)
    prefix = Integer(card_number[0..1])
    card_number.length == 16 and prefix >= 51 and prefix <= 55
  end

  # Simple categorisation check for Visa card
  def visa_validator(card_number)
    (card_number.length == 13 or card_number.length == 16) and card_number[0] == '4'
  end

  # Luhn number validation, for checking complete validity of categorised cards
  def luhn_validator(card_number)
    total_number_string(double_every_second_digit(card_number)) % 10 == 0
  end

  # One half of the luhn validator: creates a string where every second digit
  # is a doubled in place.
  def double_every_second_digit(number_string)
    accumulator = ''
    input = number_string.reverse.split(//)
    input.each_with_index { |char, index|
      num = Integer(char)
      if index % 2 != 0
        num *= 2
      end
      accumulator += String(num)
    }
    accumulator
  end

  # Given a string of digits, accumulates a sum of each individual digit in the
  # string.
  def total_number_string(number_string)
    total = 0
    number_string.each_char { |c|
      total += Integer(c)
    }
    total
  end

  # Returns a card category label based on the first applicable validator
  # function.
  def categorise(card_number)
    if amex_validator(card_number)
      return 'AMEX'
    elsif discover_validator(card_number)
      return 'Discover'
    elsif mastercard_validator(card_number)
      return 'MasterCard'
    elsif visa_validator(card_number)
      return 'VISA'
    end
    'Unknown'
  end
end
