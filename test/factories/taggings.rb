FactoryBot.define do
  factory :tagging do
    association :tag
    association :article
  end
end
