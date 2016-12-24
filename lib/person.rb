class Person
  attr_reader :name,
              :cash,
              :banks

  def initialize(name, cash)
    @name = name
    @cash = cash
    @banks = ""
    create_person
  end

  def create_person
    "#{name} has been created with #{cash} galleons."
  end

end

# he person class should store a person's cash level,
#which banks they have an account with, and their balances at each bank.
