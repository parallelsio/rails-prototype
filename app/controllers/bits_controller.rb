class BitsController < ApplicationController

  #TODO: prevent save of bit position below 0/0 until ZUI is implemented

  protect_from_forgery

################################################################


  def show
    @bit = Bit.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end


################################################################

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


################################################################

  def create

    if params[:bit] && params[:bit][:content]
      @bit = Text.new
      @bit.content = params[:bit][:content]   
      @bit.position_x = params[:bit][:position_x]
      @bit.position_y = params[:bit][:position_y]
    
    else
      @bit = Image.new

      if params[:commit]  # via form (manual click Choose Files, Save)
        @bit.position_x = params[:bit][:position_x]
        @bit.position_y = params[:bit][:position_y]
        @bit.image = params[:bit][:image]

      else   # via drag and drop, auto Save + upload        
        @bit.image = params[:file]
        @bit.position_x = params[:position_x]
        @bit.position_y = params[:position_y]
      end

      # calc offsets if multiple images are dragged at once
      @bit.cascade_position 
    end

    # TODO: this is probably not secure. 
    # tie map retrieval to session/user
    map_id = request.env["HTTP_REFERER"].split('/').last
    @map = Map.find(map_id)

    @p = @map.parallels.build
    @p.bit = @bit
    @p.save

    if @bit.save
        if @bit.type == "Image"
          render json: @bit
        elsif @bit.type == "Text"
          render :create  
        end
    
    else
      render json: @bit.errors, status: :unprocessable_entity 
    end

  end



################################################################

  def edit
    @bit = Bit.find(params[:id])

    render :layout => false 
  end


################################################################

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


################################################################
  def destroy
    @bit = Bit.find(params[:id])
    @bit.destroy

    render :nothing => true
  end


################################################################
  def shatter
    
    @source_bit = Bit.find(params[:id])
    
  end





end
