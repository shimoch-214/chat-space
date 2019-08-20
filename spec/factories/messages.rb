FactoryBot.define do
  factory :message do
    body            {Faker::Lorem.sentence}
    image           {Rack::Test::UploadedFile.new(Rails.root.join('spec/support/sample-image/photo01.jpeg'))}
    # association :user, factory: :user
    # association :group, factory: :group
    user
    group
  end
end