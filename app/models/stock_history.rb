class StockHistory < ApplicationRecord
  belongs_to :item
  belongs_to :staff

  validates :quantity, presence: true, numericality: { only_integer: true }

  # 事業所アカウント（User）へは staff 経由で辿れる
  delegate :user, to: :staff
end
