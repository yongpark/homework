class Cat < ActiveRecord::Base
  include Toyable
  has_many :toys
end
