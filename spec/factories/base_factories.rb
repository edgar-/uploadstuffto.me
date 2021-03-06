include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :email do |n|
    "user#{ n }@gmail.com"
  end

  sequence :username do |n|
    "test_user#{ n }"
  end

  sequence :key do |n|
    "ThisIsAnInviteKey#{ n }"
  end

  sequence :description do |n|
    "This is a description for invite #{ n }"
  end

  factory :invite do
    key
    description
  end

  factory :image do
    file { fixture_file_upload('spec/fixtures/chicken_rice.jpg') }
  end

  factory :user do
    invite
    username
    email
    password 'helloworld'
    password_confirmation { |u| u.password }

    trait :featured do
      featured true
    end

    factory :user_with_image do
      after(:create) { |instance| create_list(:image, 1, user: instance) }
    end

    factory :user_with_images do
      # Six images because pagination's per page is 5, so we can have two pages.
      after(:create) { |instance| create_list(:image, 6, user: instance) }
    end
  end
end