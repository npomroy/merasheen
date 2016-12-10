# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Boat.create(name: 'Tony & Gene', owner: 'Eugene Pittman', home_port: 'Placentia', capacity: 20, price: 50, speed: 7, comments: "The pride of Newfoundland")
Boat.create(name: 'Jessie & the Boys', owner: 'Monica Pomroy', home_port: 'Placentia', capacity: 10, price: 40, speed: 30, comments: "A cabin cruiser")
Boat.create(name: 'Santa Maria', owner: 'Christopher Colombus', home_port: 'Spain', capacity: 40, price: 100, speed: 5, comments: "70 foot and over 500 years old")
Boat.create(name: 'Bismark', owner: 'Hitler', home_port: 'Berlin(lol)', capacity: 200, price: 5000, speed: 17, comments: "Gotta sink the Bismark cause the world depends on us")