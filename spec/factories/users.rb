# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { Faker::Internet.unique.email } 
    password { "password" }
    password_confirmation { "password" }
  end
end
