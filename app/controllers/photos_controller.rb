class PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => 'create'
  before_filter :require_user, :set_page 

  # GET /photos
  # GET /photos.xml
  def index
    @photos = current_account.photos.find(:all)

    respond_to do |format|
      format.js do
        render :update do |page|
          page["#uploaded_images_list"].html(render(:partial => 'show_image_list', :locals => { :images => @photos }))
        end
      end
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = current_account.photos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = current_account.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = current_account.photos.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = current_account.photos.new(params[:photo])

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html do
          if params[:for_album]
            responds_to_parent do
              render :update do |page|
                page["#upload_form"].remove()
                page["#photo_list_#{@photo.album.id}"].append(render(:partial => 'albums/photo', :object => @photo))
              end
            end
          else
            redirect_to(@photo)
          end
        end
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = current_account.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = current_account.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
      format.js do
        render :update do |page|
          page["#photo_#{@photo.id}"].fadeOut()
        end
      end
    end
  end

  def set_page
    @page = Page.new(:name => 'Photos', :permalink => 'photos')
  end
end
