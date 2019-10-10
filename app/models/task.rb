class Task < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :note, presence: true, length: { maximum: 300, minimum: 5}
end
