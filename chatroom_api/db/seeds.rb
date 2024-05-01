
Message.destroy_all
User.destroy_all
Chatroom.destroy_all

User.create(username:"john",password:"doe")
User.create(username:"jane",password:"doe")
User.create(username:"munyiz",password:"123")

puts 'Done seeding'