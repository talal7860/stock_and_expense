FactoryGirl.define do
  factory :stock_out do
    association :customer
    association :sku
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    amount_paid_cents 1000
    quantity 10
    stock_unit :single
  end
  factory :stock_out_less, class: StockOut  do
    association :customer
    association :sku
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    amount_paid_cents 500
    quantity 10
    stock_unit :single
  end
end
