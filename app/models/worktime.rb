class Worktime < ActiveRecord::Base
  belongs_to :user
  
  has_and_belongs_to_many :tasks
  
  validates_presence_of :user_id
  validates_presence_of :start_time
  validates_presence_of :end_time
  
  def length=(amount_hours)
    # nur setzen, falls positiver wert übergeben.
    if(amount_hours.to_f > 0.0 && self.start_time)
      self.end_time = self.start_time + amount_hours.to_f.hours
    end
  end
  
  def length
    if self.end_time && self.start_time
      ((self.end_time - self.start_time) / 3600)
    else
      1 # fall noch nichts angegeben, standardmäßig 1 stunde
    end
  end
end
