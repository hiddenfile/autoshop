Factory.define :user, :class => User do |f|
    f.email 'test@mail.com'
    f.password "qwerty"
    f.password_confirmation {|u| u.password}
end