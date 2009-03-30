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

  def to_string_array
#    chars = self.chars.to_a
    chars = []
    self.each_char do |c|
      chars << c
    end
    chars -= ["["]
    chars -= ["]"]
    array = chars.join().split(/\"\s*,\s*\"/)

    array.collect do |word|
      tmp = word
      if tmp.first == "\""
        tmp = tmp[1..-1]
      end
      if tmp.last == "\""
        tmp = tmp[0..-2]
      end

      tmp
    end
  end
end
