file_name = ARGV.empty? ? 'movies.txt' : ARGV[0]

unless File.exist?(file_name)
  puts 'File does not exist'
  return
end 

File.open(file_name) do |fp|
  fp.each do |line|
    movie_attrs = line.split('|')
    movie_title = movie_attrs[1]
    movie_rate = movie_attrs[7].to_f

    next unless movie_title.downcase.include?('max')

    asterisk_count = 10 * (movie_rate - 8).round(1)
    puts "movie #{movie_title} rate #{'*' * asterisk_count}"
  end
end
