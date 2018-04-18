require './cashbox'

module MyCinema
  class Netflix
    # attr_reader :account
    extend Cashbox

    def initialize(movie_collection)
      @movie_collection = movie_collection
    end

    def show(options)
      movies = @movie_collection.filter(options)
      now_showing = movies.sort_by { |m| m.rate }.first

      if now_showing
        raise "Insufficient funds on the account" unless charge(now_showing.period)

        puts "Netflix now showing: #{now_showing.title} #{show_time(now_showing)}"
      else
        puts 'Sorry, we did not find the movie on your request'
      end

      now_showing
    end

    def show_time(movie)
      "#{Time.now.strftime("%H:%M")} - #{(Time.now + movie.durability * 60).strftime("%H:%M")}"
    end

    def how_much?(movie_title)
      movie = @movie_collection.filter(title: movie_title).first

      if movie
        puts "#{price(movie.period)} dollars"
      else
        puts "Sorry, we did not find the movie on your request"
      end
    end
  end
end
