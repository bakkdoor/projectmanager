# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :icon => "house.png", :controller => :home}
    if logged_in?
      menu_items << {:title => "Kunden", :icon => "user_suit.png", :controller => :customers}
      menu_items << {:title => "Projekte", :icon => "layout_content.png", :controller => :projects}
      menu_items << {:title => "Aufgaben", :icon => "table.png", :controller => :tasks}
      menu_items << {:title => "Arbeitszeiten", :icon => "clock.png", :controller => :worktimes}
      
      if current_user.admin?
        menu_items << {:title => "Mitarbeiter", :icon => "group.png", :controller => :users}
      end
    end
    
    menu_items
  end
  
  def menu_links
    @output = []
    menu_items.each do |item|
      link_style = params[:controller].to_s == item[:controller].to_s ? "active_link" : ""
      
      title = item[:title]
      if(item[:icon])
        title = image_tag("icons/#{item[:icon]}", :border => 0)
        title += " #{item[:title]}"
      end
      
      @output << (link_to title, {:controller => item[:controller], :action => :index}, {:class => link_style})
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
end

# mixing in RubyEnhancements-module
class Object
	include ObjectEnhancement # see /lib
end
