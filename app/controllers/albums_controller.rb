class AlbumsController < ApplicationController

  before_filter :set_page
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy, :sort]

  # GET /albums
  # GET /albums.xml
  def index
    @albums = current_account.albums.find(:all, :order => 'position')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = current_account.albums.find(params[:id])
    @page_title = @album.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = current_account.albums.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = current_account.albums.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = current_account.albums.new(params[:album])

    respond_to do |format|
      if @album.save
        flash[:notice] = 'album was successfully created.'
        format.html { redirect_to( :action => 'edit', :id => @album.id) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = current_account.albums.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'album was successfully updated.'
        format.html { redirect_to(@album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = current_account.albums.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end

  # sort albums or an album's photos
  def sort
    album_id = params[:id]  
    if album_id
      sort_album_photos(album_id)
    else
      sort_albums 
    end
  end

  protected

  # sort albums
  def sort_albums
    params[:album].each_with_index do |id, index|
      current_account.albums.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true    
  end

  # Sort an album's photos.
  def sort_album_photos(album_id)
    @album = current_account.albums.find(album_id) 
    @album.photos.each do |photo|
      photo.position = params['photo'].index(photo.id.to_s) + 1
      photo.save! 
    end
    render :nothing => true
  end

  protected

  def set_page
    @page = Page.new(:name => 'Albums', :permalink => 'albums')
  end
end
