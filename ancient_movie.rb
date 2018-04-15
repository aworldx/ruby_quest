module MyCinema
  class AncientMovie < Movie
    def initialize(options)
      super(options)
      @period = :ancient
    end

    def to_s
      "#{@title} — старый фильм (#{@year} год)"
    end
  end
end
