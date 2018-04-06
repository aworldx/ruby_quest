require 'rspec'
require './movie_collection'
require './theatre'

RSpec.describe Theatre do
  before(:each) do
    movies = MovieCollection.new()
    movies.read_from_file('movies.txt')

    @theatre = Theatre.new(movies)
  end

  context ".show" do
    it "should show classic movie in morning" do
      movie = @theatre.show(Time.new(2018, 6, 4, 8))
      expect(movie.period).to eq(:ancient)
    end
    
    it "should show comedy movie by day" do
      movie = @theatre.show(Time.new(2018, 6, 4, 13))
      expect(movie.genre).to include('Comedy').or include('Adventure')
    end

    it "should show drama or horror movie at night" do
      movie = @theatre.show(Time.new(2018, 6, 4, 22))
      expect(movie.genre).to include('Drama').or include('Horror')
    end
  end

  context ".when?" do

  end
end
