require 'xavier/states'

RSpec.describe Xavier::States do
  let(:states) { described_class.new }
  let(:state)  { Xavier::State.new(0) }

  describe '#add' do
    it 'adds a state to the collection' do
      states.add(state)
      expect(states.contain?(state.observed_object_id)).to eq(true)
    end

    it 'returns self' do
      returned_value = states.add(state)
      expect(returned_value).to eq(states)
    end
  end

  describe '#remove' do
    before { states.add(state) }

    it 'removes a state from the collection' do
      states.remove(state)
      expect(states.contain?(state.observed_object_id)).to eq(false)
    end
  end

  describe '#contain?' do
    context 'when the state is contained within the collection' do
      it 'returns true' do
        states.add(state)
        expect(states.contain?(state.observed_object_id)).to eq(true)
      end
    end

    context 'when the state is not contained within the collection' do
      it 'returns false' do
        expect(states.contain?(404)).to eq(false)
      end
    end
  end
end
