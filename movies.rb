def perform_movie_lib(file_name)
  lib = Array.new

  File.open(file_name) do |fp|
    fp.each do |line|
      movie_attrs = line.split('|')
      
      h = {
        link: movie_attrs[0],
        title: movie_attrs[1],
        year: movie_attrs[2],
        country: movie_attrs[3],
        premiere_date: movie_attrs[4],
        genre: movie_attrs[5],
        durability: number_from_string(movie_attrs[6]),
        rate: movie_attrs[7],
        producer: movie_attrs[8].split.last
      }

      lib << h
    end
  end

  lib
end

def number_from_string(string)
  string.scan( /\d+/ ).first.to_i
end

def show_movies(movies)
  movies.each do |m|
    puts "#{m[:title]} (#{m[:premiere_date]}; #{m[:genre]}) - #{m[:durability]}"
  end
end

file_name = ARGV.empty? ? 'movies.txt' : ARGV[0]

unless File.exist?(file_name)
  puts 'File does not exist'
  return
end

movie_lib = perform_movie_lib(file_name)
puts '5 longest movies'
show_movies(movie_lib.sort_by { |m| -m[:durability] }.first(5))
puts '10 comedies'
show_movies(movie_lib.select { |m| m[:genre].include?('Comedy') }.sort_by { |m| m[:premiere_date] }.first(10))
puts 'producers'
puts movie_lib.map { |m| m[:producer] }.uniq.sort
print 'foreign movies count '
puts movie_lib.reject { |m| m[:country].include?('USA') }.size
