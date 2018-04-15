require 'rspec'
require './movie_collection'
require './theatre'

RSpec.describe MyCinema::Theatre do
  before(:each) do
    movies = MyCinema::MovieCollection.new()
    movies.read_from_file('movies.txt')

    @theatre = MyCinema::Theatre.new(movies)
    @theatre.buy_ticket
  end

  context ".show" do
    it "should show classic movie in morning" do
      movie = @theatre.show
      expect(movie.period).to eq(:ancient)
    end
    
    it "should show comedy movie by day" do
      movie = @theatre.show
      expect(movie.genre).to include('Comedy').or include('Adventure')
    end

    it "should show drama or horror movie at night" do
      movie = @theatre.show
      expect(movie.genre).to include('Drama').or include('Horror')
    end
  end

  context ".when?" do
    it "should show time when movie is showing" do
      expect { @theatre.when?('Back to the Future') }.to output("on 13..20 o'clock\n").to_stdout
      expect { @theatre.when?('The Thing') }.to output("on 21..23 o'clock\n").to_stdout
    end
  end

  context ".buy_ticket" do
    it "" do

    end
  end
end
