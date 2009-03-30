class TasksController < ApplicationController
  before_filter :login_required
  before_filter :create_parent_tasks_list, :only => [:new, :edit]
  before_filter :project_required, :only => [:new, :create]

#  layout 'projects'

  # GET /tasks
  # GET /tasks.xml
  def index
    if params[:project_id]
      @project = current_project
      @tasks = @project.tasks
      @tags = @project.tasks.tag_counts.sort_by(&:name)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tasks }
      end
    else
      redirect_to :action => :all
    end
  end

  def all
    @tasks = Task.all
  end

  def tagged
    @tag = params[:tag]
    @tasks = Task.find_tagged_with(@tag, :match_all => true)
    @project = Project.find(params[:project_id])
    @tags = @project.tasks.tag_counts.sort_by(&:name)
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @project = current_project
    @task = Task.new(:project_id => @project.id)
    @tags = Task.tag_counts.sort_by(&:name)

    if(@tag = params[:tag]) # tag wurde mitübergeben => schon mal setzen
      @task.tag_list.add(@tag)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
      format.js
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @projects = Project.active
    @tags = Task.tag_counts
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = t('flash.notice.task_created')
        format.html { redirect_to(project_tasks_path(@task.project)) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = t('flash.notice.task_updated')
        format.html { redirect_to(project_tasks_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = t('flash.notice.task_deleted')

    respond_to do |format|
      format.html { redirect_to(project_tasks_url(@task.project)) }
      format.xml  { head :ok }
      format.js
    end
  end

  protected

  def create_parent_tasks_list
    @tasks = [Task.new(:name => "Keine", :id => nil)]
    @tasks += current_project.tasks

    if params[:id]
      @tasks -= [Task.find(params[:id])] # alle tasks ausser aktuellem
    end
  end
end
