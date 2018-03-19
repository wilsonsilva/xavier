class InstanceSingleton
  def initialize
    @mutated = false
  end

  def mutate
    @mutated = true
  end

  def mutated?
    @mutated
  end
end
