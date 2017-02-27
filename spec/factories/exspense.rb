FactoryGirl.define do
  factory :expense do
    name "Electricity Bill for Jan 2017"
    association :admin_user
    association(:added_by, factory: :admin_user)
    amount_cents 1000
    expense_category_name "Electricity Bill"
  end
end

