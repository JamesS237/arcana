module StudentsHelper
  def current_user
    return nil unless json = $redis.get("sessions:#{cookies[:remember_token]}")
    Student.new(JSON.parse(json))
  end
end
