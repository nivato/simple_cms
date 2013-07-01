require 'digest/sha1'

class AdminUser < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :username
  attr_protected :hashed_password, :salt
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  
  scope :sorted, order("admin_users.last_name ASC, admin_users.first_name ASC")
  
  attr_accessor :password
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  # Standard validation methods
  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :format => EMAIL_REGEX
  # validates_confirmation_of :email
  
  # "Sexy" validation
  validates :first_name, :presence => true, :length => {:maximum => 25}
  validates :last_name, :presence => true, :length => {:maximum => 50}
  validates :username, :length => {:within => 8..25}, :uniqueness => true
  validates :email, :presence => true, :length => {:maximum => 100}, :format => EMAIL_REGEX, :confirmation => true
  # only on create, so other attributes of this user can be saved
  validates_length_of :password, :within => 8..25, :on => :create
  validates_confirmation_of :password, :on => :create
  
  # callbacks
  before_save :create_hashed_password
  after_save :clear_password
  
  def self.make_salt(username="")
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA2.hexdigest("Put #{salt} on the #{password}")
  end
  
  def self.authenticate(username="", password="")
    user = AdminUser.find_by_username(username)
    if user && user.does_password_match(password)
      return user
    else
      false
    end
  end
  
  def does_password_match(password="")
    hashed_password == AdminUser.hash_with_salt(password, salt)
  end
  
  def name
    return "#{first_name} #{last_name}"
  end
  
  # everything goes below "private" - is private
  private
  
  def create_hashed_password
    unless password.blank?
      # always use "self" when assigning values
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end
  
end
