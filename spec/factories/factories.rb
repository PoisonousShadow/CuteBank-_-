FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
<<<<<<< HEAD
    user_is_admin{false}
  end

=======
    user_is_admin { false }
  end
>>>>>>> upstream/main
end
