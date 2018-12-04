class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90


  def initialize
    @balance = 0
  end

  def topup(amount)
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    fail "Maximum balance of #{maximum_balance} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end

# maximum_balance = Oystercard::MAXIMUM_BALANCE
# Access a constant from outside the class
