require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "should not save order without customer name" do
    order = Order.new(total: 100.0, status: "pending")
    assert_not order.save, "Saved the order without a customer name"
  end

  test "should not save order with non-positive total" do
    order = Order.new(customer_name: "John Doe", total: 0, status: "pending")
    assert_not order.save, "Saved the order with a non-positive total"
  end

  test "should not save order with invalid status" do
    order = Order.new(customer_name: "John Doe", total: 100.0, status: "invalid")
    assert_not order.save, "Saved the order with an invalid status"
  end

  test "should format total correctly" do
    order = orders(:one)
    expected = "$#{'%.2f' % order.total}"
    assert_equal expected, order.formatted_total
  end

  test "should return correct status message for pending" do
    order = orders(:one)
    order.status = "pending"
    assert_equal "Your order is pending payment", order.status_message
  end

  test "should return correct status message for processing" do
    order = orders(:one)
    order.status = "processing"
    assert_equal "Your order is being processed", order.status_message
  end

  test "should return recent orders" do
    # This will only test one branch of the recent_orders method
    recent = Order.recent_orders
    assert_includes recent, orders(:one)
  end
end
