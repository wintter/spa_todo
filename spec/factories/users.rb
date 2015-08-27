FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
    password 123456
  end

end
