class Order < ActiveRecord::Base

  scope :shipping, where(:shipping => true)
  scope :download, where(:shipping => false)

  def self.total_on(date)
    where("date(date) = ?", date).sum(:total_revenue)
  end
    

end
