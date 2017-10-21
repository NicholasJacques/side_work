module SessionHelper
  def sign_in(profile)
    page.set_rack_session(user_id: profile.user.id)
  end
end
