module StringEnhancement
  def words(n = nil)
    @words = self.split(" ")
    
    if n
      @words[0..(n-1)].join(" ")
    else
      @words
    end
  end
end
