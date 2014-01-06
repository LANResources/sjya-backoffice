userStatusLabel = $("<%= escape_javascript(user_status_label(@user)) %>");
userStatusLink = $("<%= escape_javascript(user_status_link(@user)) %>");
role = "<%= @user.role.titleize %>";

$('.user-status-label').replaceWith(userStatusLabel);
$('.user-status-link').replaceWith(userStatusLink);
$('.user-role').text(role);