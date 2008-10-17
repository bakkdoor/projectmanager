# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # gibt das aktuelle projekt oder (falls nicht vorhanden) nil zurück.
  def current_project
    if params[:project_id]
      Project.find(params[:project_id])
    elsif params[:controller].to_s == "projects" && params[:id]
      Project.find(params[:id])
    else
      nil
    end
  end
    
  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :icon => "house", :url => root_path}
    if logged_in?
      menu_items << {:title => "Kunden", :icon => "user_suit", :url => customers_path, :controller => :customers}
      menu_items << {:title => "Projekte", :icon => "layout_content", :url => projects_path, :controller => :projects}
      menu_items << {:title => "Aufgaben", :icon => "table", :url => all_tasks_path, :controller => :tasks}
      menu_items << {:title => "Arbeitszeiten", :icon => "time", :url => all_worktimes_path, :controller => :worktimes}
      
      if current_user.admin?
        menu_items << {:title => "Mitarbeiter", :icon => "group", :url => users_path, :controller => :users}
      end
    end
    
    menu_items
  end
  
  def menu_links
    @output = []
    menu_items.each do |item|
      link_style =  params[:controller].to_s == item[:controller].to_s ? "active_link" : ""
      
      title = item[:title]
      if(item[:icon])
        title = icon_tag(item[:icon])
        title += " #{item[:title]}"
      end
      
      @output << (link_to title, item[:url], {:class => link_style})
      #@output << " | "
    end
    @output.join(" | ")
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
  
  def icon_tag(icon_name)
    icon_name += icon_name.include?('png') ? "" : ".png"
    image_tag("icons/#{icon_name}", :border => 0)
  end
end

# mixing in RubyEnhancements-module
class Object
	include ObjectEnhancement # see /lib
end

class String
  include StringEnhancement # see /lib
end

class Time
  include TimeEnhancement # see /lib
end

class Date
  include TimeEnhancement # see /lib
end

class Float
  include FloatEnhancement # see /lib
end