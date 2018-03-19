RSpec.describe Xavier::MutationStrategies::ClassCopy do
  let(:mutation_strategy) { described_class }
  let(:observable)        { Class.new }
  let(:state)             { Xavier::State.new(0) }

  describe '.copy' do
    before do
      observable.class_variable_set(:@@name, 'wilson')
      observable.class_variable_set(:@@age, 1984)

      state.class_variable_set(:@@name, 'wilson')
      state.class_variable_set(:@@age, 1984)
    end

    it 'copies all class variables from an object to a state representation' do
      mutation_strategy.copy(from: observable, to: state)

      aggregate_failures do
        expect(state.class_variable_get(:@@name)).to eq('wilson')
        expect(state.class_variable_get(:@@age)).to eq(1984)
      end
    end

    it 'copies all class variables from a state representation to an object' do
      mutation_strategy.copy(from: state, to: observable)

      aggregate_failures do
        expect(observable.class_variable_get(:@@name)).to eq('wilson')
        expect(observable.class_variable_get(:@@age)).to eq(1984)
      end
    end
  end
end
