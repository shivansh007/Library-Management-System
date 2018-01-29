# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
5.times do
	Book.create({name: Faker::Book.title, author: Faker::Book.author, isbn: Faker::Code.isbn, price: Faker::Commerce.price, publication: Faker::Book.publisher, version: %w[I II III].sample, no_of_copies: Faker::Number.between(1, 10), library_id: 46, category_id: 1})
end