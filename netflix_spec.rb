require 'rspec'
require './movie_collection'
require './netflix'
require 'byebug'

RSpec.describe Netflix do
  before(:each) do
    movies = MovieCollection.new()
    movies.read_from_file('movies.txt')

    @netflix = Netflix.new(movies)
  end

  context "show(genre: 'Comedy', period: :classic)" do
    it "returns only classic comedy movies" do
      movies = @netflix.show(genre: 'Comedy', period: :classic).first(5)
      movies.each do |movie|
        byebug
        expect(movie[:genre]).to contain_exactly('Comedy')
        expect(movie[:year]).to be_between(1945, 1977).inclusive
      end
    end
  end
end
