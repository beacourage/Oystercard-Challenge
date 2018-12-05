class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90


  def initialize
    @balance = 0
    @cardstate = false
  end

  def topup(amount)
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    fail "Maximum balance of #{maximum_balance} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    # @cardstate
    @cardstate == true
  end

  def touchin
    if @cardstate == false
      @cardstate = true
    end
  end

  def  touchout
    if @cardstate == true
      @cardstate = false
    end
  end

end

# maximum_balance = Oystercard::MAXIMUM_BALANCE
# Access a constant from outside the class
# card state, is whether or not you are using your card.
