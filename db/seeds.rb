# Seeding all the Categories in the DB
categories = [
  "Based in real facts",
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

puts "Seeding Categories"
categories.each { |category| Category.create(name: category) }
puts "Categories seeded"
