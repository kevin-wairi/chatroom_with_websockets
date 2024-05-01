class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :recipient_id
      t.belongs_to :user, foreign_key: true
      t.belongs_to :chatroom, foreign_key: true

      t.timestamps
    end
  end
end
