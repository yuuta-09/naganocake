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

# 顧客データの作成
require 'faker' # fakerを使ってダミーデータの作成
Faker::Config.locale = :ja
Gimei.unique.clear

Customer.create!([
  last_name:        "令和",
  first_name:       "花子",
  last_name_kana:   "レイワ",
  first_name_kana:  "ハナコ",
  postal_code:       1234567,
  address:          "東京都渋谷区",
  telephone_number: 1234567891,
  email:            "reiwa@gmail.com",
  password:         "reiwapass"
])

for num in 1..20 do
  Customer.create!([
    last_name:        Gimei.unique.last.kanji,
    first_name:       Gimei.unique.first.kanji,
    last_name_kana:   Gimei.unique.last.katakana,
    first_name_kana:  Gimei.unique.first.katakana,
    postal_code:      Faker::Number.number(digits: 7),
    address:          Gimei.unique.address.kanji,
    telephone_number: Faker::PhoneNumber.phone_number,
    email:            Faker::Internet.email,
    password:         'user' + num.to_s+ 'password'
  ])
end
