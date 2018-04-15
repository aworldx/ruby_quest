require 'rspec'
require './movie_collection'
require './theatre'
require 'timecop'

RSpec.describe MyCinema::Theatre do
  before(:each) do
    movies = MyCinema::MovieCollection.new()
    movies.read_from_file('movies.txt')

    @theatre = MyCinema::Theatre.new(movies)
  end

  context ".show" do
    it "should show ancient movie in morning" do
      Timecop.freeze(Time.new(2018, 4, 15, 9)) do
        @theatre.buy_ticket
        @theatre.show
        expect(@theatre.now_showing[:movie].period).to equal(:ancient)
      end
    end
    
    it "should show comedy movie by day" do
      Timecop.freeze(Time.new(2018, 4, 15, 13)) do
        @theatre.buy_ticket
        @theatre.show
        expect(@theatre.now_showing[:movie].genre).to include('Comedy').or include('Adventure')
      end
    end

    it "should show drama or horror movie at night" do
      Timecop.freeze(Time.new(2018, 4, 15, 22)) do
        @theatre.buy_ticket
        @theatre.show
        expect(@theatre.now_showing[:movie].genre).to include('Drama').or include('Horror')
      end
    end
  end

  context ".when?" do
    it "should show time when movie is showing" do
      expect { @theatre.when?('Back to the Future') }.to output("on 13..20 o'clock\n").to_stdout
      expect { @theatre.when?('The Thing') }.to output("on 21..23 o'clock\n").to_stdout
    end
  end

  context ".buy_ticket" do
    it "should show info about ticket" do
      @theatre.buy_ticket
      expect { @theatre.buy_ticket }.to output("You bought the ticket on"\
        " #{@theatre.now_showing[:movie].title} movie\n").to_stdout
    end

    it "should increase cash by 3 dollars in the morning" do
      Timecop.freeze(Time.new(2018, 4, 15, 9)) do  
        expect { @theatre.buy_ticket }.to change { @theatre.cash }.from(0).to(3)
      end
    end

    it "should increase cash by 5 dollars a day" do
      Timecop.freeze(Time.new(2018, 4, 15, 13)) do 
        expect { @theatre.buy_ticket }.to change { @theatre.cash }.from(0).to(5)
      end
    end

    it "should increase cash by 10 dollars in the evening" do 
      Timecop.freeze(Time.new(2018, 4, 15, 22)) do
        expect { @theatre.buy_ticket }.to change { @theatre.cash }.from(0).to(10)
      end
    end
  end
end
