FactoryGirl.define do
  factory :stock_out do
    association :customer
    association :sku
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    quantity 10
    stock_unit 'single'
  end
end
