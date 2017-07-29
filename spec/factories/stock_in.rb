FactoryGirl.define do
  factory :stock_in do
    association :client
    association :sku
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    amount_paid_cents 1000
    quantity 10
    stock_unit :single
  end
  factory :stock_in_pet, class: StockIn  do
    association :client
    association :sku
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    amount_paid_cents 1000
    quantity 10
    stock_unit :pet
  end
end
