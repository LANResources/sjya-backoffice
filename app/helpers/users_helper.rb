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
end
