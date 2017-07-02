module AuthHelper

  ADMIN_UID = "admin"
  NORM_UID = "norm"

  Profile.extend RecordExtensions

  def self.use_fake_for_profiles
    Profile.extend FakeDataset::WithFakeDataset
  end

  def login_as user_sym
    logout
    setup_user(user_sym)
    get auth_google_oauth2_callback_url, env: { "omniauth.auth" => OmniAuth.config.mock_auth[:default]}
  end

  def logout
    get logout_url
  end

  def profile_for user_sym
    user_name = profile_data_for(user_sym)[:name]
    query = Profile.query.where("name", "=", user_name)
    result = query.run
    print "Profile query result: #{result}"
    if (result.empty?)
      create_profile(user_sym)
    else
      result.first
    end
  end

  private 

    def setup_user(user_sym)
      Profile.delete_all
      create_profile(user_sym)
    end

    def profile_data_for user_sym
      @users ||= {
        admin: {name: "Admin User", roles: [:admin]},
        normal: {name: "Normal User", roles: []},
        other: {name: "Other Normal User", roles: []}
      }
      return @users[user_sym]  
    end

  def create_profile(user_sym)
      auth = OmniAuth.config.mock_auth[:default]
      attrs = profile_data_for(user_sym)
      Profile.create! uid: auth[:uid], name: attrs[:name], roles: attrs[:roles]
    end
end