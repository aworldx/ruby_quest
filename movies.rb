def perform_movie_lib(file_name)
  lib = Array.new
  keys = [:link, :title, :year, :country, :premiere_date, :genre, :durability, :rate, :producer]

  File.open(file_name) do |fp|
    fp.each do |line|
      lib << Hash[keys.zip(line.split('|'))]
    end
  end

  lib
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
show_movies(movie_lib.sort_by { |m| -m[:durability].to_i }.first(5))
puts '10 comedies'
show_movies(movie_lib.select { |m| m[:genre].include?('Comedy') }.sort_by { |m| m[:premiere_date] }.first(10))
puts 'producers'
puts movie_lib.map { |m| m[:producer].split.last }.uniq.sort
print 'foreign movies count '
puts movie_lib.reject { |m| m[:country].include?('USA') }.size
