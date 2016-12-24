require './lib/person'

class Bank
  attr_reader :bank_name,
              :funds,
              :total_cash

  def initialize(bank_name)
    @bank_name = bank_name
    @funds = 0
    @total_cash = 0
  end

  def create_bank
    "#{bank_name} has been created."
  end

  def open_account(person)
    person.banks << @bank_name
    "An account has been opened for #{person.name} with #{bank_name}."
  end

  def deposit(person, amount)
    if amount <= person.cash
      @funds += amount
      @total_cash += amount
      @balance = person.cash - amount
      "#{amount} galleons have been deposited into #{person.name}'s #{bank_name} account. Balance: #{amount} Cash: #{@balance}"
    else
      "#{person.name} does not have enough cash to perform this deposit."
    end
  end

  def withdrawal(person, amount)
    if amount <= @funds
      @funds -= amount
      @total_cash -= amount
      "#{person.name} has withdrawn #{amount} galleons. Balance: #{@funds}"
    else
      "Insufficient funds."
    end
  end

  def transfer(person, bank, amount)
    if person.banks.include?(bank.bank_name) == false
      "#{person.name} does not have an account with #{bank.bank_name}."
    elsif amount <= @funds
      @total_cash -= amount
      "#{person.name} has transferred #{amount} galleons from #{bank_name} to #{bank.bank_name}."
    else
      "Insufficient funds."
    end
  end

  def total_cash
    "Total Cash: #{@total_cash} galleons"
  end

end
