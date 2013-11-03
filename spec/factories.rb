Factory.define :user do |user|
  user.name                  "youstina atef"
  user.email                 "youstina.atef@yahoo.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end
