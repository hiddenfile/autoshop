Factory.define :product, :class => Product do |f|
    f.title 'asdadasd'
    f.description 'asdadafdfghdrfgwefwefge'
    f.association :price
    f.association :company
    f.association :group
end