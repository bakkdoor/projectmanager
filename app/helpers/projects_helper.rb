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

  # return a project-selection combobox
  # if options[:container_id] is specified,
  # the content of that container will be replaced
  # by the given template/partial via options[:template]
  def project_selection_for(options = {})
    container_id = options[:container_id] || nil
    template = options[:template] || nil

    with = 'Form.Element.serialize(this)'

    # if container_id and template specified, also send this with the request
    if container_id and template
      with = "Form.Element.serialize(this) + " + "'&container_id=" + container_id + "&template=" + template + "'"
    end

    select_tag "project_id",
               options_for_select(Project.sorted.collect(&:for_selectbox),
                                  # selected option is current_project
                                  current_project.for_selectbox),
               { :onchange => remote_function(:url => {:controller => :projects, :action => 'get_project_data'},
                                              :with => with) }

  end

end
