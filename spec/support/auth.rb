module AuthHelpers
  def login_admin(admin_user=nil)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    admin_user ||= FactoryBot.create(:admin)
    sign_in admin_user
  end

  def login_user(user=nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryBot.create(:user)
    sign_in user
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
