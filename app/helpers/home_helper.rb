module HomeHelper
  
  def status_background(finishable)
    @style = ""
    if finishable.finished?
      @style = "background-color:#B1FFA2"   
    elsif finishable.over_due?
      @style = "background-color:#E37064"
    end
    
    @style
  end
  
end
