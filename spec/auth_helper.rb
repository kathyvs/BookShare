module AuthHelper

  ADMIN_UID = "admin"
  NORM_UID = "norm"

  Profile.extend RecordExtensions

  def self.use_fake_for_profiles
    Profile.extend FakeDataset::WithFakeDataset
  end

  def login_as user_name
    logout
    print "**Request auth = #{@request.env['omniauth.auth']}"
    get auth_google_oauth2_callback_url, env: { "omniauth.auth" => user_for(user_name), test: "Test" }
  end

  def logout
    get logout_url
  end

  private 

    def user_for user_name
      Profile.delete_all
      @users ||= {
        admin: create_user(:admin, uid: ADMIN_UID, name: "Admin User", image: "http://admin.test.com", roles: [:admin]),
        normal: create_user(:normal, uid: NORM_UID, name: "Normal User", image: "http://norma.test.com", roles: [])
      }
      return @users[user_name]  
    end

    def create_user(key, attrs)
      user = AuthUser.new attrs[:uid], attrs[:image]
      OmniAuth.config.add_mock(key, {
        :uid => user.uid,
        :info => {
          :name => key.to_s,
          :image => user.image_url
        }
      })
      profile = Profile.create! uid: attrs[:uid], name: attrs[:name], roles: attrs[:roles]
      user.profile = profile
      return OmniAuth.config.mock_auth[key]
    end
end