class Staff < ApplicationRecord
  belongs_to :user
  has_many :stock_histories, dependent: :restrict_with_exception

  validates :name, presence: true
end
