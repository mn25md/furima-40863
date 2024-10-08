FactoryBot.define do
  factory :item do
    name { '商品名' }
    description { '商品の説明' }
    price { 1000 }
    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    association :user
  end
end
