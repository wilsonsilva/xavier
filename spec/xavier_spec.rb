require_relative 'support/class_singleton'
require_relative 'support/instance_singleton'

RSpec.describe Xavier do
  describe '.observe' do
    let(:instance_singleton) { InstanceSingleton.new }
    let(:class_singleton)    { ClassSingleton.new }

    context 'when no block is given' do
      it 'raises an error' do
        expect { described_class.observe(instance_singleton) }.to raise_error(ArgumentError)
      end
    end

    context 'when observing a class' do
      it 'reverts the instance variables' do
        described_class.observe(class_singleton) { class_singleton.mutate }

        expect(class_singleton).not_to be_class_mutated
      end

      it 'reverts the class variables' do
        described_class.observe(class_singleton) { class_singleton.mutate }

        expect(class_singleton).not_to be_instance_mutated
      end
    end

    context 'when observing an instance' do
      it 'reverts the instance variables' do
        described_class.observe(instance_singleton) { instance_singleton.mutate }

        expect(instance_singleton).not_to be_mutated
      end
    end

    context 'when an object is already being observed' do
      it 'raises an error' do
        expect do
          described_class.observe(instance_singleton) do
            described_class.observe(instance_singleton) { instance_singleton.mutate }
          end
        end.to raise_error(Xavier::AlreadyObserved)
      end
    end
  end
end
