class WorktimesController < ApplicationController
  before_filter :login_required
  before_filter :pre_update, :only => [:update]
  before_filter :pre_create, :only => [:create]
  before_filter :project_required, :only => [:new, :create]
  
  layout 'projects'
  
  # GET /worktimes
  # GET /worktimes.xml
  def index
    if params[:project_id]
      @project = current_project
      @worktimes = @project.worktimes
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @worktimes }
      end
    else
      redirect_to :action => "all"      
    end
  end
  
  def all
    @worktimes = Worktime.all
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
    @project = current_project
    unless @project.finished
      @worktime = Worktime.new(:project_id => @project.id)
      @tasks = [Task.new(:name => "Keine", :id => nil)]
      @tasks += Task.children

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @worktime }
      end
    else
      flash[:error] = "Projekt wurde beendet. Ist derzeit nicht aktiv."
      redirect_to project_worktimes_path(@project)
    end
  end

  # GET /worktimes/1/edit
  def edit
    @worktime = Worktime.find(params[:id])
    @tasks = Task.children - @worktime.tasks
  end

  # POST /worktimes
  # POST /worktimes.xml
  def create
    @worktime = Worktime.new(params[:worktime])
    @worktime.user = current_user
    @worktime.project = current_project
    #@worktime.tasks += @tasks # ausgewählte tasks zuordnen
    check_length # evtl. laenge anpassen
    
    respond_to do |format|
      if @worktime.save
        flash[:notice] = 'Arbeitszeit erfolgreich erstellt.'
        format.html { redirect_to(project_worktimes_path(@worktime.project)) }
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
    respond_to do |format|
      if @worktime.update_attributes(params[:worktime])
        #@worktime.tasks += @tasks # ausgewählte tasks zuordnen
        check_length # evtl. laenge anpassen
        
        flash[:notice] = 'Arbeitszeit erfolgreich aktualisiert.'
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
      format.html { redirect_to(project_worktimes_url) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
  
  def pre_update
    @worktime = Worktime.find(params[:id])
    
    check_tasks(@worktime)
  end
  
  def pre_create
    check_tasks
  end
  
  def check_tasks(worktime = nil)
    # gucken ob tasks angegeben wurden, falls ja, diese merken und anschließend eintragen
    @tasks = []
    if(params[:worktime][:tasks])
      params[:worktime][:tasks].split(" ").each do |task_id|
        @tasks << Task.find(task_id)
      end
      # falls worktime gegeben, nimm dessen tasks zusammen mit den neuen, sonst nur neue
      params[:worktime][:tasks] = worktime ? worktime.tasks + @tasks : @tasks
    end
  end
  
  # prüft übergebenes length-attribut und setzt es entsprechend, falls gegeben
  def check_length
    # falls länge angegeben, end_date entsprechend überschreiben via @worktime.length=()
    length = params[:worktime][:length].to_f
    if(length > 0.0)
      @worktime.length = length
    end
  end
  
end
