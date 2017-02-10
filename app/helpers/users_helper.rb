module UsersHelper
  def gravatar_for(user, options = {size: 200, style: 'profile'})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    style = options[:style].to_sym
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag((user.profile_picture.exists? ? user.profile_picture.url(style) : gravatar_url), alt: user.first_name , class: "gravatar")
  end

  def gravatar_link_for(user, options = {size: 200, style: 'profile'})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    style = options[:style].to_sym
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    user.profile_picture.exists? ? user.profile_picture.url(style) : gravatar_url
  end

  def full_name(user)
    @user.first_name + " " + @user.last_name
  end
end
