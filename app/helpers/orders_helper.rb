module OrdersHelper

  def orders_chart_series(orders, start_time)
    orders_by_day = orders.where(:date => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("date(date)").
                    select("date, sum(revenue) as total_revenue")
    (start_time.to_date..Date.today).map do |date|
      order = orders_by_day.detect { |order| order.date.to_date == date }
      order && order.total_revenue.to_f || 0
    end.inspect
  end

end

