class User < ApplicationRecord
  belongs_to :current_email, class_name: "Email", foreign_key: "current_email_id", optional: true
  belongs_to :current_campaign, class_name: "Campaign", foreign_key: "current_campaign_id", optional: true

  validates_presence_of :email, :first_name, :last_name
end
