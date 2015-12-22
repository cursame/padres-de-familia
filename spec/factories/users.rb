FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password(8) }
    institution

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    factory :teacher do
      after(:create) { |user| user.add_role(:teacher) }
    end

    factory :legal_guardian do
      after(:create) { |user| user.add_role(:legal_guardian) }
    end

    factory :student do
      after(:create) { |user| user.add_role(:student) }
    end
  end
end
