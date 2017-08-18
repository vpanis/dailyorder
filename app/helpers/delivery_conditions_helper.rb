module DeliveryConditionsHelper
  def set_wday_integer(date)
    if date.strftime("%A").downcase == "sunday"
      0
    elsif date.strftime("%A").downcase == "monday"
      1
    elsif date.strftime("%A").downcase == "tuesday"
      2
    elsif date.strftime("%A").downcase == "wednesday"
      3
    elsif date.strftime("%A").downcase == "thursday"
      4
    elsif date.strftime("%A").downcase == "friday"
      5
    elsif date.strftime("%A").downcase == "saturday"
      6
    end
  end
end
