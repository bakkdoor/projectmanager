class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :admin_required, :only => [:index] # muss später geändert werden
  
  def index
    @users = User.all
  end
  
  def show
    if(User.exists?(params[:id]))
      @user = User.find(params[:id])
    else
      not_authorized("Zugriff nicht möglich.")
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
  
  def edit
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      not_authorized unless current_user.can_edit?(@user)
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
      redirect_back_or_default('/')
      flash[:notice] = "Neuer Mitarbeiter mit namen '#{@user.name}' angelegt."
    else
      flash[:error]  = "Nutzer-registrierung fehlgeschlagen. Bitte nochmal versuchen oder ggf. Admin kontaktieren."
      render :action => 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Profildaten wurden erfolgreich aktualisiert.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    if current_user.can_edit?(@user)
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    else
      not_authorized
    end
  end
end
