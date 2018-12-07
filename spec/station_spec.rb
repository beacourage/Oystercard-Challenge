require 'station'

describe Station do

let(:zone) { double :zone}
let(:name) { double :name}

  it 'knows what zone the station is in' do
    station = Station.new(zone, name)
    expect(station.zone).to eq zone
  end

  it 'knows what name the station is' do
    station = Station.new(zone, name)
    expect(station.name).to eq name
  end

end
