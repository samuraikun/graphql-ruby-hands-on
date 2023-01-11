FactoryBot.define do
  factory :article do
    association :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    after(:create) do |article|
      user = create(:user, email: "#{Faker::Lorem.word}@example.com", username: "#{Faker::Name.last_name.downcase}_#{SecureRandom.uuid}")
      create_list(:comment, 3, article: article, user: user)
      tags = create_list(:tag, 2)
      tags.each { |tag| create(:tagging, tag: tag, article: article) }
    end
  end
end
