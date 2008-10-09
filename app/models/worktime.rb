class Worktime < ActiveRecord::Base
  belongs_to :user
  
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
