require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'

class BankTest < Minitest::Test
  def test_it_has_a_class
    chase = Bank.new("JP Morgan Chase")
    assert_instance_of Bank, chase
  end

  def test_it_has_a_name
    chase = Bank.new("JP Morgan Chase")
    assert_equal "JP Morgan Chase", chase.bank_name
  end

  def test_it_can_have_a_different_name
    wells_fargo = Bank.new("Wells Fargo")
    assert_equal "Wells Fargo", wells_fargo.bank_name
  end

  def test_it_displays_bank_creation_message
    chase = Bank.new("JP Morgan Chase")
    expected = "JP Morgan Chase has been created."
    assert_equal expected, chase.create_bank
  end

  def test_it_displays_another_bank_creation_message
    wells_fargo = Bank.new("Wells Fargo")
    expected = "Wells Fargo has been created."
    assert_equal expected, wells_fargo.create_bank
  end

  def test_it_can_create_person_account
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")

    expected = "An account has been opened for Minerva with JP Morgan Chase."
    assert_equal expected, chase.open_account(person1)
  end

  def test_it_can_create_another_person_account
    person2 = Person.new("Luna", 500)
    wells_fargo = Bank.new("Wells Fargo")

    expected = "An account has been opened for Luna with Wells Fargo."
    assert_equal expected, wells_fargo.open_account(person2)
  end

  def test_funds_starts_at_zero
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    assert_equal 0, chase.funds
  end

  def test_total_cash_starts_at_zero
    chase = Bank.new("Chase")
    assert_equal "Total Cash: 0 galleons", chase.total_cash
  end

  def test_it_accepts_deposits
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)

    expected = "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"
    assert_equal expected, chase.deposit(person1, 750)
  end

  def test_it_rejects_transfers_more_than_available_cash
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)

    expected = "Minerva does not have enough cash to perform this deposit."
    assert_equal expected, chase.deposit(person1, 5000)
  end

  def test_it_can_withdrawal_money
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    chase.deposit(person1, 500)

    expected = "Minerva has withdrawn 250 galleons. Balance: 250"
    assert_equal expected, chase.withdrawal(person1, 250)
  end

  def test_it_can_withdrawal_money_when_less_than_balance
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("Chase")
    chase.open_account(person1)
    chase.deposit(person1, 500)

    assert_equal "Insufficient funds.", chase.withdrawal(person1, 25000)
  end

  def test_it_can_transfer_money
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    chase.open_account(person1)
    wells_fargo.open_account(person1)
    chase.deposit(person1, 500)

    expected = "Minerva has transferred 250 galleons from JP Morgan Chase to Wells Fargo."
    assert_equal expected, chase.transfer(person1, wells_fargo, 250)
  end

  def test_it_can_only_transfer_money_available_in_bank
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    chase.open_account(person1)
    wells_fargo.open_account(person1)
    chase.deposit(person1, 500)

    expected = "Insufficient funds."
    assert_equal expected, chase.transfer(person1, wells_fargo, 2000)
  end

  def test_it_rejects_transfer_to_bank_where_not_client
    person2 = Person.new("Luna", 500)
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    chase.open_account(person2)
    chase.deposit(person2, 500)

    expected = "Luna does not have an account with Wells Fargo."
    assert_equal expected, chase.transfer(person2, wells_fargo, 250)
  end

  def test_total_cash_in_bank
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Luna", 500)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.open_account(person2)
    chase.deposit(person1, 500)
    chase.deposit(person2, 250)

    assert_equal "Total Cash: 750 galleons", chase.total_cash
  end
end
