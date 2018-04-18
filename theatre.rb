require './cashbox'

module MyCinema
  class Theatre
    include Cashbox
    attr_reader :now_showing

    def initialize(movie_collection)
      @movie_collection = movie_collection
      @now_showing = nil
      @show_start = nil
      # @cash = 0
    end

    def now_showing_movie
      schedule_item = schedule.select { |item| item === Time.new.hour }
      movies = @movie_collection.filter(schedule_item.values[0])
      @now_showing = movies.sort_by { |m| m.rate }.first
      @show_start = schedule_item.keys.first
    end

    def show
      puts  "Theatre now showing: #{@now_showing[:movie].title} #{show_time}"
    end

    def show_time
      rand_start = rand(@now_showing[:start])
      "#{rand_start}:00 - #{rand_start + @now_showing[:movie].durability / 60}:"\
        "#{(@now_showing[:movie].durability % 60).to_s.rjust(2, '0')}"
    end

    def schedule
      {
        0..12 => { period: :ancient },
        13..20 => { genre: ['Comedy', 'Adventure'] },
        21..23 => { genre: ['Drama', 'Horror'] }
      }
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
