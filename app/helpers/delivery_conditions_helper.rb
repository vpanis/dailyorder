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

  def set_starting_day(relation, date)

    order_limits = [0, 0, 0, 0, 0, 0, 1]

    relation.delivery_conditions.first.order_deadlines.each_with_index do |item, index|
      if item.nil?
        order_limits[index] = order_limits[index + 1] if !order_limits[index + 1].nil?
        order_limits[index] = order_limits[0] + 1 if order_limits[index + 1].nil?
      elsif item == 0.5
        if (date - 2.hours).hour < 12
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 1
          end
        else
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 2
          end
        end
      elsif item == 0.75
        if (date - 2.hours).hour < 18
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 1
          end
        else
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 2
          end
        end
      elsif (item + 1) % (item.floor + 1) == 0.5
        if (date - 2.hours).hour < 12
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 1
          end
        else
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 2
          end
        end
      elsif (item + 1) % (item.floor + 1) == 0.75
        if (date - 2.hours).hour < 18
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 1
          end
        else
          for i in 1..(item.floor + 1)
            order_limits[index - i] = i + 2
          end
        end
      else
        for i in 1..(item + 1)
          order_limits[index - i] = i + 1
        end
      end
    end

    if date.strftime("%A").downcase == "sunday"
      order_limits[0]
    elsif date.strftime("%A").downcase == "monday"
      order_limits[1]
    elsif date.strftime("%A").downcase == "tuesday"
      order_limits[2]
    elsif date.strftime("%A").downcase == "wednesday"
      order_limits[3]
    elsif date.strftime("%A").downcase == "thursday"
      order_limits[4]
    elsif date.strftime("%A").downcase == "friday"
      order_limits[5]
    elsif date.strftime("%A").downcase == "saturday"
      order_limits[6]
    end

  end
end
