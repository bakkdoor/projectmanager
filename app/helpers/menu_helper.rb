module MenuHelper
  
  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :icon => "house", :url => root_path}
    if logged_in?
      if current_user.admin?
        menu_items << { :title => "Kunden",
                        :icon => "user_suit", 
                        :url => customers_path, 
                        :controller => :customers }
                        
        menu_items << { :title => "Projekte", 
                        :icon => "layout_content", 
                        :url => projects_path, 
                        :controller => :projects }
                        
        menu_items << { :title => "Aufgaben", 
                        :icon => "table", 
                        :url => all_tasks_path, 
                        :controller => :tasks }
                        
        menu_items << { :title => "Arbeitszeiten", 
                        :icon => "time", 
                        :url => all_worktimes_path, 
                        :controller => :worktimes }
                        
        menu_items << { :title => "Mitarbeiter", 
                        :icon => "group", 
                        :url => users_path, 
                        :controller => :users }
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
end