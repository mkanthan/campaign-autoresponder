require 'rails_helper'

RSpec.describe Email, type: :model do
  describe "validations" do
    subject {
      described_class.new(
        body_content: "This email will try to get you to sign up",
        subject_content: "Sign up for this service please"
      )
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without body content" do
      subject.body_content = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Body content can't be blank")
    end

    it "is invalid without subject content" do
      subject.subject_content = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Subject content can't be blank")
    end
  end
end
