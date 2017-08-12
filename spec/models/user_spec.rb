require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) {
      User.create(
        first_name: "Manu",
        last_name: "Kanthan",
        email: "test@example.com"
      )
    }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email address" do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid without a first_name" do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "is not valid without a last_name" do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe "associations" do
    let(:user) {
      User.create(
        first_name: "Manu",
        last_name: "Kanthan",
        email: "test@example.com"
      )
    }

    it "can have a current email" do
      e = Email.create(subject_content: "initial email", body_content: "Initial sign up")
      user.current_email = e
      user.save
      expect(user.current_email).to eq(e)
    end

    it "can have a current campaign" do
      c = Campaign.create(title: "Main campaign")
      user.current_campaign = c
      user.save
      expect(user.current_campaign).to eq(c)
    end
  end
end
