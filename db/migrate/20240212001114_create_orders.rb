# 注文テーブル
class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # idは自動生成
      t.string  :postal_code, null: false         # 配送先郵便番号
      t.string  :addreess, null: false            # 配送先住所
      t.string  :name, null: false                # 配送先宛名
      t.integer :shippinng_cost, null: false      # 送料
      t.integer :total_payment, null: false       # 請求額
      t.integer :payment_method, null: false      # 支払方法 enumで管理 {0: クレジットカード, 1: 銀行振込}
      t.integer :status, null: false, default: 0  # 注文ステータス enumで管理 {0: 入金待ち, 1: 入金確認, 2: 製作中, 3: 発送準備中, 4: 発送済}
      t.integer :customer_id, null: false         # 会員ID リレーションのために使用
      t.timestamps                                # 作成日時と更新日時
    end
  end
end
