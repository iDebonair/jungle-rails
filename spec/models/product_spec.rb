require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves successfully when all fields are set' do
      category = Category.create(name: 'Testing')
      product = Product.new(
        name: 'Test Product',
        quantity: 5,
        price_cents: 100,
        category_id: category.id
      )
      expect(product).to be_valid
    end

    it 'validates the presence of name' do
      product = Product.new(quantity: 5, price_cents: 100, category_id: 1, name: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates the presence of price' do
      product = Product.new(name: 'Test Product', quantity: 5, category_id: 1, price_cents: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates the presence of quantity' do
      product = Product.new(name: 'Test Product', price_cents: 100, category_id: 1, quantity: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates the presence of category' do
      product = Product.new(name: 'Test Product', quantity: 5, price_cents: 100, category: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
