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
  factory :january_event, class: Event do
    name "January Event"
    month 1
  end
  factory :march_event, class: Event do
    name "March Event"
    month 3
  end
  factory :may_event, class: Event do 
    name "May Event"
    month 5
  end
  factory :assignment do
    
  end
  factory :book do
    
  end
  # factories will go here
end
