# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:"Admin", mobile_number:'987654321', email:'admin@email.com', password:'123', password_confirmation:'123')

user = User.find(1)
user.bills.create!(title:'Mom\'s birthday', description:'Dinner at Tung Lok and present', total_price: 320.70, due:'2016-12-12')

bill = user.bills.find(1)
bill.items.create!(item_name:'Total dinner bill', item_price: 220.70)
bill.items.create!(item_name:'Present', item_price: 100.00)
