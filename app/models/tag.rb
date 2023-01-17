class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings
  validates :name, presence: true, uniqueness: true
  before_save :downcase_name

  private
  def downcase_name
    self.name.downcase!
  end
end
