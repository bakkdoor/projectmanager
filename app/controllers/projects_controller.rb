class ProjectsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :except => [:index, :show]
  before_filter :customer_required, :only => [:new, :create]
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project.to_xml(:include => [:tasks, :worktimes]) }
    end
  end
  
  # GET /projects/active
  # Zeigt alle aktiven Projekte an 
  def active
    @projects = Project.active
    
    respond_to do |format|
      format.html # show active.html.erb
      format.xml { render :xml => @projects }
    end
  end
  
  def finished
    @projects = Project.finished
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @customers = Customer.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
      format.js
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @customers = Customer.find(:all)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Projekt wurde erfolgreich erstellt.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project wurde erfolgreich aktualisiert.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project erfolgreich gelöscht."
    
    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
      format.js
    end
  end
end
