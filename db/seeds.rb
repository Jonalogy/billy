# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PaymentType.create!(pay_type:'Cash')
PaymentType.create!(pay_type:'Internet Banking')
PaymentType.create!(pay_type:'Favour')

User.create!(name:"Admin", mobile_number:'987654321', email:'admin@email.com', password:'123', password_confirmation:'123')

user = User.find(1)
user.bills.create!(title:'Mom\'s birthday', description:'Dinner at Tung Lok and present', total_price: 320.70, due:'2016-12-12')
user.bills.create!(title:'Beer night', description:'Drinks at Raffles Club', total_price: 220.00, due:'2016-12-12')
user.bills.create!(title:'Mashmallow night', description:'Mashmallow Fight', total_price: 50.00, due:'2016-12-12')
user.bills.create!(title:'Division Barbeque', description:'Quaterly Division Celebration', total_price: 426.10, due:'2016-12-12')

bill = user.bills.find(1)
bill.items.create!(item_name:'Total dinner bill', item_price: 220.70)
bill.items.create!(item_name:'Present', item_price: 100.00)
bill = user.bills.find(2)
bill.items.create!(item_name:'Beer Towers', item_price: 160.00)
bill.items.create!(item_name:'Finger Food', item_price: 60.00)
bill = user.bills.find(3)
bill.items.create!(item_name:'Mashmallow fingers', item_price: 20.00)
bill.items.create!(item_name:'Mashmalow Puffies', item_price: 30.00)
bill = user.bills.find(4)
bill.items.create!(item_name:'Grill deposite', item_price: 26.10)
bill.items.create!(item_name:'Food', item_price: 400)


User.create!(name:"User", mobile_number:'987654321', email:'user@email.com', password:'123', password_confirmation:'123')
