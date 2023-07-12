class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :entities

  validates :name, presence: true
  validates :icone, presence: true
end
