class Book < ActiveRecord::Base
  belongs_to :library
  belongs_to :category
end
