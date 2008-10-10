module StringEnhancement
  def words(n = nil)
    @words = self.split(" ")
    if n
      @rest = self.split(" ").size > @words[0..(n-1)].size ? "..." : ""
      
      @words[0..(n-1)].join(" ") + @rest
    else
      @words
    end
  end
end
