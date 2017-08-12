require 'rails_helper'

RSpec.describe Email, type: :model do
  describe "validations" do
    let(:email) {
      Email.create(
        body_content: "This email will try to get you to sign up",
        subject_content: "Sign up for this service please"
      )
    }

    it "is valid with valid attributes" do
      expect(email).to be_valid
    end

    it "is invalid without body content" do
      email.body_content = nil
      expect(email).to_not be_valid
      expect(email.errors.full_messages).to include("Body content can't be blank")
    end

    it "is invalid without subject content" do
      email.subject_content = nil
      expect(email).to_not be_valid
      expect(email.errors.full_messages).to include("Subject content can't be blank")
    end
  end

  describe "associations" do
    it "can have one campaign" do
      email = Email.create(
        body_content: "This email will try to get you to sign up",
        subject_content: "Sign up for this service please"
      )
      campaign = Campaign.create(title: "Sign up", initial_email: email)

      expect(email.campaign).to eq(campaign)
    end

    it "can have one next_email" do
      email = Email.create(
        body_content: "This email will try to get you to sign up",
        subject_content: "Sign up for this service please",
        next_email_attributes: {
          body_content: "This is the next email to get you to sign up",
          subject_content: "Sign up for this service so we don't have to keep harassing you"
        }
      )

      expect(email.next_email).to be_a(Email)
      expect(email.next_email.body_content).to eq("This is the next email to get you to sign up")
      expect(email.next_email.subject_content).to eq("Sign up for this service so we don't have to keep harassing you")
    end

    it "can have one next_campaign" do
      email = Email.create(
        body_content: "This email will try to get you to sign up",
        subject_content: "Sign up for this service please",
        next_campaign_attributes: {
          title: "This campaign is to get you to use our site",
          initial_email_attributes: {
            body_content: "Use our site by clicking this link",
            subject_content: "Use our service"
          }
        }
      )

      expect(email.next_campaign).to be_a(Campaign)
      expect(email.next_campaign.title).to eq("This campaign is to get you to use our site")
      expect(email.next_campaign.initial_email.body_content).to eq("Use our site by clicking this link")
    end
  end
end
