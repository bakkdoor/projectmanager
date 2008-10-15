class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks
  has_many :worktimes
  belongs_to :customer
  
  named_scope :finished, :conditions => {:finished => true}  
  named_scope :active, :conditions => {:finished => false}
  
  def editable_by?(user)
    user.is_admin
  end
  
  def viewable_by?(user)
    user.is_admin || user.projects.include?(self)
  end
end
