class LegalGuardian < User
  def set_role
    self.add_role :legal_guardian
  end
end
