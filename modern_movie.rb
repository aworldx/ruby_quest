class ModernMovie < Movie
  def initialize(options)
    @period = :modern
  end

  def to_s
    "#{@title} — современное кино: играют #{@actors}"
  end
end
