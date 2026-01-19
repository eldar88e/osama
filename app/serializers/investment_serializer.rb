class InvestmentSerializer
  include Alba::Resource

  root_key :investment

  attributes :id, :amount, :comment, :invested_at, :user_id, :created_at

  attribute :user do |investment|
    investment.user&.full_name
  end
end
