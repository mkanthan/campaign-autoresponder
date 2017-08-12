class Email < ApplicationRecord
  belongs_to :campaign, foreign_key: "initial_email_id", inverse_of: 'initial_email', optional: true
  belongs_to :next_campaign, class_name: "Campaign", optional: true
  has_one :next_email, class_name: "Email", foreign_key: "next_email_id"

  accepts_nested_attributes_for :next_email
  accepts_nested_attributes_for :next_campaign
  validates_presence_of :body_content, :subject_content
end
