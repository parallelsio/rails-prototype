class ClustersController < ApplicationController



  def show
    @cluster = Cluster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cluster }
    end
  end

  
end
