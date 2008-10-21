require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :name
  #validates_presence_of     :telephone
  #validates_presence_of     :street
  #validates_presence_of     :house_nr
  #validates_presence_of     :zip_code
  #validates_presence_of     :city
  #validates_presence_of     :birthdate
  #validates_presence_of     :is_admin
  
  
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :projects
  has_many :worktimes
  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation,
                  :telephone, :street, :house_nr, :zip_code, :city, :birthdate,
                  :icq_im, :jabber, :comment



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def admin?()
    self.is_admin
  end
  
  def can_view?(entry)
    entry.viewable_by?(self)
  end
  
  def can_edit?(entry)
    entry.editable_by?(self)
  end
  
  def editable_by?(user)
    user == self || user.is_admin
  end
  
  def assigned_to?(project)
    project.users.include?(self)
  end
  
  def first_name
    self.name.words[0]
  end
  
  def last_name
    self.name.gsub(self.first_name, "")
  end
  
  def short_name
    "#{self.first_name[0..0]}. #{self.last_name}"
  end
  
  def tasks_by_project(project)
    self.tasks.select{|t| t.project == project}.sort_by(&:due_date)
  end
  
  def worktimes_by_project(project)
    self.worktimes.select{|wt| wt.project == project}
  end
  
  protected

end
