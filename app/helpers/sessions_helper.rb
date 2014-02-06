module SessionsHelper

  def sign_in(user)
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Student.encrypt(remember_token))
    self.current_user = user
  end
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    $redis.set("sessions:#{cookies[:remember_token]}", user.attributes.to_json)
  end

  def current_user
    Student.new(JSON.parse($redis.get("sessions:#{cookies[:remember_token]}")))
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user?(user)
    user.id == current_user.id
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
