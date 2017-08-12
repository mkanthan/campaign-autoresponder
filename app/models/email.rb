class Email < ApplicationRecord
  validates_presence_of :body_content, :subject_content
end
