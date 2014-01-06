module UsersHelper
  def styled_user_status(user)
    case user.status
    when 'registered' then 'Registered'
    when 'contact_only' then 'Not Registered'
    when 'invited' then "Invited (#{user.invited_at.strftime('%-m/%-d/%y')})"
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

  def user_status_label(user)
    content_tag :span, styled_user_status(user), class: 'label label-info user-status-label'
  end

  def invite_link(user)
    if InvitePolicy.new(current_user, user).create?
      link_to 'Send Invite', invite_user_path(user), method: :post, class: 'btn-link user-status-link'
    end
  end

  def uninvite_link(user)
    if InvitePolicy.new(current_user, user).destroy?
      link_to 'Uninvite', uninvite_user_path(user), method: :delete, class: 'btn-link user-status-link'
    end
  end

  def revoke_link(user)
    if policy(user).permitted_attributes.include? :role
      link_to 'Revoke Site Access', revoke_user_path(user), method: :patch, remote: true, class: 'text-danger user-status-link'
    end
  end

  def show_role_select?(user)
    user.new_record? || current_user > user
  end

  def role_explanations(roles)
    content_tag :dl, class: 'dl-horizontal', id: 'role-explanations' do
      roles.map do |role|
        dt = content_tag :dt, role.to_s.titleize
        explanation = case role.to_s.titleize
                      when 'Contact'
                        'Will not have any access to the site.'
                      when 'Registered User'
                        'Will have access to the site with mostly read-only permissions.'
                      when 'Organization Manager'
                        ['Can create/manage registered users and contacts within their own organization.',
                          'Can update their own organization.'].join('<br/>')
                      when 'Site Manager'
                        ['Can create/manage organization managers, registered users, and contacts in any organization.',
                          'Can create/manage organizations.'].join('<br/>')
                      when 'Administrator'
                        'Full permissions'
                      end
        dd = content_tag :dd, (explanation + ' <hr/>').html_safe
        [dt + dd].join('').html_safe
      end.join('').html_safe
    end.html_safe
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
