class User::CampaignGraph

  attr_reader :advanced

  def initialize(user)
    @user = user
    @advanced = false
  end

  def start
    @user.current_campaign = Campaign.find_by_root(true)
    @user.current_email = @user.current_campaign.initial_email
    @user.save!
    @advanced = true
  end

  def advance_for_delay
    @advanced = false
    if @user.current_email.next_email
      @user.current_email = @user.current_email.next_email
      @advanced = true
    else
      advance_for_branch
    end
    @user.save!
  end

  def advance_for_branch
    @advanced = false
    if @user.current_email.next_campaign
      @user.current_campaign = @user.current_email.next_campaign
      @user.current_email = @user.current_campaign.initial_email
      @advanced = true
    end
    @user.save
  end
end