class User < ActiveRecord::Base
  has_secure_password

  # :dependent => :delete_all, when User is deleted all Opinions from this user are deleted as well
  has_many :opinions, :dependent => :delete_all
  has_many :surveys, through: :opinions

  validates :email, confirmation: true # doesn't need to vaildate password confirmation, it must be added to #has_secure_password
  validates :first_name, :last_name, :email, :email_confirmation, presence: true
  validates :email, uniqueness: true

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "must be an email address" }

  before_create { generate_token :auth_token }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.email_confirmation = self.email
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
