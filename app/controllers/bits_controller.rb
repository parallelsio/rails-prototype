class BitsController < ApplicationController

  #TODO: prevent save of bit position below 0/0 until ZUI is implemented

  protect_from_forgery

  before_filter :this_map

  # TODO: this is probably not secure. 
  # tie map retrieval to session/user
  def this_map
    @map = Map.find(request.env["HTTP_REFERER"].split('/').last)
  end



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

    # use defaults, unless user specified something otherwise
    number_of_tiles_across = params[:number_of_tiles_across].to_i
    number_of_tiles_tall = params[:number_of_tiles_tall].to_i
   
    # calculate percentages to feed convert method, based on number of tiles
    vertical_percent    = 100 / number_of_tiles_tall
    horizontal_percent  = 100 / number_of_tiles_across

    @source_bit = Bit.find(params[:id])
    image = ImageSorcery.new(@source_bit.image_url)

    # image_sorcery calls command line imagemagick command, saves in temp dir
    # splitting into parts because we'll need to inject the 
    # tile number into filename
    tiles = Hash.new  
    
    tiles[:relative_directory]   = "tmp/image_sorcery/#{ @source_bit.id }"
    tiles[:absolute_directory]   = File.join(Rails.root, tiles[:relative_directory])

    tiles[:base_file_name]      = "#{ File.basename(image.file, File.extname(image.file)) }_tile"
    tiles[:extension_type]      = File.extname(image.file) 

    tiles[:relative_filename]   = "#{tiles[:relative_directory]}/#{tiles[:base_file_name]}#{tiles[:extension_type]}"
    tiles[:count]               = number_of_tiles_across * number_of_tiles_tall

    # TODO: how to prevent files from gathering from orphaned processes
    # path used is relative to Rails.root
    Dir.mkdir(tiles[:absolute_directory], 0700) unless Dir.exists?(tiles[:absolute_directory])

    status = image.convert(tiles[:relative_filename], quality: 80, crop: "#{ vertical_percent }%x#{ horizontal_percent }", scene: 1)
    @bits = []

    if status

        # instead of iterating straight through to tiles[:count],
        # go by columns and rows, in order to calculate position
        0.upto(number_of_tiles_tall.pred) do |row|
          # print "row #{row.next}: "

          0.upto(number_of_tiles_across.pred) do |column|
              tile_number = "#{(number_of_tiles_tall * row) + (column.next) }"
              # print tile_number

              path = "#{ tiles[:absolute_directory] }/#{ tiles[:base_file_name] }-#{ tile_number }#{ tiles[:extension_type] }"
              bit = Image.new(image: File.open(path))
              
              # use the image's original position, and offset tiles to stitch together as a whole
              # since we have not yet saved image, the tile's height + width is not available
              # so we are calc'ing the offset amounts. 
              # TODO: fix off by one pixel errors on odd number 
              bit.position_x = @source_bit.position_x + (column.next *  (image.dimensions[:x].to_i / number_of_tiles_across))
              bit.position_y = @source_bit.position_y + (row.next * (image.dimensions[:y].to_i / number_of_tiles_tall))

              p = bit.parallels.build(map_id: @map.id)  
              bit.save

              @bits << bit

          end
          # puts ""
        end

      # cleanup
      @source_bit.destroy
      FileUtils.rm_rf(tiles[:relative_directory])

      respond_to do |format|
        format.js { render :layout => false }
      end
      
    else
      # couldnt tile images. raise error? 
      false
    end    


  end





end
