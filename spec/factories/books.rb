FactoryGirl.define do
  factory :book do
    name Faker::Book.title
    author Faker::Book.author
    isbn Faker::Code.isbn
    price Faker::Number.decimal(2)
    publication Faker::Book.publisher
    version Faker::Number.between(1, 10)
    no_of_copies Faker::Number.between(1, 50)
    library { Library.first || association(:library) }
    category { Category.first || association(:category) }
  end
end
