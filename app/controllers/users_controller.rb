class UsersController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, :only => [:new, :create, :destroy]
  
  def index
    @users = User.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml do 
        render :xml => @users.to_xml(
          :except => [:salt, :is_admin, :password, :crypted_password, :remember_token, :remember_token_expires_at, :created_at, :updated_at]
        )
      end
    end
  end
  
  def show
    if(User.exists?(params[:id]))
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml do 
          render :xml => @user.to_xml(
            :except => [:salt, :is_admin, :password, :crypted_password, :remember_token, :remember_token_expires_at, :created_at, :updated_at]
          )
        end
      end
    else
      not_authorized("Zugriff nicht möglich.")
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
    
    not_authorized unless current_user.is_admin
  end
  
  def edit
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      not_authorized unless current_user.can_edit? @user
    else
      not_authorized
    end
  end
 
  def create
    #logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      
      # falls erster angemeldeter user => admin rechte.
      if User.count == 1
        @user.is_admin = true
        @user.save
      end
      
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_user = @user # !! now logged in
      #redirect_back_or_default('/')
      redirect_to users_path
      flash[:notice] = "Neuer Mitarbeiter mit namen '#{@user.name}' angelegt."
    else
      flash[:error]  = "Nutzer-registrierung fehlgeschlagen. Bitte nochmal versuchen oder ggf. Admin kontaktieren."
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if current_user.can_edit?(@user)
      respond_to do |format|
        if @user.update_attributes(params[:user])
          if(is_admin = params[:user][:is_admin])
            @user.is_admin = is_admin
            @user.save
          end
          flash[:notice] = 'Profildaten wurden erfolgreich aktualisiert.'
          format.html { redirect_to users_path }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      not_authorized
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    if current_user.can_edit?(@user)
      @user.destroy
      flash[:notice] = "Mitarbeiter erfolgreich gelöscht."
      
      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
        format.js
      end
    else
      not_authorized
    end
  end
end
