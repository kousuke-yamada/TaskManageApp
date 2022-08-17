# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
99.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password,
                admin: false)
end

puts "Users Created"

5.times do |user_id|
  user = User.find(user_id + 1)
  
  50.times do |n|
    task_name = "タスク#{n + 1}"
    description = "タスク詳細#{n + 1}"
    
    user.tasks.create!(name: task_name, description: description)
  end
end

puts "Tasks Created"