class Room < ApplicationRecord
  belongs_to :block
  has_many :allocations
end