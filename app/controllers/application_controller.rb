# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2ece757ed96845e406e8423c414fbcbd'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  # authentication system überall verfügbar machen
  include AuthenticatedSystem
  include ApplicationHelper # u.a. für current_project

  before_filter :set_user_language

  def admin_required
    unless current_user.is_admin
      not_authorized
    end
  end

  def not_authorized(message = nil)
    respond_to do |format|
      format.html do
        flash[:error] = message || t('flash.error.no_access_rights')
        redirect_back_or_default("/")
      end
    end
  end

  def project_required
    unless Project.count > 0
      flash[:error] = t('flash.error.no_projects_available')
      redirect_to new_project_path
    end
  end

  def customer_required
    unless Customer.count > 0
      flash[:error] = t('flash.error.no_customers_available')
      redirect_to new_customer_path
    end
  end

  private
  def set_user_language
    I18n.locale = current_user.language if logged_in?
  end

end
