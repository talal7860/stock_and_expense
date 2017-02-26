class ExpenseCategory < ApplicationRecord
  has_many :expenses
  validates_uniqueness_of :slug

  validates_presence_of :name

  before_validation :generate_slug

  private
  def generate_slug
    self.slug = self.name.parameterize
  end
end
