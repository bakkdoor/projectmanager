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
  
  def admin_required
    unless current_user.is_admin
      not_authorized
    end
  end
  
  def not_authorized(message = nil)
    flash[:error] = message || "Sie haben leider keine Zugriffsrechte."
    redirect_back_or_default("/")
  end
  
  def project_required
    unless Project.count > 0
      flash[:error] = "Keine Projekte vorhanden. Bitte erst eins anlegen."
      redirect_to new_project_path
    end
  end
  
  def customer_required
    unless Customer.count > 0
      flash[:error] = "Keine Kunden vorhanden. Bitte erst einen Kunden anlegen."
      redirect_to new_customer_path
    end
  end
  
end
