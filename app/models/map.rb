class Map < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :clusters
  has_many :bits
  
end
