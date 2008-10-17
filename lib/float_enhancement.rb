module FloatEnhancement
  def precision(pre)
    mult = 10 ** pre
    (self * mult).truncate.to_f / mult
  end
end