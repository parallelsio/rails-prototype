class MapsController < ApplicationController

  respond_to :html, :json

  def index
    @maps = Map.all

    respond_with(@maps)
  end

  def show
    @map = Map.find(params[:id])
    @clusters = @map.clusters
    @solo_bits = @map.bits

    # for form, drag and drop image functionality
    @bit = Image.new
    @bit.position_y = 30
    @bit.position_x = 100

  end

  def new
    @map = Map.new

  end

  def edit
    @map = Map.find(params[:id])
  end

  def create
    @map = Map.new(params[:map])

    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'Map was successfully created.' }
        format.json { render json: @map, status: :created, location: @map }
      else
        format.html { render action: "new" }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end


end
