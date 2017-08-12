class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.text :body_content
      t.text :subject_content
      t.integer :campaign_id
      t.integer :hours_delay
      t.integer :next_email_id
      t.integer :next_campaign_id

      t.timestamps
    end
  end
end
