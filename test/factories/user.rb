FactoryGirl.define :user, :class => User do |f|
    f.email 'mail'
    f.password "123456"
    f.password_confirmation {|u| u.password}
end