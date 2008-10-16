class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :worktimes
  belongs_to :project
  
  named_scope :active, :conditions => {:status => 0..100}
  named_scope :finished, :conditions => {:status => 100}
  named_scope :parents, :conditions => {:parent_id => nil}
  
  # gibt alle kinder-tasks zurück (tasks ohne eigene kinder)
  # (entspricht den blättern in einem baum)
  def self.children
    Task.find(:all).select{|t| t.children.size == 0}
  end
    
  # gibt eltern-task von diesem task zurück
  def parent
    if self.parent_id
      begin
        Task.find(self.parent_id)
      rescue ActiveRecord::RecordNotFound => ex
        nil
      end
    else
      nil
    end  
  end
  
  # gibt liste von kinder-tasks von diesem task zurück (kann leer sein)
  def children
    Task.find(:all, :conditions => ["parent_id = ?", self.id])
  end
  
  def total_worktime
    self.worktimes.inject(0.0) do |total, worktime|
      total + worktime.length
    end
  end
  
  def editable_by?(user)
    user.is_admin || self.users.include?(user) 
  end
  
  def viewable_by?(user)
    user.is_admin || self.users.include?(user)
  end
  
  # vor dem löschen des tasks alle verweise in den worktimes löschen, die diesem task angehören
  # falls ein worktime daraufhin keine task-referenzen mehr besitzt, kann das worktime auch gelöscht werden.
  def before_destroy()
    remove_all_worktimes
  end
  
  def remove_all_worktimes
    self.worktimes.each do |worktime|
      worktime.remove_from_task(self)
      worktime.save
      if worktime.tasks.empty?
        worktime.destroy
      end
    end
  end
end
