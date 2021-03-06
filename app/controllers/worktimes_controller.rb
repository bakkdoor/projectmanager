class WorktimesController < ApplicationController
  before_filter :login_required
  before_filter :pre_update, :only => [:update]
  before_filter :pre_create, :only => [:create]
  before_filter :project_required, :only => [:new, :create]

#  layout 'projects'

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
      @worktime = Worktime.new
      @worktime.project = @project
      @tasks = [Task.new(:name => "Keine", :id => nil)]
      @tasks += Task.children

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @worktime }
        format.js
      end
    else
      flash[:error] = t('flash.error.project_ended')
      redirect_to project_worktimes_path(@project)
    end
  end

  # GET /worktimes/1/edit
  def edit
    @project = current_project
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
        flash[:notice] = t('flash.notice.worktime_created')
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

        flash[:notice] = t('flash.notice.worktime_updated')
        format.html { redirect_to(project_worktimes_path(@worktime.project)) }
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

    flash[:notice] = t('flash.notice.worktime_deleted')

    respond_to do |format|
      format.html { redirect_to(project_worktimes_path(@worktime.project)) }
      format.xml  { head :ok }
      format.js
    end
  end

  # neue arbeitszeit starten (via play-button)
  def start
    @project = current_project
    if request.post?
      @worktime = Worktime.new(:start_time => Time.now,
                                :end_time => Time.now,
                                :comment => "")
      @worktime.project = @project
      @worktime.user = current_user

      if @worktime.save
        session[:new_worktime_id] = @worktime.id
        flash[:notice] = t('flash.notice.worktime_started')
      else
        flash[:error] = t('flash.error.create_worktime')
      end
    end

    respond_to do |format|
      format.html { redirect_to project_worktimes_path(@project) }
      format.js
    end
  end

  def stop
    if request.post?
      if session[:new_worktime_id]
        if Worktime.exists?(session[:new_worktime_id])
          wt = Worktime.find(session[:new_worktime_id])
          @worktime = wt
          @project = @worktime.project
          if wt
            clear_session(:new_worktime_id)
            wt.end_time = Time.now # aktuelle zeit als endzeit setzen
            wt.save
            flash[:notice] = t('flash.notice.worktime_ended')

            respond_to do |format|
              format.html { redirect_to edit_project_worktime_url(wt.project, wt) }
              format.js
            end
          end
        else
          clear_session(:new_worktime_id)
          flash[:error] = t('flash.error.no_worktime_active')

          respond_to do |format|
            format.html { redirect_to project_worktimes_path(current_project) }
            format.js
          end
        end
      end
    end
  end

  protected

  def clear_session(session_key)
    session[session_key] = nil
  end

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
      @worktime.save
    end
  end

end
