class ClassSingleton
  def self.mutate
    @@mutated = true
    @mutated = true
  end

  def self.class_mutated?
    @mutated
  end

  def self.instance_mutated?
    @@mutated
  end

  def self.new
    @mutated = false
    @@mutated = false
    self
  end
end
