class WorktimesController < ApplicationController
  # GET /worktimes
  # GET /worktimes.xml
  def index
    @worktimes = Worktime.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worktimes }
    end
  end

  # GET /worktimes/1
  # GET /worktimes/1.xml
  def show
    @worktime = Worktime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @worktime }
    end
  end

  # GET /worktimes/new
  # GET /worktimes/new.xml
  def new
    @worktime = Worktime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worktime }
    end
  end

  # GET /worktimes/1/edit
  def edit
    @worktime = Worktime.find(params[:id])
  end

  # POST /worktimes
  # POST /worktimes.xml
  def create
    @worktime = Worktime.new(params[:worktime])
    @worktime.user = current_user
    
    # falls länge angegeben, end_date entsprechend überschreiben via @worktime.length=()
    length = params[:worktime][:length].to_f
    if(length > 0.0)
      @worktime.length = length
    end
    
    respond_to do |format|
      if @worktime.save
        flash[:notice] = 'Worktime was successfully created.'
        format.html { redirect_to(@worktime) }
        format.xml  { render :xml => @worktime, :status => :created, :location => @worktime }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @worktime.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /worktimes/1
  # PUT /worktimes/1.xml
  def update
    @worktime = Worktime.find(params[:id])

    respond_to do |format|
      if @worktime.update_attributes(params[:worktime])
        flash[:notice] = 'Worktime was successfully updated.'
        format.html { redirect_to(@worktime) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @worktime.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /worktimes/1
  # DELETE /worktimes/1.xml
  def destroy
    @worktime = Worktime.find(params[:id])
    @worktime.destroy

    respond_to do |format|
      format.html { redirect_to(worktimes_url) }
      format.xml  { head :ok }
    end
  end
end
