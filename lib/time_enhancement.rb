module TimeEnhancement
  def german_time(format = :short)
    case format
      when :long
        self.strftime("%d.%m.%Y - %H:%M")
      else
        self.strftime("%d.%m.%Y")
    end
  end
end