class Theatre
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show(time)
    schedule_item = schedule.select { |item| item === time.hour }

    movies = 5.times.map { @movie_collection.filter(schedule_item.values[0]).sample }
    now_showing = movies.sort_by { |m| -m.rate }.first

    puts  "Theatre now showing: #{now_showing.title} #{time.hour} - #{time.hour + 2}"
    now_showing
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
    puts "We will show \"#{movie_title}\" on #{hr} o'clock"
  end
end
