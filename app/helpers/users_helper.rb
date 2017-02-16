module UsersHelper

  # Returns the Gravatar for the given user.


  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # size = options[:size]

    # 2017.02.16, ex 7.4.4.1 - this if block has error
    # ActionView::Template::Error: nil is not a valid asset source app/helpers/users_helper.rb:21:in `gravatar_for'

    # getting images to display on development versus production
    # http://stackoverflow.com/questions/38222989/gravatar-image-not-displaying
    # if Rails.env.production?
    #    puts "console: i'm in production!"
    #    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # elsif Rails.env.development?
    #   # still doesn't work ?_?
    #   puts "console: i'm in development!"
    #   gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # end

    # error is on ghostery - it blocks gravatar's redirects
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
