# Seeding all the Categories in the DB
categories = [
  "Based on real facts",
  "Fanfiction",
  "Gore",
  "Killer",
  "Mistery",
  "Monsters",
  "Psychological",
  "Realistic",
  "Religion",
  "Screamer",
  "Spirits"
]
Category.destroy_all

puts "Seeding Categories"
categories.each { |category| Category.create(name: category) }
puts "Categories seeded"
