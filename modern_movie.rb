module MyCinema
  class ModernMovie < Movie
    def initialize(options)
      super(options)
      @period = :modern
    end

    def to_s
      "#{@title} — современное кино: играют #{@actors}"
    end
  end
end

