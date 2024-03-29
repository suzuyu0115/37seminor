10.times do                            # userのダミーデータ
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "3150test",
    password_confirmation: "3150test"
  )
end

20.times do |index|                    # boardのダミーデータ
  Quest.create!(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    place: "上田の家",
    body: "本文#{index}",
    step: 0
  )
end
