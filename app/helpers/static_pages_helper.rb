module StaticPagesHelper
  def greeter
    if user_signed_in?
      "Welcome  #{current_user.email} "
    end
  end
end
