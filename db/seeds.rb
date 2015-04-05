# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(email: 'user1@example.com')
user2 = User.create(email: 'user2@example.com') 
user3 = User.create(email: 'user3@example.com') 

(1..20).to_a.each do |number|
  episode = Episode.create(
    name:         "episode #{number}",
    url:          "www.google.com",
    photo:        "http://loremflickr.com/320/240",
    last_season:  number,
    last_episode: number
  )
end

user1.episodes << Episode.find_by(name: 'episode 1')
user1.episodes << Episode.find_by(name: 'episode 2')

user2.episodes << Episode.find_by(name: 'episode 3')
user2.episodes << Episode.find_by(name: 'episode 4')
user2.episodes << Episode.find_by(name: 'episode 5')

user3.episodes << Episode.find_by(name: 'episode 2')
user3.episodes << Episode.find_by(name: 'episode 3')
user3.episodes << Episode.find_by(name: 'episode 6')