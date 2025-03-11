class Order < ApplicationRecord
  validates :customer_name, presence: true
  validates :total, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ['pending', 'processing', 'shipped', 'delivered', 'cancelled'] }
  
  # This method will be fully covered
  def formatted_total
    "$#{'%.2f' % total}"
  end
  
  # This method will be partially covered
  def status_message
    case status
    when 'pending'
      "Your order is pending payment"
    when 'processing'
      "Your order is being processed"
    when 'shipped'
      "Your order has been shipped"
    when 'delivered'
      "Your order has been delivered"
    when 'cancelled'
      "Your order has been cancelled"
    else
      "Unknown status"
    end
  end
  
  # This method won't be covered
  def estimated_delivery_date
    return nil if status == 'cancelled'
    
    case status
    when 'pending'
      Date.today + 7.days
    when 'processing'
      Date.today + 5.days
    when 'shipped'
      Date.today + 2.days
    when 'delivered'
      nil
    else
      Date.today + 10.days
    end
  end
  
  # This method will be partially covered
  def self.recent_orders(days = 7)
    where('created_at >= ?', Date.today - days.days)
  end
  
  # This method won't be covered
  def self.by_status(status)
    where(status: status)
  end
end
