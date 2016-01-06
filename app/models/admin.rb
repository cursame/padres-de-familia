class Admin < User
  def set_role
    self.add_role :admin
  end
end
