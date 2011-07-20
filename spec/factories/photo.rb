Factory.define :photo, :class => Photo do |f|
  f.photo { File.new(Rails.root + 'spec/fixtures/images/rails.png')}
end
