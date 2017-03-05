FactoryGirl.define do
  factory :company_wallet do
    amount_cents 10000
    association(:added_by, factory: :admin_user)
  end
end


