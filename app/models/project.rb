class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks, :dependent => :destroy
  has_many :worktimes, :dependent => :destroy
  belongs_to :customer

  named_scope :finished, :conditions => {:finished => true}
  named_scope :active, :conditions => {:finished => false}
  named_scope :overdue, lambda { {:conditions => ["due_date < ? AND finished = ?", Date.today, false]} }
  named_scope :sorted, :order => "name asc"

  def editable_by?(user)
    user.is_admin
  end

  def viewable_by?(user)
    user.is_admin || user.projects.include?(self)
  end

  def finished?
    self.finished
  end

  def over_due?
    self.due_date < Date.today && !self.finished
  end

  def recent_worktimes_by(user, amount = 3)
     Worktime.find_all_by_project_id_and_user_id(self.id, user.id, :order => "updated_at DESC", :limit => amount)
  end

  def to_s
    self.name
  end

  # return array containing name & id for display on <select> comboboxes.
  def for_selectbox
    [self.name, self.id]
  end
end
