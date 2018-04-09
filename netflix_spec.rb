require 'rspec'
require './movie_collection'
require './netflix'

RSpec.describe Netflix do
  before(:each) do
    movies = MovieCollection.new()
    movies.read_from_file('movies.txt')

    @netflix = Netflix.new(movies)
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
      end.to change(@netflix, :account)
      
      expect(movie.genre).to include('Comedy')
      expect(movie.year).to be_between(1945, 1967).inclusive
      expect(@netflix.account).to be < 40  
    end
  end

  context ".how_much?" do
    it "should show how much money costs movie" do
      expect { @netflix.how_much?('Forrest Gump') }.to output("15 dollars\n").to_stdout
    end
  end

  context ".pay" do
    it "should increase money on account" do
      @netflix.pay(40)
      expect(@netflix.account).to eq(40)
    end
  end
end
