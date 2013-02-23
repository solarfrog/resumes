class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :password, :password_confirmation
  
#  before_save :encrypt_password
#  after_save :clear_password

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true
  #Only on Create so other actions like update password attribute can be nil
  validates_length_of :password, :in => 6..20, :on => :create

  attr_accessible :username, :email, :password, :password_confirmation

  def self.authenticate(username_or_email="", login_password="")
   if  EMAIL_REGEX.match(username_or_email)    
      user = User.find_by_email(username_or_email).try(:authenticate, login_password)
    else
      user = User.find_by_username(username_or_email).try(:authenticate, login_password)
    end

#    if user && user.match_password(login_password)
#      return user
#    else
#      return false
#    end
  end   

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

end