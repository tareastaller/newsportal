class Comment < ApplicationRecord
  belongs_to :entry

  validates :nombre, :contenido, :presence => true
  validates :nombre, :length => { :minimum => 2}
  validates :nombre, :uniqueness => true

end
