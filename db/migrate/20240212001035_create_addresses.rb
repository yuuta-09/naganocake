# 住所テーブル
class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      # idは自動生成
      t.string  :name, null: false         # 宛先
      t.string  :postal_code, null: false  # 郵便番号
      t.string  :address, null: false      # 住所
      t.integer :customer_id, null: false  # 会員ID リレーションを作るときに使用
      t.timestamps                         # 登録日時と更新日時
    end
  end
end
