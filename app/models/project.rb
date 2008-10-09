class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks
  belongs_to :customer
  
  named_scope :finished, :conditions => {:finished => true}  
  named_scope :active, :conditions => {:finished => false}
end
