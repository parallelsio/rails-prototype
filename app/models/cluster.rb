class Cluster < ActiveRecord::Base

	 has_many :parallels
  	 has_many :bits, through: :parallels

end