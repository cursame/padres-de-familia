class Student < User
  def set_role
    self.add_role :student
  end
end
