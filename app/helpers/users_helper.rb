module UsersHelper

  # Returns the Gravatar for the given user.


  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # size = options[:size]

    # getting images to display on development versus production
    # http://stackoverflow.com/questions/38222989/gravatar-image-not-displaying
    if Rails.env.production?
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    elsif Rails.env.development?
      # still doesn't work ?_?
      gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end

    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
