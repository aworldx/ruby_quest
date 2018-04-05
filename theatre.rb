require 'byebug'

class Theatre
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show(time)
    movie = nil

    schedule.each do |hour_range, search|
      movie = @movie_collection.filter(search).sample if hour_range.cover?(time.hour)
    end

    puts  "Now showing: #{movie.title} #{time.hour} - #{time.hour + 2}"
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
    puts "We will show it in #{hr} o'clock"
  end
end
