# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!([
  {
    email: 'admin@example.com',
    password: 'admin@7860',
    password_confirmation: 'admin@7860',
    name: "Admin User",
    phone_number: "+923234035166"
  },
  {
    email: 'farhan@example.com',
    password: 'farhan123',
    password_confirmation: 'farhan123',
    name: "Farhan Siddique",
    phone_number: "+9203007578081"
  },
  {
    email: 'nazeer@example.com',
    password: 'password',
    password_confirmation: 'password',
    name: "Haji Nazeer",
    phone_number: "+923234035166"
  }

])

Sku.create([
  # Pepsi
  {
    name: 'Pepsi 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Pepsi 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Pepsi 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Pepsi 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Diet Pepsi 500 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Pepsi 250 ml',
    pet_quantity: 24
  },
  # Mirinda
  {
    name: 'Mirinda 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mirinda 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mirinda 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mirinda 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Mirinda 250 ml',
    pet_quantity: 24
  },
  #7UP
  {
    name: '7up 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: '7up 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: '7up 1 Ltr',
    pet_quantity: 6
  },
  {
    name: '7up 500 ml',
    pet_quantity: 12
  },
  {
    name: '7up 250 ml',
    pet_quantity: 24
  },
  #Mountain Dew
  {
    name: 'Mountain Dew 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mountain Dew  1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mountain Dew 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Mountain Dew 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Mountain Dew 250 ml',
    pet_quantity: 24
  },
  #Coke
  {
    name: 'Coke 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Coke 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Coke 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Coke 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Coke 250 ml',
    pet_quantity: 24
  },
  #Fanta
  {
    name: 'Fanta 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Fanta 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Fanta 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Fanta 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Fanta 250 ml',
    pet_quantity: 24
  },
  #Sprite
  {
    name: 'Sprite 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Sprite 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Sprite 1 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Sprite 500 ml',
    pet_quantity: 12
  },
  {
    name: 'Sprite 250 ml',
    pet_quantity: 24
  },
  #Gourmet Cola
  {
    name: 'Gourmet Cola 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Cola 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Cola 1 Ltr',
    pet_quantity: 6
  },
  #Gourmet Malta
  {
    name: 'Gourmet Malta 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Malta 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Malta 1 Ltr',
    pet_quantity: 6
  },
  #Gourmet Anar
  {
    name: 'Gourmet Anar 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Anar 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Anar 1 Ltr',
    pet_quantity: 6
  },
  #Gourmet Lichi
  {
    name: 'Gourmet Lichi 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Lichi 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Lichi 1 Ltr',
    pet_quantity: 6
  },
  #Gourmet Lemon
  {
    name: 'Gourmet Lemon 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Lemon 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Gourmet Lemon 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola
  {
    name: 'Next Cola 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola Rango
  {
    name: 'Next Cola Rango 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola Rango 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola Rango 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola Fizup
  {
    name: 'Next Cola Fizup 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola Fizup 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola Fizup 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola Mountain Day
  {
    name: 'Next Cola Mountain Day 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola Mountain Day 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola Mountain Day 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola Kandhari Anar
  {
    name: 'Next Cola Kandhari Anar 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola Kandhari Anar 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola Kandhari Anar 1 Ltr',
    pet_quantity: 6
  },
  #Next Cola Lichi
  {
    name: 'Next Cola Lichi 2.25 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Nexg Cola Lichi 1.5 Ltr',
    pet_quantity: 6
  },
  {
    name: 'Next Cola Lichi 1 Ltr',
    pet_quantity: 6
  },
])
