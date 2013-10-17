FactoryGirl.define do
  factory :user do
    first_name "Nick"
    last_name  "Reed"
    email "nickreed@example.com"
  end

  factory :contact, class: User do
    first_name "Contact"
    last_name  "User"
    email "contact@example.com"
    status "contact_only"
  end

  factory :invited_user, class: User do
    first_name "Invited"
    last_name  "User"
    email "invited@example.com"
    status "invited"
  end

  factory :registered_user, class: User do
    first_name "Registered"
    last_name  "User"
    email "registered@example.com"
    status "registered"
    password "testing"
    password_confirmation "testing"
  end
end
