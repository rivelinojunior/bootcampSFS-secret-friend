class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    begin
      results = RaffleService.new(campaign).call
      campaign.members.each(&:set_pixel)
      results.each do |r|
        CampaignMailer.raffle(campaign, r.first, r.last).deliver_now
      end
      campaign.update(status: :finished)
    rescue
      CampaignMailer.error_raffle(campaign).deliver_now
    end
  end
end
