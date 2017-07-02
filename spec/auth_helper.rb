module AuthHelper

  ADMIN_UID = "admin"
  NORM_UID = "norm"

  Profile.extend RecordExtensions

  def self.use_fake_for_profiles
    Profile.extend FakeDataset::WithFakeDataset
  end

  def login_as user_name
    logout
    setup_user(user_name)
    get auth_google_oauth2_callback_url, env: { "omniauth.auth" => OmniAuth.config.mock_auth[:default]}
  end

  def logout
    get logout_url
  end

  private 

    def setup_user(user_name)
      Profile.delete_all
      create_profile(user_name)
    end

    def profile_for user_name
      @users ||= {
        admin: {name: "Admin User", roles: [:admin]},
        normal: {name: "Normal User", roles: []}
      }
      return @users[user_name]  
    end

    def create_profile(key)
      auth = OmniAuth.config.mock_auth[:default]
      attrs = profile_for(key)
      profile = Profile.create! uid: auth[:uid], name: attrs[:name], roles: attrs[:roles]
    end
end