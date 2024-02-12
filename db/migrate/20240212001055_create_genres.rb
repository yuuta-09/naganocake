# ジャンルテーブル
class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      # idは自動生成
      t.string :name, null: false  # ジャンル名
      t.timestamps                 # 登録日時と更新日時
    end
  end
end
