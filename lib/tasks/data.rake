namespace :data do
  desc 'add new admin with default login and password'
  task :reset_admin => :environment do
    Admin.delete_all
    admin = Admin.new(:email => "a@b.com", :password => "123456")
    admin.save!
  end
  desc 'generation test data'
  task :add_content => :environment do
    db_data = YAML::load(File.read("#{Rails.root}/lib/tasks/data.yml"))
    Company.destroy_all
    Group.destroy_all
    Product.destroy_all

    db_data["companyname"].each do |company_name|
      company = Company.new(:name => company_name)
      company.photos.build(:photo => File.open("#{Rails.root}/lib/tasks/img/company/#{company_name}.jpg"))
      company.save!
    end

    db_data["groupname"].each do |group_name|
      group = Group.new(:name => group_name)
      group.photos.build(:photo => File.open("#{Rails.root}/lib/tasks/img/categories/#{group_name}.jpg"))
      group.save!
    end
  groups=Group.all.map(&:id)

    db_data["companyname"].each do |name|
      db_data["titles"].each do |title|
        Company.find_by_name("#{name}").products.create(:title => title,:group_id => groups[rand(groups.size)]) if title.include?("#{name}")
        end
    end



    #(0..rand(Product.all.count)).each do |index|
    #  discount = Discount.new(:value=>rand(999)-1000)
    #
    #  discount.save!
    #end

    Product.all.each do |product|
      product.update_attribute(:description, "SOME TEXT")
      product.update_attribute(:price,1+rand(30000-1))
      product.photos.build(:photo => File.open(Rails.root.join('lib','tasks','img','products',"#{product.title}.jpg")))
      product.save!
    end
    
  end

end
