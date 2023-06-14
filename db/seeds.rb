User.create!(name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)
60.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "111111"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end
users = User.order(:created_at).take(6)
10.times do
  body = Faker::Lorem.sentence(word_count: 5)
  title = Faker::Lorem.sentence(word_count: 5)
  status = :pending
  users.each { |user| user.articles.create!(body: body, title: title, status: status) }
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
