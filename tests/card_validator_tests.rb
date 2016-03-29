require_relative '../credit_card_validator'
require 'test/unit'

class TestCreditCardValidator < Test::Unit::TestCase
  def test_valid_visa
    validation = CreditCardValidation.new '4111111111111111'
    assert_equal("VISA: 4111111111111111\t(valid)", String(validation))
  end

  def test_invalid_visa
    validation = CreditCardValidation.new '4111111111111'
    assert_equal("VISA: 4111111111111\t(invalid)", String(validation))
  end

  def test_valid_mastercard
    validation = CreditCardValidation.new '5105105105105100'
    assert_equal("MasterCard: 5105105105105100\t(valid)", String(validation))
  end

  def test_invalid_mastercard
    validation = CreditCardValidation.new '5105105105105106'
    assert_equal("MasterCard: 5105105105105106\t(invalid)", String(validation))
  end

  def test_valid_discover
    validation = CreditCardValidation.new '6011111111111117'
    assert_equal("Discover: 6011111111111117\t(valid)", String(validation))
  end

  def test_invalid_discover
    validation = CreditCardValidation.new '6011111111111115'
    assert_equal("Discover: 6011111111111115\t(invalid)", String(validation))
  end

  def test_valid_amex
    validation = CreditCardValidation.new '378282246310005'
    assert_equal("AMEX: 378282246310005\t(valid)", String(validation))
  end

  def test_invalid_amex
    validation = CreditCardValidation.new '378282246310003'
    assert_equal("AMEX: 378282246310003\t(invalid)", String(validation))
  end

  def test_unknown_card
    validation = CreditCardValidation.new '9111111111111111'
    assert_equal("Unknown: 9111111111111111\t(invalid)", String(validation))
  end

  def test_ignores_spacing
    validation = CreditCardValidation.new '5105 1051 0510 5100      '
    assert_equal("MasterCard: 5105105105105100\t(valid)", String(validation))
  end

  def test_multiline_input
    input = %q(
      4111111111111111
    4111111111111
    4012888888881881
    378282246310005
    6011111111111117
    5105105105105100
    5105 1051 0510 5106
    9111111111111111
    )
    expected_output = [
      "VISA: 4111111111111111\t(valid)",
      "VISA: 4111111111111\t(invalid)",
      "VISA: 4012888888881881\t(valid)",
      "AMEX: 378282246310005\t(valid)",
      "Discover: 6011111111111117\t(valid)",
      "MasterCard: 5105105105105100\t(valid)",
      "MasterCard: 5105105105105106\t(invalid)",
      "Unknown: 9111111111111111\t(invalid)"
    ]
    assert_equal(expected_output, credit_card_validator(input))
  end

end
