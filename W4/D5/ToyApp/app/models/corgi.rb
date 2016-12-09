class Corgi < ActiveRecord::Base
  include Toyable
  has_many :toys
end
