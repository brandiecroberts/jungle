require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    describe 'name' do
      it 'must be present' do
        product = Product.new(name: nil)
        expect(product).to_not be_valid
        expect(product.errors[:name]).to include("can't be blank")
      end
    end

    describe 'price' do
      it 'must be present' do
        product = Product.new(price: [])
        expect(product).to_not be_valid
        expect(product.errors[:price]).to include("can't be blank")
      end
    end

     describe 'quantity' do
      it 'must be present' do
        product = Product.new(quantity: nil)
        expect(product).to_not be_valid
        expect(product.errors[:quantity]).to include("can't be blank")
      end
    end

    describe 'category' do
      it 'must be present' do
        product = Product.new(category: nil)
        expect(product).to_not be_valid
        expect(product.errors[:category]).to include("can't be blank")
      end
    end

  end
end
