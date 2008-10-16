module ProjectsHelper
  
  def sub_menu_items(project)
    menu_items
    menu_items = []
    menu_items << {:title => "Aufgaben", :icon => "table", :url => project_tasks_path(project), :controller => :tasks}
    menu_items << {:title => "Arbeitszeiten", :icon => "clock", :url => project_worktimes_path(project), :controller => :tasks}
  
    menu_items
  end
  
  def sub_menu_links(project)
    @output = []
    sub_menu_items(project).each do |item|
      link_style = params[:controller].to_s == item[:controller].to_s ? "active_link" : ""
      
      title = item[:title]
      if(item[:icon])
        title = icon_tag(item[:icon])
        title += " #{item[:title]}"
      end
      
      @output << (link_to title, item[:url], {:class => link_style})
    end
    @output.join(" | ")
  end
  
end
