require 'oystercard'

describe Oystercard do

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
    error_message = "You're clearly too rich! #{subject.MAXIMUM_BALANCE} is the limmit"
    expect { subject.top_up(1) }.to raise_error(error_message)
  end

  it 'responds to touch_in' do
    expect(subject).to respond_to :touch_in
  end

  it 'touching in causes in_or_out to increase by 1' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.top_up(3)
    expect(subject.touch_in).to eq 1
  end

  it 'responds to touch_out' do
    expect(subject).to respond_to :touch_out
  end

  it 'touching out causes in_or_out to decrease by 1' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in
    expect(subject.touch_out).to eq 0
  end

  it 'responds to in_journey?' do
    expect(subject).to respond_to :in_journey?
  end

  it "it lets you know if you're on a journey" do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end

  it "it lets you know when you're not on a journey" do
    expect(subject.in_journey?).to eq false
  end

  it 'it raises an error if there is not enough money' do
    subject.top_up(Oystercard::MINIMUM_BALANCE - 0.01)
    expect { subject.touch_in }.to raise_error("You don't have enough money")
  end

  it 'touching out reduces balance by minimum fare' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in
    expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
  end
  
end
