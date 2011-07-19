Factory.define :admin, :class => Admin do |f|
    f.email 'email'
    f.password "qwerty"
    f.password_confirmation {|u| u.password}
end