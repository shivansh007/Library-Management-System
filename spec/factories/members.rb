FactoryGirl.define do
  factory :member do
    name Faker::Name.name
    address Faker::Address.street_address
    phone Faker::PhoneNumber.cell_phone
    is_male Faker::Boolean.boolean(1)
    code Faker::Code.asin
    validity_date Faker::Date.between(2.days.ago, Date.today).strftime("%F")
    is_author Faker::Boolean.boolean(1)
    library { Library.first || association(:library) }
  end
end
