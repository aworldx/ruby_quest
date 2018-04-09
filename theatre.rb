class Theatre
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show(time)
    schedule_item = schedule.select { |item| item === time.hour }

    movies = @movie_collection.filter(schedule_item.values[0])
    now_showing = movies.sort_by { |m| m.rate }.first

    puts  "Theatre now showing: #{now_showing.title} #{show_time(schedule_item, now_showing)}"
    now_showing
  end

  def show_time(schedule_item, movie)
    start_hour = rand(schedule_item.keys.first)
    "#{start_hour}:00 - #{start_hour + movie.durability / 60}:#{(movie.durability % 60).to_s.rjust(2, '0')}"
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
