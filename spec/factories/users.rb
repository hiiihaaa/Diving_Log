FactoryBot.define do
  factory :user do
    nickname                    {"abe"}
    sequence(:email) { |n| "hiro#{n}@example.com"}
    password                    {"00000000"}
    password_confirmation       {"00000000"}
  end
end


