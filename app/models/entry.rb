class Entry < ApplicationRecord
  has_many :comments
  validates :bajada, :length => { :maximum => 200}
end
