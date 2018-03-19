RSpec.describe Xavier::Mutator do
  let(:mutator)             { described_class.new }
  let(:class_observable)    { Class.new }
  let(:instance_observable) { Object.new }
  let(:class_copy)          { Xavier::MutationStrategies::ClassCopy }
  let(:instance_copy)       { Xavier::MutationStrategies::InstanceCopy }

  before do
    class_observable.class_variable_set(:@@name, 'wilson')
    class_observable.class_variable_set(:@@age, 1984)
    class_observable.instance_variable_set(:@name, 'wilson')
    class_observable.instance_variable_set(:@age, 1984)

    instance_observable.instance_variable_set(:@name, 'wilson')
    instance_observable.instance_variable_set(:@age, 1984)
  end

  describe '#create_state_from' do
    context 'when the observable is a class' do
      it 'returns the class state representation of the observable' do
        state = mutator.create_state_from(class_observable, strategies: [class_copy])

        aggregate_failures do
          expect(state.class_variable_get(:@@name)).to eq('wilson')
          expect(state.class_variable_get(:@@age)).to eq(1984)
        end
      end
    end

    context 'when the observable is an instance' do
      it 'returns the instance state representation of the observable' do
        state = mutator.create_state_from(instance_observable, strategies: [instance_copy])

        aggregate_failures do
          expect(state.instance_variable_get(:@name)).to eq('wilson')
          expect(state.instance_variable_get(:@age)).to eq(1984)
        end
      end
    end
  end

  describe '#apply_state' do
    let(:state) { Xavier::State.new(instance_observable.object_id) }

    it 'restores the state from a single strategy' do
      mutator.apply_state(from: instance_observable, to: state, strategies: [instance_copy])

      aggregate_failures do
        expect(state.instance_variable_get(:@name)).to eq('wilson')
        expect(state.instance_variable_get(:@age)).to eq(1984)
      end
    end

    it 'restores the class state from multiple mutation_strategies' do
      mutator.apply_state(from: class_observable, to: state, strategies: [instance_copy, class_copy])

      aggregate_failures do
        expect(state.class_variable_get(:@@name)).to eq('wilson')
        expect(state.class_variable_get(:@@age)).to eq(1984)
      end
    end

    it 'restores the instance state from multiple mutation_strategies' do
      mutator.apply_state(from: class_observable, to: state, strategies: [instance_copy, class_copy])

      aggregate_failures do
        expect(state.instance_variable_get(:@name)).to eq('wilson')
        expect(state.instance_variable_get(:@age)).to eq(1984)
      end
    end
  end

  describe '#mutation_strategies_for' do
    context 'when the observable is a class' do
      it 'returns class and instance mutation mutation_strategies' do
        mutation_strategies = mutator.mutation_strategies_for(class_observable)
        expect(mutation_strategies).to contain_exactly(instance_copy, class_copy)
      end
    end

    context 'when the observable is an instance' do
      it 'returns an instance mutation strategy' do
        mutation_strategies = mutator.mutation_strategies_for(instance_observable)
        expect(mutation_strategies).to contain_exactly(instance_copy)
      end
    end
  end
end
