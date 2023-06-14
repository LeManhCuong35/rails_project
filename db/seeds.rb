15.times do |n|
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
