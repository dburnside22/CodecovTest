require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_index_url
    assert_response :success
  end

  test "should get show" do
    get products_show_url, params: { id: @product.id }
    assert_response :success
  end

  test "should get new" do
    get products_new_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_create_url, params: { 
        product: { 
          name: "New Product", 
          price: 29.99, 
          description: "A new test product", 
          active: true 
        } 
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should get edit" do
    get products_edit_url
    assert_response :success
  end

  test "should get update" do
    get products_update_url
    assert_response :success
  end

  test "should get destroy" do
    get products_destroy_url
    assert_response :success
  end
end
