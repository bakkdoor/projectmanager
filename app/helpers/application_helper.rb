# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :controller => :home}
    if logged_in?
      menu_items << {:title => "Kunden", :controller => :customers}
      menu_items << {:title => "Projekte", :controller => :projects}
      menu_items << {:title => "Aufgaben", :controller => :tasks}
      menu_items << {:title => "Arbeitszeiten", :controller => :worktimes}
      
      if current_user.admin?
        menu_items << {:title => "Mitarbeiter", :controller => :users}
      end
    end
    
    menu_items
  end
  
  def german_months
    %w(Januar Februar März April Mai Juni Juli August September Oktober November Dezember)
  end
  
  def work_hours
    #(0..10).to_a
    hours = []
    hours << 0.0
    hours += (1.0..10.0).step(0.5).to_a
  end
end

# mixing in RubyEnhancements-module
class Object
	include ObjectEnhancement # see /lib
end
