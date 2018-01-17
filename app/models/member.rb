class Member < ActiveRecord::Base
  belongs_to :library
  has_many :issue_histories
  validates :name, presence: true, length: { minimum: 2 }
  validates :address, presence: true, length: { minimum: 5 }
  validates :phone, presence: true, length: { minimum: 5, maximum: 15 }
  validates :is_male, presence: true
  validates :code, presence: true
  validates :validity_date, presence: true, format: { with: /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\Z/ }
  validates :is_author, presence: true
  validates :library_id, presence: true, numericality: true
end
