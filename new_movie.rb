require 'byebug'

class NewMovie < Movie
  def initialize(options)
    super
    @years_from_production = Time.now.year - @year 
  end
  
  def to_s
    "#{@title} — новинка, вышло #{@years_from_production} лет назад"
  end
end
