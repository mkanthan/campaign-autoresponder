class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :current_email_id
      t.datetime :current_email_sent
      t.integer :current_campaign_id
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
  end
end
