# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :controller => :home}
    menu_items << {:title => "Kunden", :controller => :customers}
    menu_items << {:title => "Projekte", :controller => :projects}
    menu_items << {:title => "Aufgaben", :controller => :tasks}
    menu_items << {:title => "Arbeitszeiten", :controller => :worktimes}
    
  end
end
