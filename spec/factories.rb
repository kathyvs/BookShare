FactoryBot.define do
  factory :user, class: AuthUser do
    uid "user-id"
    image_url "http://test.com"
  end
  factory :profile do
    name "Test"
  end
  factory :admin, class: Profile do
    name "Admin"
    roles [:admin]
  end
  factory :assignment do
    
  end
  factory :book do
    
  end
  # factories will go here
end
