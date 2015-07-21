# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

num_of_users = 15
num_of_surveys = 30

num_of_users.times do
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = Faker::Internet.free_email("#{first_name}.#{last_name}")
  username   = "#{first_name[0..3]}#{last_name[0..3]}#{(rand(99).to_s)}"
  password   = ['12345','54321'].sample
  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: email,
    username: username
  )
  user.email_confirmation = email
  user.password = password
  user.password_confirmation = password
  user.save
end

num_of_surveys.times do
  Survey.create(
    subject: Faker::Hacker.adjective,
    question: Faker::Hacker.say_something_smart
  )
end

Survey.all.each do |survey|
  User.all.sample(rand((num_of_users/5)..num_of_surveys)).each do |user|
    opinion = Opinion.create(answer: [true, false].sample)
    survey.opinions << opinion
    user.opinions << opinion
  end
end