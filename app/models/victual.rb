class Victual < ApplicationRecord
  has_many :category_items, dependent: :destroy
  has_many :menu_items, dependent: :destroy
  has_many :categories, through: :category_items
  has_many :menus, through: :menu_items

  validates :name, presence: true, uniqueness: { scope: :price }
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 0.1,
    less_than_or_equal_to: 100
  }
  
  include SetAssociations
  create_set_association_method_for(Category)

  mount_uploader :avatar, AvatarUploader

  def self.search_victuals_by_params(params)
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      [category.victuals.order(:name), category]
    else
      [order(:name), nil]
    end
  end
end
