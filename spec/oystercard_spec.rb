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
end
