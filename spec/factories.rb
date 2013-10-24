FactoryGirl.define do
  factory :user do
    first_name "Nick"
    last_name  "Reed"
    sequence(:email) { |n| "#{first_name.downcase}_#{last_name.downcase}_#{n}@example.com" }

    trait :password do
      password 'testing'
      password_confirmation 'testing'
    end
    trait :contact_role do
      role 'contact'
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
    trait :invited do
      invite_token { User.generate_token :invite_token }
      invited_at { Time.zone.now }
      association :inviter, factory: :administrator
    end

    factory :contact,                       traits: [:contact_role]
    factory :invited_registered_user,       traits: [:registered_user_role, :invited]
    factory :registered_user,               traits: [:registered_user_role, :password]
    factory :invited_organization_manager,  traits: [:organization_manager_role, :invited]
    factory :organization_manager,          traits: [:organization_manager_role, :password]
    factory :invited_site_manager,          traits: [:site_manager_role, :invited]
    factory :site_manager,                  traits: [:site_manager_role, :password]
    factory :invited_administrator,         traits: [:administrator_role, :invited]
    factory :administrator,                 traits: [:administrator_role, :password]
  end
end
