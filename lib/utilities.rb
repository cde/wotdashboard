class String
  def gsub_percentage
    number = self.gsub(" %", "").gsub(",", ".")
    number.to_f
  end
end
