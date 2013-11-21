RSpec::Matchers.define :permit do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message_for_should do |policy|
    "#{policy.class} does not permit #{action} on #{policy.resource} for #{policy.user.inspect}."
  end

  failure_message_for_should_not do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.resource} for #{policy.user.inspect}."
  end
end

# RSpec::Matchers.define :allow_page do |*args|
#   match do |permission|
#     permission.allow?(*args).should be_true
#   end
# end

# RSpec::Matchers.define :allow_param do |*args|
#   match do |permission|
#     permission.allow_param?(*args).should be_true
#   end
# end
