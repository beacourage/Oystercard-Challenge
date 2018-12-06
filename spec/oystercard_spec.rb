require 'oystercard'

describe Oystercard do

 let(:station){ double :station }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'responding to topup method' do
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

  it 'is not in journey initialy' do
    card = Oystercard.new
    expect(card).not_to be_in_journey
  end

  context "#touchin" do

    it "touch in method- marking the card as being in use" do
      card = Oystercard.new
      card.topup(3)
      card.touchin(station)
      expect(card).to be_in_journey
    end

    it "should throws an error if below minimum balance" do
      expect{ subject.touchin(station) }.to raise_error("Unable to touch in due to balance")
    end

    # let(:station){ double :station }

    it "remembers the entry station after touchin" do
      card = Oystercard.new
      card.topup(2)
      card.touchin(station)
      expect( card.entry_station ).to eq station
    end
  end

  context "#touchout" do

    it "touch out method, marking card as no longer being in use" do
      card = Oystercard.new
      card.topup(2)
      card.touchin(station)
      card.touchout
      expect(card).not_to be_in_journey
    end

    it "Deducts minimum balance (1) from card when touchout" do
      expect{ subject.touchout }.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end
end
