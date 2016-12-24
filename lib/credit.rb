require './lib/person'

class Credit
  attr_reader :credit_name,
              :credit_limit,
              :interest,
              :credit_balance

  def initialize(credit_name)
    @credit_name = credit_name
    @credit_balance = 0
  end

  def open_credit(person, credit_limit, interest)
    @credit_limit = credit_limit
    @interest = interest
  end

  def cc_spend(person, amount)
    if amount <= @credit_limit
      @credit_balance += amount
      @credit_limit -= amount
    else
      "This operation exceeds the credit limit."
    end
  end

  def pay_down(person, amount)
    if amount <= person.cash
      @credit_balance -= amount
      @credit_limit += amount
    else
      "There isn't enough cash available for this operation."
    end
  end
end
