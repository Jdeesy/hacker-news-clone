class User < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def password
    @password ||= BCrypt::Password.new(self.password_digest)
  end

  def password=(user_input)
    @password = BCrypt::Password.create(user_input)
    self.password_digest = @password
  end

  def self.authenticate(session_params)
    @current_user = User.find_by_email(session_params[:email])
    return @current_user if @current_user && @current_user.password == session_params[:password]
  end

  before_save do
    self.email.downcase! if self.email
  end
end
