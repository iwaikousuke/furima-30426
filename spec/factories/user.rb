FactoryBot.define do
  factory :user do
    nickname              { 'abe' }
    email                 { Faker::Internet.free_email }
    password              { 'testtest1234' }
    password_confirmation { password }
    last_name             { '全角,ゼンカク,ぜんかく' }
    first_name            { '陸太郎、リクタロウ、りくたろう' }
    last_name_kana        { 'カタカナ' }
    first_name_kana       { 'カタカナ' }
    birth_date            { '19310202' }
  end
end
