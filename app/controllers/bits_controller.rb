class BitsController < ApplicationController

  #TODO: prevent save of bit position below 0/0

  protect_from_forgery

  def index
    @bits = Bit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bits }
    end
  end


  def show
    @bit = Bit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bit }
    end
  end


  def new
    @bit = Bit.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bit }
    end
  end


  def edit
    @bit = Bit.find(params[:id])

    respond_to do |format|
      format.js
      format.html 
    end
  end


  def create

    debugger

    if params[:image]
      @bit = Image.new(params[:bit])
    else # must be text
      @bit = Text.new(params[:bit])
    end


    respond_to do |format|
      if @bit.save
        format.json { render json: @bit, status: :created, location: @bit }
        format.js
      else
        format.json { render json: @bit.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @bit = Bit.find(params[:id])
    
    # what are we updating?
    # from the form, update only the content param
    # TODO: refactor, better way to test for form submit?
    if params[:commit] == "Save"
      update_hash = { :content => params[:bit][:content] } 

    #  probably bit:drag, so update the position
    elsif params[:x] && params[:y]
      update_hash = { :location_x => params[:x], :location_y => params[:y] }
    end    

    respond_to do |format|
      if @bit.update_attributes(update_hash)
        format.json { render json: @bit }
        format.js

      else
        format.json { render json: @bit.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @bit = Bit.find(params[:id])
    @bit.destroy

    respond_to do |format|
      format.html { redirect_to bits_url }
      format.json { head :no_content }
    end
  end






end
