require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'respinding to topup method' do
    it { is_expected.to respond_to(:topup).with(1).argument }
  end

  it 'adding money to the card, topping up balance' do
   expect{ subject.topup(1)}.to change{ subject.balance }.by(1)
 end

 it 'want maximum card limit, raises an error if the maximum balance is exceeded' do
   maximum_balance = Oystercard::MAXIMUM_BALANCE
   card = Oystercard.new
   card.topup(maximum_balance)
   expect{card.topup(1)}.to raise_error "Maximum balance of #{maximum_balance} exceeded"
 end


  it { is_expected.to respond_to(:deduct).with(1).argument }

  it 'fair deducted from my card' do
    card = Oystercard.new
    card.topup(20)
    expect{ card.deduct(1)}.to change{ card.balance }.by (-1)
  end
end
