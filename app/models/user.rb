class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  # validates :name, presence: true, length: {maximum: 50}
  # validates :email, presence: true, length: {maximum: 255}

  # before_save {self.email = email.downcase }
  # before_save { email.downcase!}  # equivalent to the above commented statement
  before_save :downcase_email       # method reference preferred over a passed block (ch11)

  before_create :create_activation_digest

  validates(:name, {presence: true,
                     length: {maximum: 50}}
  )
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, {presence: true,
                     length: {maximum: 255},
                     format: {with: VALID_EMAIL_REGEX},
                     uniqueness: {case_sensitive: false},
  })
  has_secure_password
  validates(:password, {presence: true, length: {minimum: 6}, allow_nil: true })

  # returns hash digest of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random new token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remember a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")

    if digest  # only attempt to authenticate if a digest exists
      BCrypt::Password.new(digest).is_password?(token)
    else
      return false
    end

    # original:
    # authenticated?(remember_token)
    # ...
    # if remember_token BCrypt:... else return false
  end

  # forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # private section
  private

    # converts email to lowercase
    def downcase_email
      email.downcase!
    end

    # creates and assigns the activation token and digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(self.activation_token)
    end
  # end private
end
