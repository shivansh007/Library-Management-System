class IssueHistory < ActiveRecord::Base
  belongs_to :member
  belongs_to :book
  enum issue_type: %w[rent return]
  validates :issue_type, presence: true, inclusion: { in: %w[rent return] }
  validates :issue_date, presence: true, format: { with: /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\Z/ }
  validates :return_date, presence: true, format: { with: /\A\d{4}\-(?:0?[1-9]|1[0-2])\-(?:0?[1-9]|[1-2]\d|3[01])\Z/ }
  validates :member_id, presence: true, numericality: true
  validates :book_id, presence: true, numericality: true
end
