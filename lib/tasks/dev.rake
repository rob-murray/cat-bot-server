namespace :dev do
  desc 'Creates sample data for local development'
  task setup: :environment do
    unless Rails.env.development?
      raise 'This task can only be run in the development environment'
    end

    create_users
  end

  def create_users
    header "Users"

    params = [
      { email: "test@test.com", password: "password" },
      { email: "api@test.com", password: "password" }
    ]
    puts "creating user: #{params}"
    User.create!(params)
  end

  def header(msg)
    puts "\n\n*** #{msg.upcase} *** \n\n"
  end
end
