current_year = Date.today.year

FactoryBot.define do
  factory :event_assignment_set do
    event { "" }
    year { "" }
    books { "" }
  end
  factory :event_assignment do
    book { "" }
    count { "" }
    show { false }
  end
  factory :user, class: AuthUser do
    email { "user@test.kathyvs.net" }
    password { "user-password" }
    image_url { "http://test.kathyvs.net/user" }

  end
  factory :admin_user, class: AuthUser do
    email { "admin@test.kathyvs.net" }
    password { "admin-password" }
    roles { [:admin] }
  end
  factory :profile, class: Profile do
    name { "Test User" }
    association :user, factory: :user, strategy: :build
  end
  factory :admin, class: Profile do
    name { "Admin" }
    association :user, factory: :admin_user, strategy: :build
  end

  factory :january_event, class: Event do
    name { "January Event" }
    month { 1 }
  end
  factory :march_event, class: Event do
    name { "March Event" }
    month { 3 }
  end
  factory :may_event, class: Event do
    name { "May Event" }
    month { 5 }
  end
  factory :june_event, class: Event do
    name { "June Event" }
    month { 6 }
  end

  factory :book do
    title { "Test Book" }
  end
  factory :parker, class: Book do
    author { "Parker, James" }
    title { "A Glossary of Terms Used in Heraldry" }
    type { :armory }
  end
  factory :bahlow, class: Book do
    author { "Bahlow, Hans and Edda Gentry" }
    title { "Dictionary of German Names" }
    type { :name }
  end
  factory :ssno, class: Book do
    author { "Taszycki, Witold" }
    title { "S\u0142ownik Staropolskich Nazw Osobowych" }
    volume { 1 }
    type { :name }
  end
  factory :ncmj, class: Book do
    author { "Sólveig Þróndardóttir" }
    title { "Name Construction in Medieval Japan" }
    type { :name }
  end

  factory :empty_assignment, class: AssignmentSet do
    year { 2017 }
    association :event, factory: :january_event
    profile
  end

  factory :mar_user_assignments, class: AssignmentSet do
    arriving { "#{current_year}-02-14" }
    leaving { "#{current_year}-02-28" }
    year { current_year }
    association :event, factory: :march_event
    profile

    factory :mar_admin_assignments, class: AssignmentSet do
      arriving { "#{current_year}-02-16" }
      leaving { "#{current_year}-02-27" }
      year { current_year }
      association :profile, factory: :admin
    end
  end

end
