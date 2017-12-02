class Campaign < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  
  before_create :set_status
  before_create :set_member
  
  private 
    def set_status
      self.status = 'pending'
    end

    def set_member
      self.members << Member.create(name: self.user.name, email: self.user.email)
    end
end
