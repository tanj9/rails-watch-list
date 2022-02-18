# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "open-uri"

puts '1. emptying movie table'
Movie.destroy_all
# List.destroy_all ==> /!\ check that the seed works before uncommenting this line
# Bookmark.destroy_all ==> /!\ check that the seed works before uncommenting this line

puts '2. start seeding movies'

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

puts "3. start seeding lists"

# List Wallace and Gromit

file = URI.open('/assets/wallace & gromit.jpg')
list = List.new(name: 'Wallace & Gromit')
list.photo.attach(io: file, filename: 'wallace_and_gromit.jpg', content_type: 'image/jpg')
list.save!
puts "created Wallace & Gromit list"

file = URI.open('/assets/nouvelle vague.jpg')
list = List.new(name: 'Art House')
list.photo.attach(io: file, filename: 'nouvelle_vague.jpg', content_type: 'image/jpg')
list.save!
puts "created Art House list"

file = URI.open('/assets/trainspotting_poster.jpg')
list = List.new(name: '10 movies I wanna watch')
list.photo.attach(io: file, filename: 'trainspotting.jpg', content_type: 'image/jpg')
list.save!
puts "created 10 movies I wanna watch list"

puts "4. start seeding bookmarks"
puts "still to be done"

puts "done seeding"
