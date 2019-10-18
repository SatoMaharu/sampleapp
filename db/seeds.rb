# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
100.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

3.times do |user_id|
  user_id += 1
  50.times do |n|
    name = "サンプル#{n+1}"
    note = "サンプルです。"
    Task.create!(name: name,
                 note: note,
                 user_id: user_id)
  end 
end 