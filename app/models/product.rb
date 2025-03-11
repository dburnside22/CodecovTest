class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  # This method will be fully covered in tests
  def discount_price(percentage)
    return price if percentage <= 0 || percentage >= 100
    price * (1 - percentage / 100.0)
  end
  
  # This method will be partially covered in tests
  def full_details
    if active?
      "#{name} - $#{price} - #{description}"
    else
      "#{name} - $#{price} - #{description} (Inactive)"
    end
  end
  
  # This method won't be covered in tests
  def time_since_creation
    if created_at.nil?
      "Unknown"
    else
      seconds = (Time.current - created_at).to_i
      
      if seconds < 60
        "#{seconds} seconds ago"
      elsif seconds < 3600
        "#{seconds / 60} minutes ago"
      elsif seconds < 86400
        "#{seconds / 3600} hours ago"
      else
        "#{seconds / 86400} days ago"
      end
    end
  end
  
  # This method will be partially covered
  def self.active_products
    where(active: true)
  end
  
  # This method won't be covered
  def self.search(term)
    if term.present?
      where("name LIKE ? OR description LIKE ?", "%#{term}%", "%#{term}%")
    else
      all
    end
  end
end
