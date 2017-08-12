class User::CampaignGraph

  def initialize(user)
    @user = user
  end

  def start
    @user.current_campaign = Campaign.find_by_root(true)
    @user.current_email = @user.current_campaign.initial_email
    @user.save!
  end

  def advance_for_delay
    if @user.current_email.next_email
      @user.current_email = @user.current_email.next_email
    else
      advance_for_branch
    end
    @user.save!
  end

  def advance_for_branch
    if @user.current_email.next_campaign
      @user.current_campaign = @user.current_email.next_campaign
      @user.current_email = @user.current_campaign.initial_email
    end
    @user.save
  end
end