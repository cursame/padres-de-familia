class Teacher < User
  def set_role
    self.add_role :teacher
  end
end
