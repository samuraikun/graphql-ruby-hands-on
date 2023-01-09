FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    password_digest { 'password' }
    first_name { 'John' }
    last_name { 'Doe' }
    postal_code { '123-4567' }
    address { 'Tokyo, Japan' }
    phone { '03-1234-5678' }
  end
end
