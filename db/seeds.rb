User.delete_all

# Create Your User Profile
User.create(
  first_name:                 'David',
  last_name:                  'Christian',
  email:                      ENV['PERSONAL_EMAIL'],
  password:                   '12312312',
  password_confirmation:      '12312312',
  admin:                      true
)

# Generate Users
(1..20).each do |id|
  password = Faker::Internet.password(8)

  User.create(
    first_name:                 Faker::Name.first_name,
    last_name:                  Faker::Name.last_name,
    email:                      Faker::Internet.free_email,
    password:                   password,
    password_confirmation:      password
  )
end