module UsersHelper
  def styled_user_status(status)
    case status
    when 'registered' then 'Registered'
    when 'contact_only' then 'Contact'
    when 'invited' then 'Invited'
    end
  end

  def city_state_zip(city, state, zipcode)
   [city.blank? ? '' : "#{city},", state, zipcode].join(' ')
  end

  def format_as_phone_number(number=nil)
    return if number.nil?
    number = number.gsub(/-|(|)|./, "")

    if number.length == 10
      "(#{number[0..2]}) #{number[3..5]}-#{number[6..-1]}"
    elsif number.length == 7
      "#{number[0..2]}-#{number[3..-1]}"
    else
      number
    end
  end
end
