module UsersHelper
  def gravatar_for(user, options = { size: 150 , class: 'gravatar img-circle'})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    klass = options[:class]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, :class => klass)
  end
end
