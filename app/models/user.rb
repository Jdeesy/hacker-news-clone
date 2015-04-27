class User < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  has_many :posts
  has_many :comments

  def password
    @password ||= BCrypt::Password.new(self.password_digest)
  end

  def password=(user_input)
    @password = BCrypt::Password.create(user_input)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    @current_user = User.find_by_email(email)
    return @current_user if @current_user && @current_user.password == password
  end

end
