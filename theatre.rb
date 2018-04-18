require './cashbox'
require 'money'

module MyCinema
  class Theatre
    include Cashbox

    attr_reader :now_showing
    attr_accessor :balance

    def initialize(movie_collection)
      @movie_collection = movie_collection
      @now_showing = nil
      @show_start = nil
      @balance = Money.new(0, "USD")
    end

    def cash
      @balance
    end

    def now_showing_movie
      schedule_item = schedule.select { |item| item === Time.new.hour }
      movies = @movie_collection.filter(schedule_item.values[0])
      @now_showing = movies.sort_by { |m| m.rate }.first
      @show_start = schedule_item.keys.first
    end

    def show
      if @now_showing
        puts  "Theatre now showing: #{@now_showing.title} #{show_time}"
      else
        puts "You have to buy the ticket first"
      end
    end

    def show_time
      rand_start = rand(@show_start)
      "#{rand_start}:00 - #{rand_start + @now_showing.durability / 60}:"\
        "#{(@now_showing.durability % 60).to_s.rjust(2, '0')}"
    end

    def schedule
      {
        0..12 => { period: :ancient },
        13..20 => { genre: ['Comedy', 'Adventure'] },
        21..23 => { genre: ['Drama', 'Horror'] }
      }
    end

    def ticket_cost
      case Time.now.hour
      when 8..12
        3
      when 13..20
        5
      else
        10
      end
    end

    def when?(movie_title)
      hr = nil
      schedule.each do |hour_range, search|
        search[:title] = movie_title
        hr = hour_range if @movie_collection.filter(search).size > 0
      end
      puts hr ? "on #{hr} o'clock" : "Sorry, we did not find the movie on your request"
    end
  end
end
