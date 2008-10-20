module WorktimesHelper
  def play_pause_button(project)
    if session[:new_worktime_id]
        link_to("#{icon_tag('clock_stop')} Arbeitszeit beenden",
                {:controller => :worktimes, :action => :stop, :project_id => project.id},
                :method => :post, :title => "Arbeitszeit beenden", :class => "action_link")
    else
      link_to("#{icon_tag('clock_play')} Arbeitszeit starten",
              {:controller => :worktimes, :action => :start, :project_id => project.id},
              :method => :post, :title => "Arbeitszeit starten", :class => "action_link")
    end
  end
end