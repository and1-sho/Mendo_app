class Item < ApplicationRecord
  # 画像を1枚だけ添付できるようにする（Active Storage を使用）
  has_one_attached :image

  # --- バリデーション ---

  # 商品番号：必須・数値・重複禁止
  validates :item_code,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 },
            uniqueness: true

  # 備品名：必須
  validates :name, presence: true

  # 在庫数：必須・0以上の整数
  validates :stock,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # 注文トリガー数：必須・1以上の整数
  validates :order_trigger,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  # 目標補充数：必須・1以上の整数
  validates :reorder_quantity,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  # --- メソッド ---

  # 今回の発注量を計算する（目標補充数 - 現在の在庫数）
  # マイナスにならないよう 0 以上にする
  def order_quantity
    [reorder_quantity - stock, 0].max
  end

  # 在庫が注文トリガー数以下かどうか確認する
  def needs_order?
    stock <= order_trigger
  end
end
