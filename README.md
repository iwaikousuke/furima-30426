# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#　テーブル設計

##  usersテーブル

| Column             | Type   | Options      |
| ------------------ | ------ | ------------ |
| nickname           | text   | null: false  |
| email              | string | null: false  |
| password           | string | null: false  |
| last_name          | string | null: false  | with_options format
| first_name         | string | null: false  | with_options format
| last_name_kana     | string | null: false  | with_options format
| first_name_kana    | string | null: false  | with_options format
| birth_date         | date   | null: false  |



###  Association
- has_many : items
- has_many : purchases



## items テーブル 

| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| name             | text       | null: false       |
| text             | text       | null: false       |
| category_id      | integer    | null: false       |
| status_id        | integer    | null: false       |
| shopping_id      | integer    | null: false       |
| prefecture_id    | integer    | null: false       |
| day_id           | integer    | null: false       |
| price            | integer    | null: false       | with_options format
| user             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchasesテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :address


## addresses
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| postal_code      | string     | null: false       |
| prefecture_id    | integer    | null: false       |
| city             | text       | null: false       |
| street_address   | text       | null: false       |
| building         | text       |                   |
| phone_number     | string     | null: false       |
| purchase         | references | foreign_key: true |

### Association
- belongs_to :purchase


