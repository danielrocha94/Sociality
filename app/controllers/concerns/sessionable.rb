module Sessionable
  extend ActiveSupport::Concern

  private

    def after_sign_in_path_for(resource)
      current_user
    end

    def logged_in_user
      unless user_signed_in?
        flash[:danger] = "Please log in."
        session[:forwarding_url] = request.url if  request.get?
        redirect_to new_user_session_url
      end
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def current_user?(user)
      user == current_user
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "Not enough permissions for this operation."
        redirect_to root_path
      end
    end

end
