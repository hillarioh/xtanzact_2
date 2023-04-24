FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    tel_no { Faker::PhoneNumber.phone_number }
    email_address { Faker::Internet.email }
    password { "123456" }
  end
end
