#MANDATORY

#Participant group roles
roles = ["manager", "member"]
roles.each do |name, i|
  role = ParticipantGroupRole.new
  role.name = name
  if ParticipantGroupRole.where(name: role.name).blank?
    puts "Role:" << role.name
    role.save
  else
    puts "Skipped role:" << role.name
  end
end

#Participant roles
roles = ["manager", "chair", "delegate", "director", "ambassador"]
roles.each do |name, i|
  role = ParticipantRole.new
  role.name = name
  if ParticipantRole.where(name: role.name).blank?
    puts "Role:" << role.name
    role.save
  else
    puts "Skipped role:" << role.name
  end
end

#Roles
roles = ["administrator"]
roles.each do |name, i|
  role = Role.new
  role.name = name
  if Role.where(name: role.name).blank?
    puts "Role:" << role.name
    role.save
  else
    puts "Skipped role:" << role.name
  end
end



#administrator = User.find_or_create_by_email :name => "Administrator".dup, :email => "admin@un.org".dup, :password => "munmunmun".dup, :password_confirmation => "munmunmun".dup
#administrator.initial_role = "administrator"
#puts 'Administrator: ' << administrator.name


#ENVIRONMENTS

if Rails.env.development? || Rails.env.test?
  puts 'DEV/TEST'
  #puts 'USERS'
  #user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup, :confirmed_at => Time.now
  #puts 'Musician-user: ' << user.name

  #studio_user = User.find_or_create_by_email :name => "Abbey".dup, :email => "abbey@road.com".dup, :password => "changeme".dup, :password_confirmation => "changeme".dup, :confirmed_at => Time.now, :studio_flag => true
  #puts 'Studio-user: ' << studio_user.name

  if false
    puts 'STUDIOS'
    1.upto(110) do |i|

      u = User.find_or_create_by_email :name => Faker::Name.name.dup, :email => "user#{i}#{DateTime.now.to_s}@broken-music.de".dup, :password => "12345678".dup, :password_confirmation => "12345678".dup, :confirmed_at => Time.now
      u.initial_role = "Studio"
      puts 'U: ' << u.name
      u.save

      s = u.studios.create :name => Faker::Name.title, :zipcode => "1234", :telephone_number => "12345678", :city  => Faker::Address.city, :street => Faker::Address.street_name, :longitude => Faker::Address.longitude, :latitude => Faker::Address.latitude, :teaser => Faker::Company.catch_phrase, :description => Faker::Company.catch_phrase, :references => Faker::Company.catch_phrase
      case rand(1..3)
        when 1
          s.premium_studio = true
        when 2
          s.standard_studio = true
        else
          s.home_engineer = true
      end


      s.save
      puts 'S:' << s.name
      puts s.inspect

      1.upto(3) do |j|
        o = Offering.new(studio_id: s.id, product_id: 1, pricePerDay: Faker::Number.digit, pricePerHour: Faker::Number.digit)
        o.save
        puts 'O:' << o.product.translated_title
      end
    end
  end
end
