require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "validations" do
    let(:campaign) {
      Campaign.create(
        title: "This campaign is to get you to sign up"
      )
    }

    it "is valid with valid attributes" do
      expect(campaign).to be_valid
    end

    it "is invalid without a title" do
      campaign.title = nil
      expect(campaign).to_not be_valid
      expect(campaign.errors.full_messages).to include("Title can't be blank")
    end
  end

  describe "associations" do
    it "should have one initial email" do
      campaign = Campaign.create(
        title: "This campaign is to get you to sign up",
        initial_email_attributes: {
          body_content: "Sign up by clicking this link",
          subject_content: "Sign up for this service"
        }
      )

      expect(campaign.initial_email).to be_a(Email)
      expect(campaign.initial_email.body_content).to eq("Sign up by clicking this link")
      expect(campaign.initial_email.subject_content).to eq("Sign up for this service")
    end
  end
end
