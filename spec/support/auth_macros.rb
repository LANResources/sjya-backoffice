module AuthMacros
  def log_in(attributes = attributes_for(:registered_user))
    @_current_user = create(:registered_user, attributes)
    visit login_path
    fill_in "session_email", with: @_current_user.email
    fill_in "session_password", with: attributes[:password]
    click_button "Login"
  end

  def current_user
    @_current_user
  end
end
