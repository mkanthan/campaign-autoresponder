require 'rails_helper'

RSpec.describe User::CampaignGraph do
  let(:user) {
    User.create(first_name: "Manu", last_name: "Kanthan", email: "mkanthan@example.com")
  }

  before do
    @feature_email1 = Email.create(subject_content: "Try Feature A here", body_content: "Click this link to access Feature A")
    @feature_campaign = Campaign.create(title: "Feature A", initial_email: @feature_email1)

    @onboarding_email2 = Email.create(subject_content: "You haven't set up your account yet", body_content: "Set it up here")
    @onboarding_email1 = Email.create(
      subject_content: "Use this guide to set up your account",
      body_content: "Click this link", next_email: @onboarding_email2, next_campaign: @feature_campaign
    )
    @onboarding_campaign = Campaign.create(title: "Onboarding", root: true, initial_email: @onboarding_email1)

    @improvement_email2 = Email.create(
      subject_content: "Help us improve",
      body_content: "Click this link"
    )
    @improvement_email1 = Email.create(
      subject_content: "We'd love to improve our service",
      body_content: "Let us know what we can do", next_email: @improvement_email1
    )
    @improvement_campaign = Campaign.create(title: "Better service", initial_email: @improvement_email1)
    @onboarding_email2.next_campaign = @improvement_campaign
    @onboarding_email2.save!
  end

  describe "initialize" do
    it "should initialize with a user" do
      expect(User::CampaignGraph.new(user)).to_not be_nil
    end
  end

  describe "start" do
    it "should set the current campaign and email to the root campaign with its first email" do
      graph = User::CampaignGraph.new(user)

      graph.start

      expect(user.current_campaign).to eq(@onboarding_campaign)
      expect(user.current_email).to eq(@onboarding_campaign.initial_email)
      expect(graph.advanced).to eq(true)
    end
  end

  describe "advance_for_delay" do
    before do
      @graph = User::CampaignGraph.new(user)
      @graph.start
    end

    it "should advance the user's email to the next email in the graph while keeping the same campaign" do
      @graph.advance_for_delay

      expect(user.current_campaign).to eq(@onboarding_campaign)
      expect(user.current_email).to eq(@onboarding_email2)
      expect(@graph.advanced).to eq(true)
    end

    it "should advance to the next campaign and its initial email if there is no next email" do
      @graph.advance_for_delay
      @graph.advance_for_delay

      expect(user.current_campaign).to eq(@improvement_campaign)
      expect(user.current_email).to eq(@improvement_email1)
      expect(@graph.advanced).to eq(true)
    end
  end

  describe "advance_for_branch" do
    before do
      @graph = User::CampaignGraph.new(user)
      @graph.start
    end

    it "should advance to the next campaign and its initial email" do
      @graph.advance_for_branch

      expect(user.current_campaign).to eq(@feature_campaign)
      expect(user.current_email).to eq(@feature_email1)
      expect(@graph.advanced).to eq(true)
    end

    it "should do nothing if it has reached the end of the campaigns" do
      @graph.advance_for_branch
      @graph.advance_for_branch

      expect(user.current_campaign).to eq(@feature_campaign)
      expect(user.current_email).to eq(@feature_email1)
      expect(@graph.advanced).to eq(false)
    end
  end
end