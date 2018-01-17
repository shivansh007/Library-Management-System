class Library < ActiveRecord::Base
  has_many :books
  has_many :members
  validates :name, presence: true, length: { minimum: 2 }
  validates :address, presence: true, length: { minimum: 7 }
  validates :phone, presence: true, length: { minimum: 7, maximum: 15 }
end
