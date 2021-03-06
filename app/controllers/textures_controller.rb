class TexturesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout "current_user"
  
  #before_filter :authenticate_admin!, :only => [:index, :show, :edit, :update]
  # GET /textures
  # GET /textures.json
  def index
    @textures = Texture.find(:all, :limit => 50, :order=> 'created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @textures }
    end
  end

  # GET /textures/1
  # GET /textures/1.json
  def show
    @texture = Texture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @texture }
    end
  end

  # GET /textures/new
  # GET /textures/new.json
  def new
    @texture = Texture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @texture }
    end
  end

  # GET /textures/1/edit
  def edit
    @texture = Texture.find(params[:id])
  end

  # POST /textures
  # POST /textures.json
  def create
    @texture = Texture.new(params[:texture])
    @texture.user = current_user
    
    respond_to do |format|
      if @texture.save
        format.js
        format.html { redirect_to @texture, :notice => 'Texture was successfully created.' }
        format.json { render :json => @texture, :status => :created, :location => @texture }
      else
        format.html { render :action => "new" }
        format.json { render :json => @texture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /textures/1
  # PUT /textures/1.json
  def update
    @texture = Texture.find(params[:id])

    respond_to do |format|
      if @texture.update_attributes(params[:texture])
        format.html { redirect_to @texture, :notice => 'Texture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @texture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /textures/1
  # DELETE /textures/1.json
  def destroy
    @texture = Texture.find(params[:id])
    @texture.destroy

    respond_to do |format|
      format.html { redirect_to textures_url }
      format.json { head :no_content }
    end
  end
end
