class ExpenseCategory < ApplicationRecord
  has_many :expenses
  validates_uniqueness_of :slug

  validates_presence_of :name

  after_validation :generate_slug

  def self.find_by_name(name)
    self.where(slug: name.try(:parameterize)).first
  end

  private
  def generate_slug
    self.slug = self.name.try(:parameterize)
  end
end
