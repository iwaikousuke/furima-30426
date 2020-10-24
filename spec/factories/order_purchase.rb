FactoryBot.define do
  factory :order_purchase do
    token                { 'tok_aaaaa11111' }
    postal_code          { '123-4567' }
    prefecture_id        { 2 }
    city                 { '横浜市' }
    street_address       { '青山' }
    phone_number         { '09012345678' }
    association :user
    association :item
  end
end
