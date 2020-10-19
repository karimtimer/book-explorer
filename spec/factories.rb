FactoryBot.define do
  factory :upload do
    url { "some.url" }
    name { "filename" }
    aws_filename { "awsfilename" }
    user
  end

  factory :user do
    email { "duck@world.com" }
    username { "duck" }
    password { "password" }
  end
end
