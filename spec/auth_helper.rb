module AuthHelper

  ADMIN_UID = "admin"
  NORM_UID = "norm"

  Profile.extend RecordExtensions

  def self.use_fake_for_profiles
#    Profile.extend FakeDataset::WithFakeDataset
#    Profile.extend UidSearch
    Profile.delete_all
  end

  def set_session_as profile
    user = AuthUser.new profile.uid, "test.ignore"
    user.profile = profile
    session[:user] = Marshal.dump user
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
    result = Profile.all.select {|p| p.name == user_name}
    if (result.empty?)
      create_profile(user_sym)
    else
      result.first
    end
  end

  private 

    def setup_user(user_sym)
      profile = profile_for(user_sym)
      auth = OmniAuth.config.mock_auth[:default]
      Profile.all.each do |p|
        p.uid = "1"
        result = p.save
      end
      profile.uid = auth[:uid]
      profile.save
    end

    def profile_uids
      Profile.all.map do |p|
        "<#{p.name}: #{p.uid}>"
      end
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
      attrs = profile_data_for(user_sym)
      Profile.create! uid: "1", name: attrs[:name], roles: attrs[:roles]
    end
end