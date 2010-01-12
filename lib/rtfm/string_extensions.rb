class String
  ##
  # Extends the string class so that it responds to the :to_groff
  # method. That way it can be treated like any other object in
  # the groff conversion system.
  #
  # @return [String] the string, in groff form. In other words, unchanged.
  def to_groff
    self
  end
end