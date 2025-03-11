require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should not save product without name" do
    product = Product.new(price: 10.0, description: "Test product", active: true)
    assert_not product.save, "Saved the product without a name"
  end

  test "should not save product with negative price" do
    product = Product.new(name: "Test Product", price: -10.0, description: "Test product", active: true)
    assert_not product.save, "Saved the product with a negative price"
  end

  test "should calculate discount price correctly" do
    product = products(:one)
    
    # Test normal discount
    assert_equal product.price * 0.8, product.discount_price(20)
    
    # Test edge cases
    assert_equal product.price, product.discount_price(0)
    assert_equal product.price, product.discount_price(100)
    assert_equal product.price, product.discount_price(-10)
    assert_equal product.price, product.discount_price(110)
  end

  test "should return full details with active status" do
    product = products(:one)
    product.active = true
    
    expected = "#{product.name} - $#{product.price} - #{product.description}"
    assert_equal expected, product.full_details
  end

  test "should return active products" do
    # This will only test one branch of the active_products method
    active_products = Product.active_products
    assert_includes active_products, products(:one)
  end
end
