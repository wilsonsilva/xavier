require 'xavier/state'

RSpec.describe Xavier::State do
  let(:observed_object_id) { 0 }
  let(:state) { described_class.new(observed_object_id) }

  describe '#instance_variable_set' do
    it 'stores an instance variable' do
      state.instance_variable_set('@age', 27)
      expect(state.instance_variable_get('@age')).to eq(27)
    end
  end

  describe '#instance_variable_get' do
    before { state.instance_variable_set('@age', 27) }

    it 'retrieves an instance variable' do
      expect(state.instance_variable_get('@age')).to eq(27)
    end
  end

  describe '#class_variable_set' do
    it 'stores a class variable' do
      state.class_variable_set('@@age', 27)
      expect(state.class_variable_get('@@age')).to eq(27)
    end
  end

  describe '#class_variable_get' do
    before { state.class_variable_set('@age', 27) }

    it 'retrieves a class variable' do
      expect(state.class_variable_get('@age')).to eq(27)
    end
  end

  describe '#is_a?' do
    context 'when comparing with Class' do
      it 'returns true' do
        expect(state.is_a?(Class)).to eq(true)
      end
    end

    context 'when comparing with Xavier::State' do
      it 'returns true' do
        expect(state.is_a?(described_class)).to eq(true)
      end
    end

    context 'when comparing with other class' do
      it 'returns false' do
        expect(state.is_a?(Xavier)).to eq(false)
      end
    end
  end

  describe '#class' do
    it 'returns the object class' do
      expect(state.class).to eq(described_class)
    end
  end

  describe '#instance_variables' do
    before { state.instance_variable_set('@age', 27) }

    it 'retrieves the names of instance variables' do
      expect(state.instance_variables).to contain_exactly(:@age)
    end
  end

  describe '#class_variables' do
    before { state.class_variable_set('@@age', 27) }

    it 'retrieves the names of class variables' do
      expect(state.class_variables).to contain_exactly(:@@age)
    end
  end

  describe '#observed_object_id' do
    it 'returns the object id of the cloned object' do
      expect(state.observed_object_id).to eq(observed_object_id)
    end
  end
end
