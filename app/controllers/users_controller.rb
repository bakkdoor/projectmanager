class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :admin_required, :except => [:new, :create, :show] # muss später geändert werden
  
  def index
    @users = User.all
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Danke für die Anmeldung."
    else
      flash[:error]  = "Nutzer-registrierung fehlgeschlagen. Bitte nochmal versuchen oder ggf. Admin kontaktieren."
      render :action => 'new'
    end
  end
  
  def show
    if(User.exists?(params[:id]))
      @user = User.find(params[:id])
    else
      not_authorized("Zugriff nicht möglich.")
    end
  end
end
