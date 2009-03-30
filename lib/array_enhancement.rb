module ArrayEnhancement
  def to_array_string
    array_string = "[\""
    array_string += self.join("\",\"")
    array_string += "\"]"
  end
end
