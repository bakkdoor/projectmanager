module MenuHelper

  def menu_items
    menu_items = []
    menu_items << {:title => "Home", :icon => "house", :url => root_path, :controller => :home}
    if logged_in?
      menu_items << { :title => t('words.customers'),
                      :icon => "user_suit",
                      :url => customers_path,
                      :controller => :customers }

      menu_items << { :title => t('words.projects'),
                      :icon => "layout_content",
                      :url => projects_path,
                      :controller => :projects }

#       if current_user.is_admin?

#         menu_items << { :title => t('words.tasks'),
#                         :icon => "table",
#                         :url => project_tasks_path(Project.sorted.first),
# #                        :url => all_tasks_path,
#                         :controller => :tasks }

#         menu_items << { :title => t('words.worktimes'),
#                         :icon => "time",
#                         :url => project_worktimes_path(Project.sorted.first),
# #                        :url => all_worktimes_path,
#                         :controller => :worktimes }
#      else
        menu_items << { :title => t('words.tasks'),
                        :icon => "table",
                        :url => project_tasks_path(current_user.accessible_projects.sorted.first),
                        :controller => :tasks }

        menu_items << { :title => t('words.worktimes'),
                        :icon => "time",
                        :url => project_worktimes_path(current_user.accessible_projects.sorted.first),
                        :controller => :worktimes }
#      end

      menu_items << { :title => t('words.employees'),
                      :icon => "group",
                      :url => users_path,
                      :controller => :users }
    end

    menu_items.each do |item|
      if item[:controller].to_s == params[:controller].to_s
        item[:selected] = true
      else
        item[:selected] = false
      end
    end
  end

  def menu_links
    @output = []
    menu_items.each do |item|
      link_style =  params[:controller].to_s == item[:controller].to_s ? "selected" : ""

      title = item[:title]
      if(item[:icon])
        title = icon_tag(item[:icon])
        title += " #{item[:title]}"
      end

      @output << (link_to title, item[:url], {:class => link_style})
    end
  end
end
