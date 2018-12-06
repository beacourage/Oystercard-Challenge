class Oystercard

  attr_reader :balance, :entry_station, :exit_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
  end

  def topup(amount)
    maximum_balance = MAXIMUM_BALANCE
    fail "Maximum balance of #{maximum_balance} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    if @entry_station == nil
      false
    else
      true
    end
  end

  def touchin(entry_station)
    @entry_station = entry_station
    fail "Unable to touch in due to balance" if @balance < MINIMUM_BALANCE
  end

  def touchout(exit_station)
    @exit_station = exit_station
    deduct
    @entry_station = nil
  end


  private

  def deduct
    @balance -= MINIMUM_BALANCE
  end

end


# replaced cardstate with entry entry_station


#cannot call deduct on its own because its private, can only call it within the context of touchout.

# maximum_balance = Oystercard::MAXIMUM_BALANCE
# Access a constant from outside the class
# card state, is whether or not you are using your card.
