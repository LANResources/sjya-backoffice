module UsersHelper
  def styled_user_status(status)
    case status
    when 'registered' then 'Registered'
    when 'contact_only' then 'Not Registered'
    when 'invited' then 'Invited'
    end
  end

  def user_status_link(user)
    case user.status
    when 'contact_only'
      invite_link user
    when 'invited'
      uninvite_link user
    when 'registered'
      revoke_link user
    end
  end

  def invite_link(user)
    if InvitePolicy.new(current_user, user).create?
      link_to 'Invite', invite_user_path(user), method: :post, class: 'btn btn-xs btn-info'
    else
      content_tag :span, 'Contact', class: 'label label-info'
    end
  end

  def uninvite_link(user)
    if InvitePolicy.new(current_user, user).destroy?
      link_to 'Uninvite', uninvite_user_path(user), method: :delete, class: 'btn btn-xs btn-info'
    else
      content_tag :span, "Invited (#{user.invited_on.strftime('%-m/%-d/%y')})", class: 'label label-info'
    end
  end

  def revoke_link(user)
    if policy(user).permitted_attributes.include? :role
      'Revoke'
    else
      content_tag :span, "Registered", class: 'label label-info'
    end
  end

  def show_role_select?(user)
    user.new_record? || current_user > user
  end

  def show_organization_select?(user)
    return false if user == current_user
    (user <= current_user) && (current_user >= :site_manager)
  end

  def city_state_zip(city, state, zipcode, fallback: '')
   csz = [city.blank? ? '' : "#{city},", state, zipcode].join(' ')
   csz.present? ? csz : fallback
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
