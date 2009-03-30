class ProjectsController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => [:new, :create, :update, :destroy]
  before_filter :customer_required, :only => [:new, :create]
  before_filter :has_access

  # GET /projects
  # GET /projects.xml
  def index
#    @projects = Project.find(:all)
    @projects = current_user.accessible_projects

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
 #   @projects = Project.active
    @projects = current_user.accessible_projects.active

    respond_to do |format|
      format.html # show active.html.erb
      format.xml { render :xml => @projects }
    end
  end

  def finished
#    @projects = Project.finished
    @projects = current_user.accessible_projects.finished

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
        flash[:notice] = t('flash.notice.project_created')
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
        flash[:notice] = t('flash.notice.project_updated')
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
    flash[:notice] = t('flash.notice.project_deleted')

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
      format.js
    end
  end

  def get_project_data
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html { redirect_to(projects_path(@project)) }
      format.js {
        render :update do |page|
          if params[:container_ids] and params[:templates]
            puts params[:container_ids].to_string_array
            params[:container_ids].to_string_array.each_with_index do |container_id, index|
              page[container_id].hide
              page[container_id].replace_html :partial => params[:templates].to_string_array[index], :object => @project
              page[container_id].visual_effect :appear
            end
          else
            page.redirect_to @project
          end
        end
      }
    end
  end

  protected

  # gibt an ob der aktuelle user zugriff hat
  # falls kein admin, nur zugriff, falls dem aktuellen projekt zugewiesen
  def has_access
    unless current_user.is_admin
      @project = Project.find(params[:id])
      if @project
        not_authorized unless current_user.assigned_to? @project
      else
        not_authorized
      end
    end
  end
end
