# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(FamilyName: "",email: "Admin@Admin.com",password: "password",password_confirmation: "password")
User.find(1).characters.create(FirstName: "Adminish", LastName:"Pasadasa", Age:10, Class:"warrior", Race:"human" ,location:1)
Item.create(name: "Backpack", size:1, weight:1, equip: "Adminish")
Inventory.create(name: "Big Slot", size:10, max_weight:15, item_id:1)
Inventory.find(1).items.create(name: "Iron", size:1, weight:5, equip: "")

Biome.create(title: 'Plain', temp: 15)
Biome.create(title: 'Forest',temp: 10)
World.create(title:'Plain',biome:'Plain',size: Random.rand(500)+250,connect: '2',compass: '0, 0')
World.create(title:'Plain',biome:'Plain',size: Random.rand(500)+250,connect: '1',compass: '0, 1')
