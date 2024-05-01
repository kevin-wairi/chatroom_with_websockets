class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.string :sender_id
      t.string :recipient_id
      t.timestamps
    end
  end
end
