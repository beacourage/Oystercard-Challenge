require 'oystercard'

describe Oystercard do

 let(:entry_station) { double :station}
 let(:exit_station) { double :station}

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
      card.touchin(entry_station)
      expect(card).to be_in_journey
    end

    it "should throws an error if below minimum balance" do
      expect{ subject.touchin(entry_station) }.to raise_error("Unable to touch in due to balance")
    end

    # let(:station){ double :station }

    it "remembers the entry station after touchin" do
      card = Oystercard.new
      card.topup(2)
      card.touchin(entry_station)
      expect( card.entry_station ).to eq entry_station
    end
  end

  context "#touchout" do

    it "touch out method, marking card as no longer being in use" do
      card = Oystercard.new
      card.topup(2)
      card.touchin(entry_station)
      card.touchout(exit_station)
      expect(card).not_to be_in_journey
    end

    it "Deducts minimum balance (1) from card when touchout" do
      expect{ subject.touchout(exit_station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

    it "creates an exit station in order for it to be stored" do
      card = Oystercard.new
      card.topup(2)
      card.touchin(entry_station)
      card.touchout(exit_station)
      expect(card.exit_station).to eq exit_station
    end

    # it "records previous trips and displays them under previous_trips" do
    #   card = Oystercard.new
    #   expect{ card.touchout }.to change{@previous_trips}.by(entry_station)
    # end
  end
end
