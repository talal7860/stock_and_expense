class ExpenseCategory < ApplicationRecord
  has_many :expenses
  validates_uniqueness_of :slug

  before_validation :generate_slug

  private
  def generate_slug
    self.slug = self.name.parameterize
  end
end
