require 'journey'
describe Journey do
  context 'given an entry_station' do
    subject { described_class.new(entry_station: station) }
    let(:station) { double :station, zone: 1 }
    let(:station1) { double :station, zone: 1 }
    let(:station5) { double :station, zone: 5 }

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

    it 'returns itself after finish is called' do
      expect(subject.finish(station1)).to eq subject
    end

    it 'calculates a fare that isnt allways 1' do
      a = Journey.new(station1, station5)
      expect(a.fare).to eq 5
    end
  end
end
