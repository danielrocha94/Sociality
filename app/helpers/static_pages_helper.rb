module StaticPagesHelper
  def greeter
    if user_signed_in?
      "Welcome  #{current_user.first_name} "
    end
  end
end
