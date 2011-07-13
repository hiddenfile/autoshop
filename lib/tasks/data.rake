namespace :data do
  desc 'add new admin with default login and password'
  task :reset_admin => :environment do
        Admin.delete_all
        admin = Admin.new(:email => "a@b.com", :password => "123456")
        admin.save!
      end
end
