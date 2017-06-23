module AuthHelper

  ADMIN_UID = "admin"
  NORM_UID = "norm"

  Profile.extend RecordExtensions

  def self.use_fake_for_profiles
    Profile.extend FakeDataset::WithFakeDataset
  end

  def login_as user_name
    logout
    user = user_for user_name
    puts "Request env: #{@request.env['omniauth.auth']}"
    @request.env['omniauth.auth'] = {uid: user.uid, image: user.image_url}
    puts "Request env: #{@request.env['omniauth.auth']}"
    get auth_google_oauth2_callback_url
  end

  def logout
    get logout_url
  end

  private 

    def user_for user_name
      Profile.delete_all
      @users ||= {
        admin: create_user(uid: ADMIN_UID, name: "Admin User", image: "http://admin.test.com", roles: [:admin]),
        normal: create_user(uid: NORM_UID, name: "Normal User", image: "http://norma.test.com", roles: [])
      }
      return @users[user_name]  
    end

    def create_user attrs
      user = AuthUser.new attrs[:uid], attrs[:image]
      profile = Profile.create! uid: attrs[:uid], name: attrs[:name], roles: attrs[:roles]
      user.profile = profile
      return user
    end
end