module RequestSpecHelper

  include Warden::Test::Helpers

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    case resource
    when :admin
      resource = create_or_use(:admin)
    when :normal
      resource = create_or_use(:profile)
    end
    @resource = resource
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out
    logout(warden_scope(@resource)) if @resource
    @resource = nil
  end

  private

  def create_or_use(bot_name)
    test = build(bot_name)
    q = Profile.where(name: test.name)
    resource = q.exists? ? q.first.user : create(bot_name).user
    resource.confirm unless resource.confirmed?
    resource
  end

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end

end
