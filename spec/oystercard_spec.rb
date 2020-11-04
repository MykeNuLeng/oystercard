require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  it 'can have a balance' do
    expect(subject.balance).to eq 0
  end

  it 'responds to top up' do
    expect(subject).to respond_to :top_up
  end

  it 'top_up method adds to balance' do
    expect(subject.top_up(10)).to eq 10
  end

  it 'raises an error when balance goes above 90' do
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error(Oystercard::MAXIMUM_ERROR)
  end

  it 'responds to touch_in' do
    expect(subject).to respond_to :touch_in
  end

  it 'responds to touch_out' do
    expect(subject).to respond_to :touch_out
  end

  it 'touching out removes entry_station' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    expect(subject.touch_out(station)).to eq 0
  end

  it 'responds to in_journey?' do
    expect(subject).to respond_to :in_journey?
  end

  it "it lets you know if you're on a journey" do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    expect(subject.in_journey?).to eq true
  end

  it "it lets you know when you're not on a journey" do
    expect(subject.in_journey?).to eq false
  end

  it 'it raises an error if there is not enough money' do
    subject.top_up(Oystercard::MINIMUM_BALANCE - 0.01)
    expect { subject.touch_in(station) }.to raise_error(Oystercard::MINIMUM_ERROR)
  end

  it 'touching out reduces balance by minimum fare' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
  end

  it 'starting a journey is stored in journey log' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    expect { subject.touch_in(station) }.to change { subject.journey_log.journeys.length }.by 1
  end

  it 'by default the journey log is empty' do
    expect(subject.journey_log.journeys).to be_empty
  end
end
