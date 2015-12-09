FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.name }
    password { Faker::Internet.password(8) }
  end
end
