# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のデータの作成
Admin.create!(
  email: "admin@gmail.com",
  password: "adminpassword"
)

# ジャンルデータの作成
Genre.create!([
  {
    name: "ケーキ"
  },
  {
    name: "プリン"
  },
  {
    name: "焼き菓子"
  }
])

# 商品のデータの作成
for num in 1..15 do
  Item.create!(
    name:         "商品名" + num.to_s,
    introduction: "商品説明" + num.to_s,
    price:        rand(500..3000),
    genre_id:     rand(1..3),
    is_active:    num%3!=0
  )
end
