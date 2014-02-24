module ApplicationHelper
  def date_display(date)
    date.strftime("%-m/%d/%Y")
  end
end
