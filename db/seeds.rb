# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "open-uri"

puts 'emptying movie table'
Movie.destroy_all

puts 'start seeding'

(500..600).to_a.each do |movie_id|
  basic_url = 'https://api.themoviedb.org/3/movie/'
  my_api_key = 'fa0844821d319d77577896f1c908f1bc'
  url = "#{basic_url}#{movie_id}?api_key=#{my_api_key}"
  # puts url
  begin
    movie_serialized = URI.open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}").read
    movie_json = JSON.parse(movie_serialized)
    movie = Movie.new(
      title: movie_json['title'],
      rating: movie_json['vote_average'],
      overview: movie_json['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie_json['poster_path']}"
    )
    movie.save!
    puts "created #{movie.title}"
  rescue OpenURI::HTTPError
    puts "Missing movie here at #{movie_id}"
  end
end

puts "created #{Movie.count} movies"
puts "done seeding"
