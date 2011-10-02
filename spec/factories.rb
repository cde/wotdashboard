FactoryGirl.define do
  factory :user do |f|
    f.name 'Juancito'
    f.email                 { Faker::Internet.email }
    f.password              'password'
    f.password_confirmation 'password'

  end
end
