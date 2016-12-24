require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit'

class BankTest < Minitest::Test
  def test_it_has_a_class
    amex = Credit.new("AMEX")

    assert_instance_of Credit, amex
  end

  def test_it_has_a_name
    amex = Credit.new("AMEX")

    assert_equal "AMEX", amex.credit_name
  end

  def test_it_can_provide_credit
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 0)
    amex.open_credit(person1, 100, 0.05)

    assert_equal 100, amex.credit_limit
  end

  def test_it_has_an_interest
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 0)
    amex.open_credit(person1, 100, 0.05)

    assert_equal 0.05, amex.interest
  end

  def test_person_can_spend_until_limit
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 0)
    amex.open_credit(person1, 100, 0.05)
    amex.cc_spend(person1, 50)

    assert_equal 50, amex.credit_limit
  end

  def test_it_rejects_expense_when_exceeds_credit_limit
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 0)
    amex.open_credit(person1, 100, 0.05)
    amex.cc_spend(person1, 150)

    expected = "This operation exceeds the credit limit."
    assert_equal expected, amex.cc_spend(person1, 150)
  end

  def test_it_tracks_credit_balance
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 0)
    amex.open_credit(person1, 100, 0.05)
    amex.cc_spend(person1, 50)

    assert_equal 50, amex.credit_balance
  end

  def test_it_can_pay_down_credit_balance
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 200)
    amex.open_credit(person1, 100, 0.05)
    amex.cc_spend(person1, 50)
    amex.pay_down(person1, 50)

    assert_equal 0, amex.credit_balance
    assert_equal 100, amex.credit_limit
  end

  def test_only_cash_available_to_pay_down_credit_line
    amex = Credit.new("AMEX")
    person1 = Person.new("Minerva", 30)
    amex.open_credit(person1, 100, 0.05)
    amex.cc_spend(person1, 50)

    expected = "There isn't enough cash available for this operation."
    assert_equal expected, amex.pay_down(person1, 50)

    assert_equal 50, amex.credit_balance
    assert_equal 50, amex.credit_limit
  end
end
