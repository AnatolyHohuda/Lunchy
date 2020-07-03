require 'rails_helper'

RSpec.describe Victual, type: :model do
  describe 'associations' do
    it { should have_many(:category_items).class_name('CategoryItem') }
    it { should have_many(:categories).class_name('Category') }
  end

  describe 'db columns' do
    it { should have_db_index([:name, :price]).unique }

    it {
      should have_db_column(:name).
        of_type(:string).
        with_options(null: false)
    }

    it {
      should have_db_column(:price).
        of_type(:decimal).
        with_options(null: false)
    }
  end

  describe 'validations' do
    Victual.create name: 'to resolve PG::NotNullViolation', price: 9.99

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:price) }
    it { should validate_presence_of(:price) }
    it do
      should validate_numericality_of(:price).
        is_greater_than_or_equal_to(0.1).
        is_less_than_or_equal_to(100)
    end
  end
end
