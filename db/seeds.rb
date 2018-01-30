# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
5.times do
<<<<<<< HEAD
	Book.create({name: Faker::Book.title, author: Faker::Book.author, isbn: Faker::Code.isbn, price: Faker::Commerce.price, publication: Faker::Book.publisher, version: %w[I II III].sample, no_of_copies: Faker::Number.between(1, 10), library_id: 46, category_id: 1})
=======
	Library.create({
		name: Faker::Company.name,
		address: Faker::Address.street_address,
		phone: Faker::PhoneNumber.cell_phone
		})
end
5.times do
	Category.create({name: Faker::Book.genre})
end
5.times do
	Book.create({
		name: Faker::Book.title, 
		author: Faker::Book.author, 
		isbn: Faker::Code.isbn, 
		price: Faker::Commerce.price, 
		publication: Faker::Book.publisher, 
		version: %w[I II III].sample, 
		no_of_copies: Faker::Number.between(1, 10), 
		library_id: Faker::Number.between(1, 5), 
		category_id: Faker::Number.between(1, 5)
		})
end
5.times do
	Member.create({
		name: Faker::Name.name,
		address: Faker::Address.street_address,
		phone: Faker::PhoneNumber.cell_phone,
		is_male: Faker::Boolean.boolean(1),
		code: Faker::Code.asin,
		validity_date: Faker::Date.between(2.days.ago, Date.today).strftime("%F"),
		is_author: Faker::Boolean.boolean(1),
		library_id: Faker::Number.between(1, 5)
		})
end
5.times do
	IssueHistory.create({
		issue_type: %w[rent return].sample,
		issue_date: Faker::Date.between(2.days.ago, Date.today).strftime("%F"),
		return_date: Faker::Date.between(2.days.ago, Date.today).strftime("%F"),
		member_id: Faker::Number.between(1, 5),
		book_id: Faker::Number.between(1, 5)
		})
>>>>>>> 83c5a1387049781162ab03d3217f695c5be4743d
end