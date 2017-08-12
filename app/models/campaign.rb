class Campaign < ApplicationRecord
  has_one :initial_email, class_name: "Email", foreign_key: "campaign_id", inverse_of: 'campaign'
  accepts_nested_attributes_for :initial_email
  validates_presence_of :title
end
