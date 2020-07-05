require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe 'associations' do
    it { should belong_to(:menu) }
    it { should belong_to(:victual) }

    it 'should be destroyed when parent menu destroyed' do
      menu = Menu.create(name: 'menu')
      victual = Victual.create(name: 'victual', price: 1)
      menu.victuals << victual

      expect { menu.destroy }.to change { MenuItem.count }.by(-1) 
    end
  end

  describe 'db columns' do
    it { should have_db_column(:menu_id).of_type(:integer) }
    it { should have_db_column(:victual_id).of_type(:integer) }
    it { should have_db_index(:menu_id) }
    it { should have_db_index(:victual_id) }
    it { should have_db_index([:menu_id, :victual_id]).unique }
  end

  describe 'validations' do
    it { should validate_presence_of(:menu_id) }
    it { should validate_presence_of(:victual_id) }
    it { should validate_uniqueness_of(:menu_id).scoped_to(:victual_id) }
  end
end