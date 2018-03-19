RSpec.describe Xavier::MutationStrategies::InstanceCopy do
  let(:mutation_strategy) { described_class }
  let(:observable)        { Object.new }
  let(:state)             { Xavier::State.new(0) }

  describe '.copy' do
    before do
      observable.instance_variable_set(:@name, 'wilson')
      observable.instance_variable_set(:@age, 1984)

      state.instance_variable_set(:@name, 'wilson')
      state.instance_variable_set(:@age, 1984)
    end

    it 'copies all instance variables from an object to a state representation' do
      mutation_strategy.copy(from: observable, to: state)

      aggregate_failures do
        expect(state.instance_variable_get(:@name)).to eq('wilson')
        expect(state.instance_variable_get(:@age)).to eq(1984)
      end
    end

    it 'copies all instance variables from a state representation to an object' do
      mutation_strategy.copy(from: state, to: observable)

      aggregate_failures do
        expect(observable.instance_variable_get(:@name)).to eq('wilson')
        expect(observable.instance_variable_get(:@age)).to eq(1984)
      end
    end
  end
end
