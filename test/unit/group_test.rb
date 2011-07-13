require 'test_helper'


class GroupTest < ActiveSupport::TestCase
#  should validate_presence_of :name
#  should has_many :products, :dependent => :destroy
#  should has_many :companies, :through => :products

  context 'validations' do
    should validate_presence_of :name
    should have_many(:products).dependent(:destroy)
    should have_many(:companies).through(:products)
  end

end
