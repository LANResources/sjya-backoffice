FactoryGirl.define do
  factory :user do
    first_name "Nick"
    last_name  "Reed"
    sequence(:email) { |n| "#{first_name.downcase}_#{last_name.downcase}_#{n}@example.com" }

    trait :password do
      password 'testing'
      password_confirmation 'testing'
    end
    trait :contact_only_status do
      status 'contact_only'
    end
    trait :invited_status do
      status 'invited'
    end
    trait :registered_status do
      status 'registered'
    end
    trait :contact_role do
      role 'contact'
    end
    trait :invited_user_role do
      role 'invited_user'
    end
    trait :registered_user_role do
      role 'registered_user'
    end
    trait :organization_manager_role do
      role 'organization_manager'
    end
    trait :site_manager_role do
      role 'site_manager'
    end
    trait :administrator_role do
      role 'administrator'
    end

    factory :contact,               traits: [:contact_only_status, :contact_role]
    factory :invited_user,          traits: [:invited_status, :invited_user_role]
    factory :registered_user,       traits: [:registered_status, :registered_user_role, :password]
    factory :organization_manager,  traits: [:registered_status, :organization_manager_role, :password]
    factory :site_manager,          traits: [:registered_status, :site_manager_role, :password]
    factory :administrator,         traits: [:registered_status, :administrator_role, :password]
  end
end
