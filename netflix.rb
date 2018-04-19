require './cashbox'
require 'money'

module MyCinema
  class Netflix
    extend Cashbox

    class << self
      attr_accessor :balance
    end

    self.balance = Money.new(0, "USD")

    def initialize(movie_collection)
      @movie_collection = movie_collection
    end

    def cash
      self.class.balance
    end

    def pay(money)
      self.class.add_cash(money)
    end

    def show(options)
      movies = @movie_collection.filter(options)
      now_showing = movies.sort_by { |m| m.rate }.first

      if now_showing
        puts "Netflix now showing: #{now_showing.title} #{show_time(now_showing)}"
      else
        puts 'Sorry, we did not find the movie on your request'
      end

      now_showing
    end

    def self.price(movie_period)
      {
        ancient: 5,
        classic: 10,
        modern: 15,
        new: 20
      }.fetch(movie_period)
    end

    def show_time(movie)
      "#{Time.now.strftime("%H:%M")} - #{(Time.now + movie.durability * 60).strftime("%H:%M")}"
    end

    def how_much?(movie_title)
      movie = @movie_collection.filter(title: movie_title).first

      if movie
        puts "#{self.class.price(movie.period)} dollars"
      else
        puts "Sorry, we did not find the movie on your request"
      end
    end
  end
end
