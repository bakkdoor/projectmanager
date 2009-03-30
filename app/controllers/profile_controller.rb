class ProfileController < ApplicationController
  before_filter :login_required
  before_filter :set_user

  def index
  end

  def edit
  end

  def update
    respond_to do |format|
       if @user.update_attributes(params[:user])
         flash[:notice] = t('flash.notice.profile_updated')
         format.html { redirect_to(@user) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
     end
  end


  protected

  def set_user
    @user = current_user
  end
end
