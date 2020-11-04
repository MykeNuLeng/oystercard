require 'journey'
describe Journey do
  context 'given an entry_station' do
    subject { described_class.new(entry_station: station) }
    let(:station) { double :station }

    it 'it knows if it is finished or not' do
      expect(subject).not_to be_finished
    end

    it 'when initialized its passed a station' do
      expect(subject.entry_station).to eq(entry_station: station)
    end

    it 'responds to fare' do
      expect(subject).to respond_to :fare
    end

    it 'if the journey isnt finished and fare is called, a penalty fare is issued' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'responds to finish' do
      expect(subject).to respond_to :finish
    end

    it 'after finish it is finished' do
      subject.finish(station)
      expect(subject.finished?).to eq true
    end

    it 'after finish, fare returns STANDARD_FARE' do
      subject.finish(station)
      expect(subject.fare).to eq Journey::STANDARD_FARE
    end

    it 'returns itself after finish is called' do
      expect(subject.finish(station)).to eq subject
    end 
  end
end
