module UsersHelper

  # Returns the Gravatar for the given user.

  # getting images to display on development versus production
  # http://stackoverflow.com/questions/38222989/gravatar-image-not-displaying
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    if Rails.env.production?
      # puts 'hi'
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    elsif Rails.env.development?
      # puts 'bye'
      gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}"
    end
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
