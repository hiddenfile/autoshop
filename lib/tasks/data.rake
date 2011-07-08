namespace :data do
  desc 'add new admin with default login and password'
  task :reset_admin => :environment do
        Admin.delete_all
        admin = Admin.new(:email => "admin@testdomain.ua", :password => "12345")
        admin.save!
      end
end
