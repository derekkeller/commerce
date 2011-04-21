class Order < ActiveRecord::Base

  scope :shipping, where(:shipping => true)
  scope :download, where(:shipping => false)

  def self.total_on(date)
    where("date(date) = ?", date).sum(:total_revenue)
  end
    

end

# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  order      :integer
#  date       :date
#  shipping   :boolean         default(FALSE)
#  revenue    :integer
#  created_at :datetime
#  updated_at :datetime
#

