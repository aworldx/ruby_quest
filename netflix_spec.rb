require 'rspec'
require './movie_collection'
require './netflix'

RSpec.describe MyCinema::Netflix do
  before(:each) do
    @movies = MyCinema::MovieCollection.new()
    @movies.read_from_file('movies.txt')

    @netflix = MyCinema::Netflix.new(@movies)
  end

  context ".show" do
    it "raise error if no money" do
      expect do 
        @netflix.show(genre: 'Comedy', period: :classic)
      end.to raise_error("Insufficient funds on the account")
    end
    
    it "shows movies with passed attributes and reduce money on account" do
      @netflix.pay(40) 
      
      movie = nil
      expect do
        movie = @netflix.show(genre: 'Comedy', period: :classic) 
      end.to change { MyCinema::Netflix.cash }.from(40).to(40 - @netflix.price(:classic))
      
      expect(movie.genre).to include('Comedy')
      expect(movie.year).to be_between(1945, 1967).inclusive
      expect(MyCinema::Netflix.cash).to be < 40  
    end
  end

  context ".how_much?" do
    it "should show how much money costs movie" do
      expect { @netflix.how_much?('Forrest Gump') }.to output("15 dollars\n").to_stdout
    end
  end

  context ".pay" do
    it "should increase money on account" do
      cash_before = MyCinema::Netflix.cash
      expect { @netflix.pay(40) }.to change { MyCinema::Netflix.cash }.from(cash_before).to(cash_before + 40)
    end
  end

  context ".take" do
    it "who = Bank" do
      expect { MyCinema::Netflix.take("Bank") }.to output("encashment\n").to_stdout
    end

    it "who = suspicious person" do
      expect { MyCinema::Netflix.take("somebody") }.to raise_error("u-u-u-u-u-u-u")
    end
  end

  context ".cash" do
    it "should return common cash for all netflix" do
      @netflix2 = MyCinema::Netflix.new(@movies)
      expect do 
        @netflix.pay(10)
        @netflix2.pay(10)
      end.to change { MyCinema::Netflix.cash }.from(0).to(20)
    end
  end
end
