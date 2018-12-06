class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @cardstate = false
  end

  def topup(amount)
    maximum_balance = MAXIMUM_BALANCE
    fail "Maximum balance of #{maximum_balance} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  # def in_journey?
  #   @cardstate == true
  # end

  def touchin
    fail "Unable to touch in due to balance" if @balance < MINIMUM_BALANCE
    @cardstate = true
  end

  def touchout
      deduct
      @cardstate = false
  end

  private

  def deduct
    @balance -= MINIMUM_BALANCE
  end

end

#cannot call deduct on its own because its private, can only call it within the context of touchout.

# maximum_balance = Oystercard::MAXIMUM_BALANCE
# Access a constant from outside the class
# card state, is whether or not you are using your card.
