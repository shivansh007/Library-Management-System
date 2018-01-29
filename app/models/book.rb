class Book < ActiveRecord::Base
  belongs_to :library
  belongs_to :category
  has_many :issue_histories, dependent: :destroy 
  validates :name, presence: true
  validates :author, presence: true, length: { minimum: 2 }
  validates :isbn, presence: true
  validates :price, presence: true, numericality: true
  validates :publication, presence: true
  validates :version, presence: true
  validates :no_of_copies, presence: true, numericality: { only_integer: true }
  validates :library_id, presence: true, numericality: { only_integer: true }
  validates :category_id, presence: true, numericality: { only_integer: true }
end
