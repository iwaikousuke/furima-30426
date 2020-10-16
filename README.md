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
| Nickname           | text   | null: false  |
| email              | string | null: false  |
| password           | string | null: false  |
| last-name          | text   | null: false  | with_options format
| first-name         | text   | null: false  | with_options format
| last-name-kana     | text   | null: false  | with_options format
| first-name-kana    | text   | null: false  | with_options format
| user_birth_date_1  | integer| null: false  |
| user_birth_date_2  | integer| null: false  |
| user_birth_date_3  | integer| null: false  |

###  Association
- has_many : items
- has_many : purchases



## items テーブル 

| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| item-name        | text       | null: false       |
| item-text        | text       | null: false       |
| item-category    | integer    | null: false       |
| item-status      | integer    | null: false       |
| item-shopping    | integer    | null: false       |
| item-prefecture  | integer    | null: false       |
| item-day         | integer    | null: false       |
| item-price       | integer    | null: false       | with_options format
| user             | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchasesテーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| user             | references | foreign_key: true |
| item             | references | foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :addresses


## addresses
| Column           | Type       | Options           |
| ---------------- | ---------- | ------------      |
| postal_code      | text       | null: false       |
| prefecture       | integer    | null: false       |
| city             | text       | null: false       |
| street_address   | text       | null: false       |
| building         | text       | null: false       | 
| phon_number      | text       | null: false       |
| purchase         | references | foreign_key: true |

### Association
- belongs_to :purchase


