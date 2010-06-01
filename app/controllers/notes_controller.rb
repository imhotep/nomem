class NotesController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required

  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.find(:all, :conditions => ["user_id = ?", params[:user_id]])
    @mobile = mobile_device?
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
      format.json  { 
        titles = {}
        @notes.each do |note|
          titles[note.id] = [note.title, note.body]
        end
        render :json => titles
      }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])
    if request.xhr?
      render :text => @note.body
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @note }
      end
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    @note.user_id = current_user.id
    respond_to do |format|
      if @note.save
        flash[:notice] = 'Note was successfully created.'
        format.html { redirect_to(@note) }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html {
          if request.xml_http_request?
            render :text => @note.body
          else
            flash[:notice] = 'Note was successfully updated.'
            redirect_to(@note)
          end
        }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        format.json  { render :json => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.xml  { head :ok }
    end
  end
end
