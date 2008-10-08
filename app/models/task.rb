class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :project
  
  def parent
    if self.parent_id
      begin
        Task.find(self.parent_id))
      rescue ActiveRecord::RecordNotFound => ex
        nil
      end
    else
      nil
    end  
  end
  
  def children
    Task.find(:all, :conditions => ["parent_id = ?", self.id])
  end
  
end
