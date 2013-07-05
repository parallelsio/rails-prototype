# TODO: by using STI, should I break apart BitsController into sublass controllers?
class BitsController < ApplicationController

  #TODO: prevent save of bit position below 0/0 until ZUI is implemented

  protect_from_forgery



  def show
    @bit = Bit.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  


  def new
    @bit = Bit.new

    # set position, if available
    if params[:position_x] && params[:position_y]
      @bit.position_x = params[:position_x]
      @bit.position_y = params[:position_y]
    end    

    respond_to do |format|
      format.html { render :layout => false }
    end
  end


  def create
    if params[:image]
      @bit = Image.new(params[:bit])
    else
      @bit = Text.new
      @bit.content = params[:bit][:content]      
    end

    @bit.position_x = params[:bit][:position_x]
    @bit.position_y = params[:bit][:position_y]

    @p = @bit.parallels.build
    @p.bind_to_closest_cluster

    respond_to do |format|
      if @bit.save
        format.js
      end
    end
  end





  def edit
    @bit = Bit.find(params[:id])

      respond_to do |format|
        format.html { render :layout => false }       
      end
  end


  def update
    @bit = Bit.find(params[:id])
    
    # what are we updating?
    # from the form, update only the content param
    # TODO: refactor, better way to test for form submit?
    if params[:commit] == "Save"
      update_hash = { :content => params[:bit][:content] } 

    #  via bit:drag, so update the position
    elsif params[:position_x] && params[:position_y]
      update_hash = { :position_x => params[:position_x], :position_y => params[:position_y] }
    end    

    respond_to do |format|
      if @bit.update_attributes(update_hash)
        format.js
      end
    end
  end






  def destroy
    @bit = Bit.find(params[:id])
    @bit.destroy

    respond_to do |format|
      format.js
    end
  end






end
