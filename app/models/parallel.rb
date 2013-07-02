class Parallel < ActiveRecord::Base
	
	belongs_to :cluster
	belongs_to :bit

	def bind_to_closest_cluster

		#TODO: method to calc distance of new bit to closest cluster.
		# overlapping clusters?
		self.cluster_id = Cluster.first.id
	end


end