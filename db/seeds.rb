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




# 320: rue Londres?
# https://i.picsum.photos/id/320/2689/1795.jpg?hmac=RbcHvJKkKfsAdlsQWzGT-F31XZcRP-O89MeKyDaeads

# 342:
# https://i.picsum.photos/id/342/2896/1944.jpg?hmac=_2cYDHi2iG1XY53gvXOrhrEWIP5R5OJlP7ySYYCA0QA

# 403: machine à écrire
# https://i.picsum.photos/id/403/3997/2665.jpg?hmac=l04T0quGocuZKSo0CxAJ7aC8CivbrCWV0X0dCzqvb0Y

# 4: crayon carnet
# https://i.picsum.photos/id/4/5616/3744.jpg?hmac=8wIoVTScZoSiagRtRYlNfcd7dYHEf9tGyyEF44ihYFI

# 687: lunette panorama
# https://i.picsum.photos/id/687/4288/2848.jpg?hmac=NXlF4vW4yF8Er6EDhQ7llR8JFZnwAqBX-kG0BnP68vY

# 861: télé dans le sable
# https://i.picsum.photos/id/861/5760/3840.jpg?hmac=b3YRc6_Qa18A_rD5L1tXCxP-0LRybGduFJjrlMa5htM

# 998: stylo à plume / carnet
# https://i.picsum.photos/id/998/6016/4016.jpg?hmac=Y8UPKinJhmRWK9I1x0CDmHdAF0LpucNG9XhKmJ5qbME
