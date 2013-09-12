class SessionsController < ApplicationController
  def new
  end

  def create
    user = Student.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
  private
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = Student.find_by_name(params[:id].gsub('-', ' '))
      redirect_to(root_url) unless current_user?(@user)
    end
    
      def admin_user
      redirect_to(root_url) unless current_user.status == 3
    end
    
      def sign_in(user)
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Student.encrypt(remember_token))
    self.current_user = user
  end
      def current_user=(user)
    @current_user = user
  end
end
