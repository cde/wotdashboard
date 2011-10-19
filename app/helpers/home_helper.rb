module HomeHelper
  def date_formated(day_diff = 0)
    ob = Date.today + day_diff
    ob.year.to_s + "-" + ob.month.to_s + "-" + ob.day.to_s
  end
end
