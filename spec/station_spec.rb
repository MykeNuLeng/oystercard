require 'station'
describe Station do
  it 'on creating the station, it has a zone' do
    expect(subject.zone).not_to eq nil
  end

  it 'on initialising it has a name' do
    expect(subject.name).not_to eq nil
  end
end
