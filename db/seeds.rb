# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts '1. emptying movie table'
Movie.destroy_all
List.destroy_all # ==> /!\ check that the seed works before uncommenting this line
Bookmark.destroy_all # ==> /!\ check that the seed works before uncommenting this line

puts '2. start seeding movies'

(482..700).to_a.each do |movie_id|
  basic_url = 'https://api.themoviedb.org/3/movie/'
  my_api_key = 'fa0844821d319d77577896f1c908f1bc'
  url = "#{basic_url}#{movie_id}?api_key=#{my_api_key}"
  # puts url
  begin
    movie_serialized = URI.open(url, 'User-Agent' => "Ruby/#{RUBY_VERSION}").read
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

puts '3. start seeding lists'

# List Wallace and Gromit

file = URI.open('app/assets/images/wallace&gromit.jpg')
list = List.new(name: 'Wallace & Gromit')
list.photo.attach(io: file, filename: 'wallace_and_gromit.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'A Grand Day Out')
Bookmark.create(list: list, movie: movie, comment: 'The initial one')
movie = Movie.find_by(title: 'The Wrong Trousers')
Bookmark.create(list: list, movie: movie, comment: 'Where things go wrong at breakfast time')
movie = Movie.find_by(title: 'A Close Shave')
Bookmark.create(list: list, movie: movie, comment: 'Shaun the sheep hits the screen')
movie = Movie.find_by(title: 'Wallace & Gromit: The Curse of the Were-Rabbit')
Bookmark.create(list: list, movie: movie, comment: 'Avec des lapin-garous')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/nouvelle_vague.jpg')
list = List.new(name: 'Art House')
list.photo.attach(io: file, filename: 'nouvelle_vague.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'Dial M for Murder')
Bookmark.create(list: list, movie: movie, comment: 'a breathtaking crime story')
movie = Movie.find_by(title: 'Life of Brian')
Bookmark.create(list: list, movie: movie, comment: 'Monthy Pythons at their best')
movie = Movie.find_by(title: "One Flew Over the Cuckoo's Nest")
Bookmark.create(list: list, movie: movie, comment: "Nicholson's performance is amazing!")
movie = Movie.find_by(title: 'The Lives of Others')
Bookmark.create(list: list, movie: movie, comment: 'German cinema in the early 2000s')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/trainspotting_poster.jpg')
list = List.new(name: '10 movies I wanna watch')
list.photo.attach(io: file, filename: 'trainspotting.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'City of God')
Bookmark.create(list: list, movie: movie, comment: 'Ciudade de Deus. Punch in the face.')
movie = Movie.find_by(title: 'Dogville')
Bookmark.create(list: list, movie: movie, comment: "I've heard about it years ago")
movie = Movie.find_by(title: 'Fight Club')
Bookmark.create(list: list, movie: movie, comment: 'Another punch in the face')
movie = Movie.find_by(title: 'Flashdance')
Bookmark.create(list: list, movie: movie, comment: 'souvenir...')
movie = Movie.find_by(title: "There's Something About Mary")
Bookmark.create(list: list, movie: movie, comment: 'I had so much laugh when I first saw that movie...')
movie = Movie.find_by(title: 'The Grapes of Wrath')
Bookmark.create(list: list, movie: movie, comment: "Before reading Steinbeck's masterpiece")
movie = Movie.find_by(title: 'Solaris')
Bookmark.create(list: list, movie: movie, comment: 'Tarkovski or maybe the remake')
movie = Movie.find_by(title: 'The Man Who Knew Too Much')
Bookmark.create(list: list, movie: movie, comment: 'You probably know too little about it')
movie = Movie.find_by(title: 'Ladyhawke')
Bookmark.create(list: list, movie: movie, comment: 'Quite curious about that movie')
movie = Movie.find_by(title: 'Bread and Tulips')
Bookmark.create(list: list, movie: movie, comment: 'for I have never heard about it and found the title funny')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/hitchcock.jpg')
list = List.new(name: "Alfred Hitchcock's")
list.photo.attach(io: file, filename: 'hitchcock.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'Frenzy')
Bookmark.create(list: list, movie: movie, comment: 'Vertigo in french, if i remember well')
movie = Movie.find_by(title: 'Marnie')
Bookmark.create(list: list, movie: movie, comment: 'Tipi Heddren is stunning')
movie = Movie.find_by(title: 'Psycho')
Bookmark.create(list: list, movie: movie, comment: 'Shower time')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/japan.jpg')
list = List.new(name: 'Made in Japan')
list.photo.attach(io: file, filename: 'japan.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'Rashomon')
Bookmark.create(list: list, movie: movie, comment: 'Akira Kurosawa was so inspired')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/baby-is-playing-hide-and-seek.jpg')
list = List.new(name: 'Films I will not see (again)')
list.photo.attach(io: file, filename: 'baby.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'The Da Vinci Code')
Bookmark.create(list: list, movie: movie, comment: 'Sorry Tom')
movie = Movie.find_by(title: 'The Terminal')
Bookmark.create(list: list, movie: movie, comment: 'Sorry again, Tom. Nothing personal.')
movie = Movie.find_by(title: 'Dances with Wolves')
Bookmark.create(list: list, movie: movie, comment: "Kevin's boring")
movie = Movie.find_by(title: 'Die Hard')
Bookmark.create(list: list, movie: movie, comment: 'Thinking about it already exhausts me.')
movie = Movie.find_by(title: 'Love Actually')
Bookmark.create(list: list, movie: movie, comment: 'euh...')
movie = Movie.find_by(title: 'Spider-Man')
Bookmark.create(list: list, movie: movie, comment: 'number 2 and 3 neither')
movie = Movie.find_by(title: 'Titanic')
Bookmark.create(list: list, movie: movie, comment: 'watching it once is already one too many')
movie = Movie.find_by(title: 'The Mummy')
Bookmark.create(list: list, movie: movie, comment: '------')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/tarantino.jpg')
list = List.new(name: "Tarantino's")
list.photo.attach(io: file, filename: 'tarantino.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'Reservoir Dogs')
Bookmark.create(list: list, movie: movie, comment: "One of earliest Tarantino's, maybe the best. With Harvey Keitel")
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

file = URI.open('app/assets/images/007.jpg')
list = List.new(name: 'James Bond')
list.photo.attach(io: file, filename: '007.jpg', content_type: 'image/jpg')
list.save!
movie = Movie.find_by(title: 'Dr. No')
Bookmark.create(list: list, movie: movie, comment: 'the first of the series')
movie = Movie.find_by(title: 'For Your Eyes Only')
Bookmark.create(list: list, movie: movie, comment: 'With Carole Bouquet')
movie = Movie.find_by(title: 'From Russia with Love')
Bookmark.create(list: list, movie: movie, comment: 'This one is with Sean')
movie = Movie.find_by(title: 'Goldfinger')
Bookmark.create(list: list, movie: movie, comment: 'OddJobs')
movie = Movie.find_by(title: 'Moonraker')
Bookmark.create(list: list, movie: movie, comment: 'Where we meet Shark')
movie = Movie.find_by(title: 'Octopussy')
Bookmark.create(list: list, movie: movie, comment: 'with Roger Moore')
movie = Movie.find_by(title: "On Her Majesty's Secret Service")
Bookmark.create(list: list, movie: movie, comment: 'Is it the one with George Lazenby?')
movie = Movie.find_by(title: 'The Man with the Golden Gun')
Bookmark.create(list: list, movie: movie, comment: 'Scaramanga')
movie = Movie.find_by(title: 'The Spy Who Loved Me')
Bookmark.create(list: list, movie: movie, comment: 'Barbara Bach and Roger Moore')
movie = Movie.find_by(title: 'Thunderball')
Bookmark.create(list: list, movie: movie, comment: 'Sean, sean, sean')
movie = Movie.find_by(title: 'You Only Live Twice')
Bookmark.create(list: list, movie: movie, comment: '------')
puts "created #{list.name} list with #{list.bookmarks.count} bookmarks"

puts 'SEED SUMMARY'
puts "created #{Movie.count} movies"
puts "created #{List.count} lists"
puts "created #{Bookmark.count} bookmarks"

puts 'done seeding'
