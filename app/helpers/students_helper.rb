module StudentsHelper
  def current_user
    remember_token = Student.encrypt(cookies[:remember_token])
    @current_user ||= Student.find_by(remember_token: remember_token)
  end
end
