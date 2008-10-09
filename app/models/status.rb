# stellt status (in prozent) dar
class Status

  attr_accessor :percentage
  
  def initialize(percentage)
    @percentage = percentage
  end
  
  def to_s
    "#{@percentage} %"
  end
  
  
  # static methods
  def self.all
    @@statuses ||= create_statuses
  end
  
  def self.find(what = :all)
    @@statuses ||= create_statuses
    
    if(what.kind_of? Fixnum )
      @@statuses.select{|x| x.percentage == what}.first
    elsif(what.kind_of? Symbol)
      case what
      when :all
        all
      end
    end 
  end
  
  protected
  
  def self.create_statuses
    @@statuses = (0..100).step(10).to_a.collect{|p| Status.new(p)}
  end
end
