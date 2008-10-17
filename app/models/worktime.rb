class Worktime < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  has_and_belongs_to_many :tasks
  
  validates_presence_of :user_id
  validates_presence_of :start_time
  validates_presence_of :end_time
  
  named_scope :recent, lambda { |date| {:conditions => ["updated_at > ?", date]} }
  
  def validate()
     errors.add_to_base("Dauer darf nicht kleiner als 0 Minuten sein.") if self.start_time > self.end_time
  end
  
  def length=(amount_hours)
    # nur setzen, falls positiver wert übergeben.
    if(amount_hours.to_f > 0.0 && self.start_time)
      self.end_time = self.start_time + amount_hours.to_f.hours
    end
  end
  
  def length
    if self.end_time && self.start_time
      (((self.end_time - self.start_time) / 3600)).precision(2)
    else
      1 # fall noch nichts angegeben, standardmäßig 1 stunde
    end
  end
  
  def length_in_minutes
    ((self.end_time - self.start_time) / 60).precision(2)
  end
  
  def viewable_by?(user)
    true # erstmal für alle einsehbar
  end
  
  def editable_by?(user)
    user.is_admin || self.user == user
  end
  
  def remove_from_task(task)
    self.tasks.remove(task)
  end
end
