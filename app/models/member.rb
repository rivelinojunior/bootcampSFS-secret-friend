class Member < ApplicationRecord
  belongs_to :campaign
  after_save :set_campaign_pending
  after_destroy :set_campaign_pending
  validates :name, :email, :campaign, presence: true
  validate :uniqueness_member_by_campaign

  def set_pixel
    self.open = false
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Member.exists?(token: random_token)
    end
    save!
  end

  protected

  def set_campaign_pending
    campaign.update(status: :pending)
  end

  private

  def uniqueness_member_by_campaign
    errors.add(:name, 'Esse membro já foi adicionado.') unless campaign && 
                                                        campaign.members
                                                                .where.not(id: id)
                                                                .find_by(email: email, name:name).nil?
  end
end
