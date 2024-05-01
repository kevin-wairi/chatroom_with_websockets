class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.belongs_to :chatroom, foreign_key: true
      t.timestamps
    end
  end
end
